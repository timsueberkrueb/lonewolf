import QtQuick 2.4
import Ubuntu.Components 1.2
import Lonewolf 1.0

Rectangle {
    id: root
    color: "black"
    opacity: 0.95

    property var you
    property var answer
    signal close()
    signal goTo(string page)

    QtObject {
        id: d
        property bool correct
        property bool wrong
    }

    Column {
        anchors.top: parent.top
        anchors.topMargin: units.gu(4)
        anchors.left: parent.left
        anchors.right: parent.right
        Label {
            anchors.left: parent.left
            anchors.right: parent.right
            horizontalAlignment: Text.AlignHCenter
            text: "Enter number"
            color: "white"
            fontSize: "x-large"
        }

        Item { width: units.gu(1); height: units.gu(2); }

        Row {
            spacing: units.gu(1)
            anchors.horizontalCenter: parent.horizontalCenter

            TextField {
                id: entry
                width: units.gu(10)
                height: FontUtils.sizeToPixels("x-large") + units.gu(2)
                inputMethodHints: Qt.ImhDigitsOnly
                hasClearButton: false
                horizontalAlignment: TextInput.AlignHCenter
                font.pixelSize: FontUtils.sizeToPixels("x-large")
                Component.onCompleted: entry.forceActiveFocus()
                onTextChanged: {
                    d.correct = false;
                    d.wrong = false;
                }
            }

            Button {
                anchors.verticalCenter: parent.verticalCenter
                text: "Try"
                onClicked:{
                    if ("sect" + entry.text == root.answer) {
                        d.correct = true;
                    } else {
                        d.wrong = true;
                        entry.forceActiveFocus();
                    }
                }
            }
        }

        Item { width: units.gu(1); height: units.gu(2); }

        Label {
            anchors.left: parent.left
            anchors.right: parent.right
            horizontalAlignment: Text.AlignHCenter
            visible: d.correct || d.wrong
            text: d.correct ? "Correct!" : "Wrong"
            color: d.correct ? "white" : UbuntuColors.red
            fontSize: "x-large"
        }
    }

    Button {
        id: cancelButton
        text: "Cancel"
        color: UbuntuColors.lightGrey
        anchors.left: parent.left
        anchors.right: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.topMargin: units.gu(1)
        anchors.bottomMargin: units.gu(1)
        anchors.leftMargin: units.gu(1)
        anchors.rightMargin: units.gu(0.5)
        onClicked: root.close()
    }
    Button {
        text: "Go to Page"
        color: UbuntuColors.green
        anchors.right: parent.right
        anchors.left: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.topMargin: units.gu(1)
        anchors.bottomMargin: units.gu(1)
        anchors.rightMargin: units.gu(1)
        anchors.leftMargin: units.gu(0.5)
        enabled: d.correct
        onClicked: root.goTo("sect" + entry.text)
    }
}
