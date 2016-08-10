import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0

import "Logic.js" as Logic

ApplicationWindow {
    id: wnd

    signal refreshed();

    minimumHeight: 600
    minimumWidth: 400

    title: "Barley break"

    GridView {
        id: grid

        property int moveCounter: 0

        header:Button {
            id: refresh

            width: wnd.width
            height: wnd.height * 0.1

            text: "refresh"

            onClicked: { Logic.refresh(); }
        }

        footer: Rectangle {
            x:0
            y: 100

            width: wnd.width
            height: wnd.height * 0.1

            border.color: "black"
            color: "lightgray"

            Text {
                anchors.centerIn: parent

                font.pixelSize: parent.height * 0.85
                font.bold: true

                text: "Moves: " + grid.moveCounter
            }
        }

        anchors.fill: parent

        interactive: false;

        cellWidth: width / 4
        cellHeight: ( parent.height - parent.height * 0.2 ) / 4

        model: model
        delegate: component

        move: Transition {
            NumberAnimation {
                properties: "x, y"
                easing.type: Easing.InOutSine
                duration: 300
            }
        }
    }

    Component {
        id: component
        Rectangle {
            id: rect

            width: grid.cellWidth
            height: grid.cellHeight

            opacity: identifier === 0 ? 0 : 1
            border.color: "black"
            color: "green"
            radius: 10

            Text {
                anchors.centerIn: rect

                text: identifier

                font.bold: true
                font.pixelSize: 48

                color: mouse.containsMouse ? "black" : "darkred"
            }

            transform: Scale {
                origin.x: rect.x;
                origin.y: rect.y;
                xScale: mouse.containsMouse ? 1.015 : 1
                yScale: mouse.containsMouse ? 1.015 : 1
            }

            MouseArea {
                id: mouse

                anchors.fill: rect

                hoverEnabled: true
                acceptedButtons: Qt.LeftButton
                onClicked: {
                    if (identifier === 0) return
                    Logic.move(index, grid)
                    if (Logic.checkWin()) {
                        gameOverDialog.visible = true
                    }
                }
            }
            ScaleAnimator on scale {
                id: anim;
                from: 0;
                to: 1;
                duration: 400;
            }
        }
    }

    ListModel { id: model }

    MessageDialog {
        id: gameOverDialog

        visible: false

        title: "Winner"
        text: "You're win the game!\nCongratulations!!\nRestart?"

        standardButtons: StandardButton.Yes | StandardButton.No
        onYes: Logic.refresh()
        onNo: Qt.quit()
    }

    Component.onCompleted: { Logic.setModel(grid.model, 16); }
}
