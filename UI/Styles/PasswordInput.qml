import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Rectangle{
	id: inputRect

	property string placeholderText: ""
	property string text: ""
	property string errorText: ""
	readonly property bool isInFocus: inputArea.focus


	width: 320
	implicitHeight: 32 + 6 + errText.height
	color: "transparent"


	function isPassValid(password)
	{
		const MIN_PASSWORD_LENGTH = 8
		const MAX_PASSWORD_LENGTH = 50
		const PASSWORD_REGEXP = /^(?=[^\s]*\d)[^\s]{8,50}$/


		password = password.toString()


		if (password.length === 0)
			return qsTr("Please enter password")
		else if (password.length < 8)
			return qsTr("Password too Short");
		else if (password.length > 50)
			return qsTr("Password too long");
		else if (!password.match(PASSWORD_REGEXP))
			return qsTr("The password must be without spaces between 8 and 50 characters and must contain at least one number digit");
		else
			return "";

	}


	Rectangle{
		id: iA
		width: parent.width
		implicitHeight: 32


		radius: 6
		color: errorText.length > 0 ? Qt.rgba(212, 0, 15, 0.1) : Qt.rgba(0,0,0, 0.2);
		border.color: "#A1D2FF"

		TextField{
			id: inputArea
			selectByMouse: true
			placeholderText: inputRect.placeholderText
			placeholderTextColor: Qt.rgba(255,255,255, 0.5)

			implicitHeight: parent.height
			width: parent.width - 12 - eye.width - 12 - 12
			anchors.left: parent.left
			anchors.leftMargin: 12


			background: Rectangle{
				color: "transparent"
			}

			color: "white"
			font.family: "SeoulHangang CEB"
			font.pixelSize: 16

			onTextChanged: {
				errorText = isPassValid(text)
				inputRect.text = inputArea.text
			}

			Keys.onTabPressed: nextItemInFocusChain().forceActiveFocus(
								   Qt.TabFocusReason)

			echoMode: TextInput.Password
			text: inputRect.text
			topPadding: height / 2 - font.pixelSize / 2

		}

		Image{
			id: eye
			anchors.right: parent.right
			anchors.rightMargin: 12
			anchors.verticalCenter: parent.verticalCenter
			width: 16
			height: 16

			source: "qrc:/icons/Assets/icons/visibility_off.png"

			MouseArea{
				anchors.fill: parent
				onClicked: {
					if (eye.source == "qrc:/icons/Assets/icons/visibility_off.png")
					{
						eye.source = "qrc:/icons/Assets/icons/visibility_on.png"
						inputArea.echoMode = TextInput.Normal
					}else{
						eye.source = "qrc:/icons/Assets/icons/visibility_off.png"
						inputArea.echoMode = TextInput.Password
					}
				}
			}
		}
		ColorOverlay{
				anchors.fill: eye
				source:	eye
				color: "#76859C"
				transform: rotation
				antialiasing: false
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
