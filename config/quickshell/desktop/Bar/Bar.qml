import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import ".."

Variants {
    model: Quickshell.screens

    PanelWindow {
        required property var modelData

        screen: modelData
        implicitHeight: 42
        color: "transparent"

        anchors {
            top: true
            left: true
            right: true
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
                            color: Hyprland.focusedWorkspace && Hyprland.focusedWorkspace.id === index + 1
                                ? Theme.blue
                                : Theme.surface0

                            Text {
                                anchors.centerIn: parent
                                text: index + 1
                                color: parent.color === Theme.blue ? Theme.crust : Theme.text
                                font.family: Theme.mono
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: Hyprland.dispatch("workspace " + (index + 1))
                            }
                        }
                    }
                }

                Item {
                    Layout.fillWidth: true
                }

                Text {
                    id: clock
                    color: Theme.text
                    font.family: Theme.font
                    text: Qt.formatDateTime(new Date(), "ddd dd MMM  HH:mm")

                    Timer {
                        interval: 1000
                        repeat: true
                        running: true
                        onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd dd MMM  HH:mm")
                    }
                }

                Item {
                    Layout.fillWidth: true
                }

                Text {
                    id: status
                    color: Theme.text
                    font.family: Theme.mono
                    text: "󰕾 --%   󰁹 --%"

                    Process {
                        id: statusProcess
                        command: [
                            "sh",
                            "-c",
                            "v=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{printf \"%d\", $2*100}'); b=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1); printf '󰕾 %s%%   󰁹 %s%%' \"$v\" \"$b\""
                        ]

                        stdout: StdioCollector {
                            onStreamFinished: status.text = text.trim()
                        }
                    }

                    Timer {
                        interval: 3000
                        repeat: true
                        running: true
                        triggeredOnStart: true
                        onTriggered: statusProcess.running = true
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: Quickshell.execDetached([
                            "qs", "ipc", "call", "controlCenter", "toggle"
                        ])
                    }
                }
            }
        }
    }
}
