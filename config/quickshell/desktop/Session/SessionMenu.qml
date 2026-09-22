import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Ipc

Scope {
    id: root
    property bool shown: false

    IpcHandler {
        target: "session"
        function toggle(): void {
            root.shown = !root.shown
        }
    }

    PanelWindow {
        visible: root.shown
        color: "#aa11111b"
        exclusiveZone: 0

        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }

        RowLayout {
            anchors.centerIn: parent
            spacing: 14

            Repeater {
                model: [
                    ["Bloquear", "hyprlock"],
                    ["Suspender", "systemctl suspend"],
                    ["Salir", "uwsm stop"],
                    ["Reiniciar", "systemctl reboot"],
                    ["Apagar", "systemctl poweroff"]
                ]

                Button {
                    required property var modelData
                    text: modelData[0]
                    implicitWidth: 125
                    implicitHeight: 70
                    onClicked: Quickshell.execDetached(["sh", "-c", modelData[1]])
                }
            }
        }
    }
}
