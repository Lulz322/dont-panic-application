import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.0
import QtQuick.Shapes 1.15
import QtQuick.Layouts 1.1
import QtQuick.Timeline 1.1

import "../Styles"

Item {

	ColumnLayout{
		id: mainRow
		anchors.top: parent.top
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.topMargin: 250
		width: parent.width * 0.75
		spacing: 10
		Layout.alignment: Qt.AlignHCenter


		Input{
			id: loginInput
			placeholderText: qsTr("Login")
			width: parent.width
			Layout.preferredWidth: width
		}

		PasswordInput{
			id: passwordInput
			placeholderText: qsTr("Password")
			width: parent.width
			Layout.preferredWidth: width
		}

		PasswordInput{
			placeholderText: qsTr("Confirm password")
			width: parent.width
			Layout.preferredWidth: width
		}

		DefaultButton{
			btnText: qsTr("Ok, let's do It!")
			Layout.topMargin: 16
			Layout.alignment: Qt.AlignHCenter
			Layout.preferredWidth: width
			width: parent.width * .5

			onClicked: appController.regUser(loginInput.currentText, passwordInput.text)
		}
	}


	Rectangle{
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.top: mainRow.bottom
				anchors.topMargin: 36

				width: haveAccText.contentWidth + enterText.contentWidth

				DefaultText{
					id: haveAccText
					text: qsTr("Do you have an account?")
					horizontalAlignment: Text.horizontalAlignment

					color: "#76859C"
				}

				DefaultText{
					id: enterText
					anchors.left: haveAccText.right
					anchors.top: haveAccText.top
					anchors.leftMargin: 6
					text: qsTr("Log-IN")
					horizontalAlignment: Text.horizontalAlignment

					color: "blue"

					MouseArea{
						id: regArea
						anchors.fill: parent
						hoverEnabled: true
						cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
						onClicked: {
							mainLoader.source = "StartupWindows/LoginScreen.qml"
						}
					}
				}
			}


}

/*##^##
Designer {
	D{i:0;autoSize:true;formeditorZoom:0.66;height:480;width:640}D{i:2}D{i:3}D{i:4}D{i:1}
D{i:5}
}
##^##*/
