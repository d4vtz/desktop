import QtQuick
import Quickshell
import Quickshell.Io
import ".."
Scope {
 id:root; property bool shown:false; property string history:""
 IpcHandler { target:"clipboard"; function toggle():void { root.shown=!root.shown; if(root.shown) hist.running=true } }
 Process { id:hist; command:["cliphist","list"]; stdout:StdioCollector { onStreamFinished:root.history=text } }
 PanelWindow {
  visible:root.shown; anchors { top:true; right:true }; margins { top:48; right:10 }; implicitWidth:520; implicitHeight:480; color:"transparent"; exclusiveZone:0
  Rectangle { anchors.fill:parent; radius:18; color:Theme.base; border.color:Theme.surface1
   Flickable { anchors { fill:parent; margins:18 }; contentHeight:t.implicitHeight; clip:true
    Text { id:t; width:parent.width; text:root.history||"Portapapeles vacío"; color:Theme.text; font.family:Theme.mono; wrapMode:Text.WrapAnywhere }
   }
  }
 }
}
