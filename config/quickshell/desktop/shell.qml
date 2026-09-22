import QtQuick
import Quickshell
import "Bar"
import "Dashboard"
import "Launcher"
import "ControlCenter"
import "Notifications"
import "Clipboard"
import "Session"

ShellRoot {
    Bar {}
    Dashboard {}
    Launcher {}
    ControlCenter {}
    Notifications {}
    ClipboardPanel {}
    SessionMenu {}
}
