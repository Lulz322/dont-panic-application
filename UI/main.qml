import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.0
import QtQuick.Shapes 1.15
import QtQuick.Layouts 1.1
import QtQuick.Timeline 1.1
import QtQml

import Back

import "Styles"

Window  {
	id: root
	width: 400
	height: 800
	visible: true
	title: qsTr("Hello World")
	color: "transparent"

	flags: Qt.FramelessWindowHint | Qt.Window | Qt.WindowTitleHint


	ApplicationController{
		id: appController

	}

	Rectangle{
		color: "#000423"
		anchors.fill: parent
		radius: 12

		Image{
			width: 150
			height: 150
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.top: parent.top
			anchors.topMargin: 50
			source: "qrc:/images/Assets/images/logo.png"
		}
	}

	ToolBar {
			id: settings
			width: root.width
			height: 38

			background: Rectangle {
				color: "transparent"
			}

			MouseArea {
				anchors.fill: parent

				property variant clickPos: "1,1"

				onPressed: {
					clickPos = Qt.point(mouse.x, mouse.y)
//					systemController.releaseHook()
				}

				onReleased: {
//					systemController.setHook()
				}

				onPositionChanged: {
					var delta = Qt.point(mouse.x - clickPos.x, mouse.y - clickPos.y)
					root.x += delta.x
					root.y += delta.y

					showNormal()
				}

				onDoubleClicked: {
					if (visibility == 5)
						showNormal()
					else
						showMaximized()
				}
			}

			ToolBarButton {
				id: exit1
				anchors.right: parent.right
				anchors.top: parent.top
				Shape{
					anchors.fill: parent
					anchors.leftMargin: 15
					anchors.rightMargin: 17
					anchors.topMargin: 10
					anchors.bottomMargin: 5
					ShapePath{
						startX: 3
						startY: 3
						fillColor: "transparent"
						strokeColor: exit1.active ? "white" : "#7A7A7A"
						strokeStyle: ShapePath.SolidLine
						strokeWidth: 2
						PathLine {x: 14; y: 14;}
						PathMove {x: 14; y: 3;}
						PathLine {x: 3; y: 14;}
					}
				}
				onClicked: close()
			}

			ToolBarButton {
				id: fullscreen
				anchors.right: exit1.left
				anchors.top: parent.top
				Rectangle{
					anchors.fill: parent
					anchors.leftMargin: 18
					anchors.rightMargin: 18
					anchors.topMargin: 12
					anchors.bottomMargin: 7
					border.color:  fullscreen.active ? "white" : "#7A7A7A"
					border.width: 2
					color: "#000423"
				}
				Rectangle{
					anchors.fill: parent
					anchors.leftMargin: 15
					anchors.rightMargin: 21
					anchors.topMargin: 15
					anchors.bottomMargin: 4
					border.color:  fullscreen.active ? "white" : "#7A7A7A"
					border.width: 2
					color: "#000423"
				}
				onClicked: {
					if (visibility == 2)
						visibility = 4
					else
						visibility = 2
				}
			}
			ToolBarButton {
				id: minimize
				anchors.right: fullscreen.left
				anchors.top: parent.top
				Shape{
					anchors.fill: parent
					anchors.leftMargin: 15
					anchors.rightMargin: 17
					anchors.topMargin: 10
					anchors.bottomMargin: 5
					ShapePath{
						startX: 3
						startY: 14
						strokeColor: minimize.active ? "white" : "#7A7A7A"
						strokeStyle: ShapePath.SolidLine
						strokeWidth: 2
						PathLine {x: 13; y: 14;}
					}
				}
				onClicked: showMinimized()
			}
		}


	Timeline {
		id: startup
		animations: [
			TimelineAnimation {
				id: startupAnimation
				pingPong: false
				loops: 1
				duration: 3000
				running: true
				to: 3000
				from: 0
			}
		]
		enabled: true
		startFrame: 0
		endFrame: 3000

//		KeyframeGroup {
//			target: root
//			property: "height"
//			Keyframe {
//				value: 400
//				frame: 0
//			}

//			Keyframe {
//				value: 800
//				frame: 3000
//			}
//		}

//		KeyframeGroup {
//			target: root
//			property: "x"
//			Keyframe {
//				value: Screen.width / 2 - width / 2 - 1920
//				frame: 0
//			}

//			Keyframe {
//				value: Screen.width / 2 - width / 2 - 1920
//				frame: 360
//			}
//		}

//		KeyframeGroup {
//			target: root
//			property: "y"
//			Keyframe {
//				value: Screen.height / 2 - height / 2
//				frame: 0
//			}

//			Keyframe {
//				value: Screen.height / 2 - height / 2
//				frame: 360
//			}
//		}
	}

	Connections{
		target: appController
		function onError(errorText){
			console.debug("Yo", errorText);
			createBottomError(errorText)
		}
	}

	function createBottomError(errorText){
		console.debug("123")
		var component = Qt.createComponent("Styles/BottomError.qml");

		if (component.status === Component.Ready) {
			component.createObject(root, {visible: true, "errorText": errorText});
		}else if (component.status == Component.Error) {
			// Error Handling
			console.log("Error loading component:", component.errorString());
		}

	}



	Loader {
			id: mainLoader
			anchors.fill: parent


			onSourceChanged: {
				animation.running = true
			}


			NumberAnimation {
				id: animation
				target: mainLoader.item
				property: "opacity"
				from: 0
				to: 1
				duration: 350
				easing.type: Easing.InOutQuad
			}

			source: "StartupWindows/LoginScreen.qml"
		}


}

/*##^##
Designer {
	D{i:0;formeditorZoom:0.33}D{i:2}D{i:1}D{i:5}D{i:8}D{i:7}D{i:6}D{i:13}D{i:14}D{i:12}
D{i:17}D{i:16}D{i:15}D{i:3}
}
##^##*/
