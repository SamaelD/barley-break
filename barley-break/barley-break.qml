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
        header:
            Button {
            id: refresh
            width: wnd.width
            height: wnd.height * 0.1
            text: "refresh"
            onClicked: Logic.refresh()
        }

        cellWidth: width / 4
        cellHeight: ( parent.height - parent.height * 0.1 ) / 4

        anchors.fill: parent
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

            parent: grid
            border.color: "black"
            color: mouse.containsMouse ? "darkred" : "green"
            radius: 10

            Text {
                text: identifier == 0 ? "" : identifier
                font.bold: true
                font.pixelSize: 48
                color: mouse.containsMouse ? "black" : "darkred"
                anchors.centerIn: rect
            }

            MouseArea {
                id: mouse
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton
                onClicked: {
                    Logic.move(index, grid.count)
                    if(Logic.checkWin()) {
                        gameOverDialog.visible = true
                    }
                }
                hoverEnabled: true
            }
        }

    }
    Component.onCompleted: {
        Logic.setModel(grid.model)
        Logic.refresh()
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
}
