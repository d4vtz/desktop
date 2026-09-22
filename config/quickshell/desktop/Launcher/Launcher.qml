import QtQuick
import QtQuick.Controls
import Quickshell
import ".."

Scope {
    id: root
    property bool shown: false

    IpcHandler {
        target: "launcher"
        function toggle(): void {
            root.shown = !root.shown
        }
    }

    PanelWindow {
        visible: root.shown
        color: "#99000000"
        exclusiveZone: 0

        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }

        Rectangle {
            width: 680
            height: 180
            anchors.centerIn: parent
            radius: 18
            color: Theme.base
            border.color: Theme.surface1

            TextField {
                id: search
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 22
                placeholderText: "Buscar aplicación o ejecutar comando…"

                Keys.onEscapePressed: root.shown = false

                onAccepted: {
                    if (text.length > 0) {
                        Quickshell.execDetached(["sh", "-lc", text])
                        root.shown = false
                        text = ""
                    }
                }
            }

            Text {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 35
                text: "Enter ejecuta · Esc cierra"
                color: Theme.subtext
            }
        }
    }
}
