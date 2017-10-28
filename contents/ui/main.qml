import QtQuick 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras

Item {
  width: 150; height: 200
  
  ListModel {
    id: testModel
    ListElement { name: "Steam"; image: "steam.png"; exec: "kstart5 steam" }
    ListElement { name: "Teamspeak"; image: "teamspeak.png"; exec: "/home/mathias/Downloads/TeamSpeak3/ts3client_runscript.sh" }
    ListElement { name: "Skype"; image: "skype.png"; exec: "kstart5 skype" }
    ListElement { name: "Telegram"; image: "telegram.png"; exec: "/home/mathias/Downloads/Telegram/Telegram" }
    ListElement { name: "Krita"; image: "krita.png"; exec: "kstart5 krita" }
  }
  
  PlasmaCore.DataSource {
    id: executeSource
    engine: "executable"
    connectedSources: []
    onNewData: {
      disconnectSource(sourceName)
    }
  }
  
  ListView {
    id: mainList
    focus: true
    anchors.fill: parent
    model: testModel
    delegate: PlasmaComponents.ListItem {
      separatorVisible: true
      
      Image {
	id: thumbnail
	width: 30; height: 30
	anchors.left: parent.left
	anchors.verticalCenter: parent.verticalCenter
	
	source: "img/" + model.image
      }
      
      PlasmaComponents.Label {
	anchors.left: thumbnail.right
	anchors.right: parent.right
	anchors.leftMargin: 8
	anchors.verticalCenter: parent.verticalCenter
	height: 40
	
	elide: Text.ElideRight
	text: model.name
      }
      
      MouseArea {
	anchors.fill: parent
	onClicked: executeSource.connectSource(model.exec)
      }
    }
  }
}