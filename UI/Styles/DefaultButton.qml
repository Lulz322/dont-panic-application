import QtQuick 2.0

Rectangle {

	property string btnText
	signal clicked()

	width: 90
	height: 40
	color: area.containsMouse ? "#A1D2FF" : "transparent"
	border.color: "#A1D2FF"
	radius: 6

	DefaultText{
		anchors.centerIn: parent
		text: parent.btnText
	}

	MouseArea{
		id:area
		anchors.fill: parent
		hoverEnabled: true
		cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
		onClicked: parent.clicked()
	}

}
