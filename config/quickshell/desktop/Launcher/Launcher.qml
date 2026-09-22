import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import ".."
Scope {
 id:root; property bool shown:false
 IpcHandler { target:"launcher"; function toggle():void { root.shown=!root.shown } }
 PanelWindow {
  visible:root.shown; anchors { top:true; bottom:true; left:true; right:true }; color:"#99000000"; exclusiveZone:0
  Rectangle {
   width:680; height:180; anchors.centerIn:parent; radius:18; color:Theme.base; border.color:Theme.surface1
   TextField {
    id:search; anchors { left:parent.left; right:parent.right; top:parent.top; margins:22 }; placeholderText:"Buscar aplicación o ejecutar comando…"
    Keys.onEscapePressed:root.shown=false
    onAccepted:{ if(text.length){ Quickshell.execDetached(["sh","-lc",text]); root.shown=false; text="" } }
   }
   Text { anchors.centerIn:parent; anchors.verticalCenterOffset:35; text:"Enter ejecuta · Esc cierra"; color:Theme.subtext }
  }
 }
}
