import QtQuick
import Quickshell
import Quickshell.Services.Notifications
import ".."

Scope {
    id: root

    NotificationServer {
        id: server

        bodySupported: true
        imageSupported: true
        actionsSupported: true
        keepOnReload: true

        onNotification: notification => {
            notification.tracked = true
        }
    }

    Variants {
        model: server.trackedNotifications

        PanelWindow {
            required property var modelData

            implicitWidth: 380
            implicitHeight: 110
            color: "transparent"
            exclusiveZone: 0

            anchors {
                top: true
                right: true
            }

            margins {
                top: 52
                right: 10
            }

            Rectangle {
                anchors.fill: parent
                radius: 16
                color: Theme.base
                border.color: Theme.surface1
                border.width: 1

                Column {
                    anchors.fill: parent
                    anchors.margins: 14
                    spacing: 6

                    Text {
                        width: parent.width
                        text: modelData.summary
                        color: Theme.text
                        font.bold: true
                        elide: Text.ElideRight
                    }

                    Text {
                        width: parent.width
                        text: modelData.body
                        color: Theme.subtext
                        wrapMode: Text.Wrap
                        maximumLineCount: 3
                        elide: Text.ElideRight
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: modelData.dismiss()
                }
            }
        }
    }
}
