import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0

import "Logic.js" as Logic

ApplicationWindow {
    id: wnd

    minimumHeight: 500
    minimumWidth: 400

    title: "Barley break"

    GridView {
        id: grid

        header: Button {
            id: refresh

            width: wnd.width
            height: wnd.height * 0.1

            text: "refresh"

            onClicked: Logic.refresh()
        }

        anchors.fill: parent

        cellWidth: width / 4
        cellHeight: ( parent.height - parent.height * 0.1 ) / 4

        model: Blocks{}
        delegate: item

        displaced: Transition {
            NumberAnimation {
                properties: "x, y"
                easing.type: Easing.OutQuint
                duration: 1000
            }
        }
    }

    Component {
        id: item
        Rectangle{
            id: rect

            width: grid.cellWidth
            height: grid.cellHeight

            border.color: "black"
            color: mouse.containsMouse ? "darkred" : "green"
            radius: 10

            Text {
                anchors.centerIn: rect

                text: identifier == 0 ? "" : identifier

                font.bold: true
                font.pixelSize: 48

                color: mouse.containsMouse ? "black" : "darkred"
            }

            MouseArea {
                id: mouse

                anchors.fill: rect

                hoverEnabled: true
                acceptedButtons: Qt.LeftButton
                onClicked: {
                    Logic.move(index, grid.count)
                    if(Logic.checkWin()) {
                        gameOverDialog.visible = true
                    }
                }
            }
        }

    }

    MessageDialog {
        id: gameOverDialog

        visible: false

        title: "Winner"
        text: "You're win the game!\nCongratulations!!"

        standardButtons: StandardButton.Yes | StandardButton.No
        onYes: Logic.refresh()
        onNo: Qt.quit()
    }

    Component.onCompleted: {
        Logic.setModel(grid.model)
        Logic.refresh()
    }
}
