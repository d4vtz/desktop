import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import ".."

Scope {
    id: root
    property bool shown: false

    IpcHandler {
        target: "controlCenter"
        function toggle(): void {
            root.shown = !root.shown
        }
    }

    PanelWindow {
        visible: root.shown
        implicitWidth: 390
        implicitHeight: 430
        color: "transparent"
        exclusiveZone: 0

        anchors {
            top: true
            right: true
        }

        margins {
            top: 48
            right: 10
        }

        Rectangle {
            anchors.fill: parent
            radius: 18
            color: Theme.base
            border.color: Theme.surface1

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 18
                spacing: 12

                Text {
                    text: "Control Center"
                    color: Theme.text
                    font.pixelSize: 20
                    font.bold: true
                }

                RowLayout {
                    Button {
                        text: "Wi-Fi"
                        onClicked: Quickshell.execDetached(["nmcli", "radio", "wifi", "on"])
                    }
                    Button {
                        text: "Bluetooth"
                        onClicked: Quickshell.execDetached(["bluetoothctl", "power", "on"])
                    }
                    Button {
                        text: "Audio"
                        onClicked: Quickshell.execDetached(["pavucontrol"])
                    }
                }

                Text {
                    text: "Volumen"
                    color: Theme.subtext
                }

                Slider {
                    Layout.fillWidth: true
                    from: 0
                    to: 100
                    value: 50
                    onMoved: Quickshell.execDetached([
                        "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", Math.round(value) + "%"
                    ])
                }

                Text {
                    text: "Brillo"
                    color: Theme.subtext
                }

                Slider {
                    Layout.fillWidth: true
                    from: 1
                    to: 100
                    value: 50
                    onMoved: Quickshell.execDetached([
                        "brightnessctl", "set", Math.round(value) + "%"
                    ])
                }

                Text {
                    text: "Perfil de energía"
                    color: Theme.subtext
                }

                RowLayout {
                    Button {
                        text: "Ahorro"
                        onClicked: Quickshell.execDetached(["powerprofilesctl", "set", "power-saver"])
                    }
                    Button {
                        text: "Balanceado"
                        onClicked: Quickshell.execDetached(["powerprofilesctl", "set", "balanced"])
                    }
                    Button {
                        text: "Rendimiento"
                        onClicked: Quickshell.execDetached(["powerprofilesctl", "set", "performance"])
                    }
                }

                Item {
                    Layout.fillHeight: true
                }

                Button {
                    Layout.fillWidth: true
                    text: "Sesión"
                    onClicked: Quickshell.execDetached([
                        "qs", "ipc", "call", "session", "toggle"
                    ])
                }
            }
        }
    }
}
