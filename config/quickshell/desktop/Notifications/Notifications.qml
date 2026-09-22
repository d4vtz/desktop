import QtQuick
import Quickshell
import Quickshell.Services.Notifications
import ".."
Scope {
 NotificationServer {
  id:server
  bodySupported:true; imageSupported:true; actionsSupported:true; keepOnReload:true
  onNotification: notification => notification.tracked=true
 }
 Variants {
  model:server.trackedNotifications
  PanelWindow {
   required property var modelData
   anchors { top:true; right:true }; margins { top:52; right:10 }; implicitWidth:360; implicitHeight:110; color:"transparent"; exclusiveZone:0
   Rectangle {
    anchors.fill:parent; radius:14; color:Theme.base; border.color:Theme.surface1
    Column {
     anchors { fill:parent; margins:12 }
     Text { text:modelData.appName||"Notificación"; color:Theme.blue; font.bold:true }
     Text { text:modelData.summary; color:Theme.text; width:parent.width; elide:Text.ElideRight }
     Text { text:modelData.body; color:Theme.subtext; width:parent.width; wrapMode:Text.WordWrap; maximumLineCount:2 }
    }
   }
  }
 }
}
