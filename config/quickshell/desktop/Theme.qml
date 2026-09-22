pragma Singleton
import QtQuick

QtObject {
    // Material 3-style tokens. Fixed dark palette for now; later these can
    // be populated by wallpaper-derived colors without changing components.
    readonly property color primary: "#cbbdff"
    readonly property color primaryForeground: "#30275a"
    readonly property color primaryContainer: "#4a416f"
    readonly property color primaryContainerForeground: "#e7deff"

    readonly property color surface: "#121116"
    readonly property color surfaceContainer: "#1b1a20"
    readonly property color surfaceContainerHigh: "#252329"
    readonly property color surfaceContainerHighest: "#302e35"
    readonly property color foreground: "#e7e1e9"
    readonly property color foregroundVariant: "#cac4cf"
    readonly property color outline: "#938f99"
    readonly property color error: "#ffb4ab"

    // Compatibility aliases while older modules are migrated.
    readonly property color base: surface
    readonly property color crust: primaryForeground
    readonly property color surface0: surfaceContainer
    readonly property color surface1: surfaceContainerHigh
    readonly property color text: foreground
    readonly property color subtext: foregroundVariant
    readonly property color blue: primary
    readonly property color red: error

    readonly property string font: "Noto Sans"
    readonly property string mono: "JetBrainsMono Nerd Font"

    readonly property int spacingXS: 4
    readonly property int spacingS: 8
    readonly property int spacingM: 12
    readonly property int spacingL: 16
    readonly property int spacingXL: 24

    readonly property int radiusSmall: 8
    readonly property int radius: 14
    readonly property int radiusLarge: 22

    readonly property int iconSmall: 16
    readonly property int icon: 20
    readonly property int iconLarge: 28
}
