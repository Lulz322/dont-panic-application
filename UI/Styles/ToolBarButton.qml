import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Shapes 1.15
import QtQuick 2.15

Rectangle{
	id: control
	readonly property var active: area.containsMouse
	width: 48
	height: 30

	color: "transparent"

	signal clicked()

	MouseArea{
		id: area
		anchors.fill: parent
		hoverEnabled: true
		onClicked: control.clicked()
	}
}
