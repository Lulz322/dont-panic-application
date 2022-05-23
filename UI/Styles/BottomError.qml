import QtQuick
import QtQuick.Shapes
import QtQuick.Timeline 1.0



Rectangle {
	id: errorRect
	required property string errorText


	width: parent.width
	height: 0

	anchors.bottom: parent.bottom
	radius: 12

	color: "#770101"

	DefaultText{
		anchors.centerIn: parent
		text: errorRect.errorText
		font.pixelSize: 18
		height: parent.height
		width: parent.width * .9
		wrapMode: Text.WrapAtWordBoundaryOrAnywhere
		horizontalAlignment: Text.AlignHCenter
		visible: {
			var qwe = height > contentHeight
			return qwe
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
		onClicked: {
			bottomCloseAnimation.start()
		}
	}

	Timer{
		id: bottomErrorTimer
		interval: 5000
		running: true
		repeat: false
		onTriggered: bottomCloseAnimation.start()
	}

	Timeline {
		id: errorAnimation
		animations: [
			TimelineAnimation {
				id: bottomErrorAnimation
				loops: 1
				duration: 500
				running: true
				to: 3000
				from: 0
			}
		]
		startFrame: 0
		endFrame: 3000
		enabled: true

		KeyframeGroup {
			target: errorRect
			property: "height"
			Keyframe {
				frame: 0
				value: 0
			}

			Keyframe {
				frame: 3000
				value: errorRect.parent.height * .1
			}
		}
	}

	Timeline {
		id: closeAnimation
		animations: [
			TimelineAnimation {
				id: bottomCloseAnimation
				loops: 1
				duration: 2000
				running: false
				to: 3000
				from: 0
			}
		]
		startFrame: 0
		endFrame: 3000
		enabled: true

		KeyframeGroup {
			target: errorRect
			property: "height"
			Keyframe {
				frame: 0
				value: errorRect.height
			}

			Keyframe {
				frame: 3000
				value: 0
			}
		}

		KeyframeGroup {
			target: errorRect
			property: "opacity"
			Keyframe {
				frame: 0
				value: 1
			}

			Keyframe {
				frame: 3000
				value: 0
			}
		}
	}



}
