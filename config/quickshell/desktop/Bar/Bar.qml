import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower
import ".."

Variants {
    model: Quickshell.screens

    PanelWindow {
        required property var modelData

        readonly property var sink: Pipewire.defaultAudioSink
        readonly property var battery: UPower.displayDevice

        screen: modelData
        implicitHeight: 42
        color: "transparent"

        anchors {
            top: true
            left: true
            right: true
        }

        PwObjectTracker {
            objects: [sink]
        }

        SystemClock {
            id: clock
            precision: SystemClock.Minutes
        }

        Rectangle {
            anchors.fill: parent
            anchors.margins: 6
            anchors.bottomMargin: 0
            radius: Theme.radius
            color: Theme.base
            border.color: Theme.surface1
            border.width: 1

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 12
                anchors.rightMargin: 12
                spacing: 10

                Row {
                    spacing: 5

                    Repeater {
                        model: 7

                        Rectangle {
                            required property int index
                            width: 25
                            height: 25
                            radius: 8

                            readonly property var workspace: {
                                for (let i = 0; i < Hyprland.workspaces.count; ++i) {
                                    const ws = Hyprland.workspaces.get(i)
                                    if (ws.id === index + 1)
                                        return ws
                                }
                                return null
                            }

                            readonly property bool isFocused: Hyprland.focusedWorkspace
                                && Hyprland.focusedWorkspace.id === index + 1
                            readonly property bool isOccupied: workspace
                                && workspace.toplevels
                                && workspace.toplevels.count > 0

                            color: isFocused
                                ? Theme.blue
                                : isOccupied
                                    ? Theme.surface1
                                    : Theme.surface0

                            Text {
                                anchors.centerIn: parent
                                text: index + 1
                                color: parent.isFocused ? Theme.crust : Theme.text
                                font.family: Theme.mono
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    if (parent.workspace) {
                                        parent.workspace.activate()
                                    } else {
                                        Quickshell.execDetached([
                                            "hyprctl",
                                            "dispatch",
                                            "hl.dsp.focus({ workspace = \"" + (index + 1) + "\" })"
                                        ])
                                    }
                                }
                            }
                        }
                    }
                }

                Item {
                    Layout.fillWidth: true
                }

                Text {
                    color: Theme.text
                    font.family: Theme.font
                    text: Qt.formatDateTime(clock.date, "ddd dd MMM  HH:mm")
                }

                Item {
                    Layout.fillWidth: true
                }

                Row {
                    spacing: 12

                    Text {
                        readonly property bool muted: sink && sink.audio ? sink.audio.muted : false
                        readonly property int volume: sink && sink.audio
                            ? Math.round(sink.audio.volume * 100)
                            : 0

                        text: (muted ? "󰖁 " : volume >= 50 ? "󰕾 " : volume > 0 ? "󰖀 " : "󰕿 ")
                            + volume + "%"
                        color: muted ? Theme.subtext : Theme.text
                        font.family: Theme.mono

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (sink && sink.audio)
                                    sink.audio.muted = !sink.audio.muted
                            }
                            onWheel: wheel => {
                                if (!sink || !sink.audio)
                                    return
                                const step = wheel.angleDelta.y > 0 ? 0.05 : -0.05
                                sink.audio.volume = Math.max(0, Math.min(1.5, sink.audio.volume + step))
                            }
                        }
                    }

                    Text {
                        readonly property real percentage: battery && battery.ready
                            ? battery.percentage
                            : 0

                        text: "󰁹 " + Math.round(percentage) + "%"
                        color: Theme.text
                        font.family: Theme.mono
                        visible: battery && battery.isLaptopBattery
                    }
                }
            }
        }
    }
}
