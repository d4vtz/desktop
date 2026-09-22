import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower
import Quickshell.Services.Mpris
import ".."

Scope {
    id: root
    property bool shown: false
    readonly property var sink: Pipewire.defaultAudioSink
    readonly property var battery: UPower.displayDevice

    IpcHandler {
        target: "dashboard"
        function toggle(): void { root.shown = !root.shown }
    }

    PwObjectTracker { objects: [sink] }
    SystemClock { id: clock; precision: SystemClock.Minutes }

    PanelWindow {
        visible: root.shown
        implicitWidth: 620
        implicitHeight: 430
        color: "transparent"
        exclusiveZone: 0

        anchors { top: true }
        margins { top: 52 }

        Rectangle {
            anchors.fill: parent
            radius: Theme.radiusLarge
            color: Theme.surface
            border.color: Theme.surfaceContainerHigh

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 14

                RowLayout {
                    Layout.fillWidth: true
                    Column {
                        Text { text: Qt.formatDateTime(clock.date, "dddd"); color: Theme.foreground; font.pixelSize: 26; font.bold: true }
                        Text { text: Qt.formatDateTime(clock.date, "d MMMM yyyy"); color: Theme.foregroundVariant; font.pixelSize: 13 }
                    }
                    Item { Layout.fillWidth: true }
                    Text { text: Qt.formatDateTime(clock.date, "h:mm AP"); color: Theme.primary; font.pixelSize: 28; font.bold: true }
                }

                RowLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 14

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        radius: Theme.radius
                        color: Theme.surfaceContainer
                        Column {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 8
                            Text { text: "Multimedia"; color: Theme.foregroundVariant; font.pixelSize: 12 }
                            Text { text: Mpris.players.values.length > 0 ? Mpris.players.values[0].trackTitle : "Sin reproducción"; color: Theme.foreground; font.pixelSize: 18; font.bold: true; width: parent.width; elide: Text.ElideRight }
                            Text { text: Mpris.players.values.length > 0 ? Mpris.players.values[0].trackArtist : ""; color: Theme.foregroundVariant; width: parent.width; elide: Text.ElideRight }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        radius: Theme.radius
                        color: Theme.surfaceContainer
                        Column {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 8
                            Text { text: "Sistema"; color: Theme.foregroundVariant; font.pixelSize: 12 }
                            Text { text: "󰕾  " + (sink && sink.audio ? Math.round(sink.audio.volume * 100) : 0) + "%"; color: Theme.foreground; font.family: Theme.mono; font.pixelSize: 18 }
                            Text { text: "󰁹  " + (battery && battery.ready ? Math.round(battery.percentage) : 0) + "%"; color: Theme.foreground; font.family: Theme.mono; font.pixelSize: 18; visible: battery && battery.isLaptopBattery }
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 72
                    radius: Theme.radius
                    color: Theme.surfaceContainer
                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 14
                        Text { text: "Accesos rápidos"; color: Theme.foreground; font.bold: true }
                        Item { Layout.fillWidth: true }
                        Text { text: "󰒓  Control Center"; color: Theme.primary; font.family: Theme.mono
                            MouseArea { anchors.fill: parent; onClicked: Quickshell.execDetached(["qs","ipc","call","controlCenter","toggle"]) }
                        }
                        Text { text: "󰅌  Portapapeles"; color: Theme.primary; font.family: Theme.mono
                            MouseArea { anchors.fill: parent; onClicked: Quickshell.execDetached(["qs","ipc","call","clipboard","toggle"]) }
                        }
                    }
                }
            }
        }
    }
}
