import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower
import Quickshell.Networking
import Quickshell.Bluetooth
import Quickshell.Services.SystemTray
import ".."

Variants {
    model: Quickshell.screens

    PanelWindow {
        required property var modelData
        readonly property var sink: Pipewire.defaultAudioSink
        readonly property var battery: UPower.displayDevice

        screen: modelData
        implicitHeight: 48
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
            anchors.leftMargin: 8
            anchors.rightMargin: 8
            anchors.topMargin: 5
            anchors.bottomMargin: 3
            radius: Theme.radiusLarge
            color: Theme.surface
            border.color: Theme.surfaceContainerHigh
            border.width: 1

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: Theme.spacingS
                anchors.rightMargin: Theme.spacingS
                spacing: Theme.spacingS

                Rectangle {
                    implicitWidth: 38
                    implicitHeight: 32
                    radius: 16
                    color: Theme.surfaceContainerHigh

                    Text {
                        anchors.centerIn: parent
                        text: "󰣇"
                        color: Theme.primary
                        font.family: Theme.mono
                        font.pixelSize: 18
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: Quickshell.execDetached([
                            "qs", "ipc", "call", "launcher", "toggle"
                        ])
                    }
                }

                Row {
                    spacing: Theme.spacingXS

                    Repeater {
                        model: 7

                        Rectangle {
                            required property int index
                            width: isFocused ? 30 : 24
                            height: 24
                            radius: 12

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
                                ? Theme.primary
                                : isOccupied
                                    ? Theme.surfaceContainerHighest
                                    : "transparent"

                            Behavior on width {
                                NumberAnimation { duration: 140 }
                            }

                            Behavior on color {
                                ColorAnimation { duration: 140 }
                            }

                            Text {
                                anchors.centerIn: parent
                                text: index + 1
                                color: parent.isFocused ? Theme.primaryForeground : Theme.foregroundVariant
                                font.family: Theme.font
                                font.pixelSize: 12
                                font.bold: parent.isFocused
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

                Rectangle {
                    implicitWidth: clockText.implicitWidth + 24
                    implicitHeight: 32
                    radius: 16
                    color: clockMouse.containsMouse
                        ? Theme.surfaceContainerHigh
                        : Theme.surfaceContainer

                    Behavior on color {
                        ColorAnimation { duration: 120 }
                    }

                    Text {
                        id: clockText
                        anchors.centerIn: parent
                        text: Qt.formatDateTime(clock.date, "h:mm AP  ·  ddd d MMM")
                        color: Theme.foreground
                        font.family: Theme.font
                        font.pixelSize: 13
                        font.weight: Font.Medium
                    }

                    MouseArea {
                        id: clockMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: Quickshell.execDetached([
                            "qs", "ipc", "call", "dashboard", "toggle"
                        ])
                    }
                }

                Item {
                    Layout.fillWidth: true
                }

                Rectangle {
                    implicitWidth: systemRow.implicitWidth + 20
                    implicitHeight: 32
                    radius: 16
                    color: systemMouse.containsMouse
                        ? Theme.surfaceContainerHigh
                        : Theme.surfaceContainer

                    Behavior on color {
                        ColorAnimation { duration: 120 }
                    }

                    Row {
                        id: systemRow
                        anchors.centerIn: parent
                        spacing: 10

                        Repeater {
                            model: SystemTray.items

                            Item {
                                required property var modelData
                                width: 18
                                height: 22

                                Image {
                                    anchors.centerIn: parent
                                    width: 16
                                    height: 16
                                    source: modelData.icon
                                    fillMode: Image.PreserveAspectFit
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                                    onClicked: mouse => {
                                        if (mouse.button === Qt.RightButton)
                                            modelData.secondaryActivate()
                                        else
                                            modelData.activate()
                                    }
                                }
                            }
                        }

                        Text {
                            text: Networking.active ? "󰖩" : "󰖪"
                            color: Networking.active ? Theme.foreground : Theme.foregroundVariant
                            font.family: Theme.mono
                            font.pixelSize: 15
                        }

                        Text {
                            text: "󰂯"
                            color: Theme.foreground
                            font.family: Theme.mono
                            font.pixelSize: 15
                            visible: Bluetooth.defaultAdapter && Bluetooth.defaultAdapter.enabled
                        }

                        Text {
                            readonly property bool muted: sink && sink.audio ? sink.audio.muted : false
                            readonly property int volume: sink && sink.audio
                                ? Math.round(sink.audio.volume * 100)
                                : 0

                            text: muted ? "󰖁" : volume >= 50 ? "󰕾" : volume > 0 ? "󰖀" : "󰕿"
                            color: muted ? Theme.foregroundVariant : Theme.foreground
                            font.family: Theme.mono
                            font.pixelSize: 15

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
                            color: Theme.foreground
                            font.family: Theme.mono
                            font.pixelSize: 13
                            visible: battery && battery.isLaptopBattery
                        }
                    }

                    MouseArea {
                        id: systemMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        propagateComposedEvents: true
                        onClicked: Quickshell.execDetached([
                            "qs", "ipc", "call", "controlCenter", "toggle"
                        ])
                    }
                }
            }
        }
    }
}
