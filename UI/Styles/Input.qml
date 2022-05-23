import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3


Rectangle{
	id: mainInputRectangle
	property string placeholderText
	property string currentText
	property string errorText
	width: 150
	height: 32 + 6 + errText.height

	color: "transparent"

	Rectangle{
		id: iA
		width: parent.width
		anchors.left: parent.left
		color: Qt.rgba(0,0,0, 0.2)
		border.color: "#A1D2FF"
		height: 32
		radius: 3

		TextField{
			selectByMouse: true

			width: parent.width - 12
			height: parent.height
			anchors{
				left: parent.left
				leftMargin: 12
				right: parent.right
			}

			placeholderText: mainInputRectangle.placeholderText
			placeholderTextColor: Qt.rgba(255,255,255, 0.5)

			wrapMode: Text.NoWrap
			background: Rectangle{
				color: "transparent"
			}

			color: "white"
			font.family: "SeoulHangang CEB"
			font.pixelSize: 16

			Layout.fillWidth: true

			topPadding: height / 2 - font.pixelSize / 2

			onTextChanged: mainInputRectangle.currentText = text
		}

	}

	DefaultText{
		id: errText

		anchors.top: iA.bottom
		anchors.left: iA.left
		anchors.topMargin: 6
		width: parent.width

		wrapMode: Text.WordWrap

		text: errorText
		visible: errorText.length > 0

		color: "red"
	}




}
