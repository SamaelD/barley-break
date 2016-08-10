import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0

import "Logic.js" as Logic

ApplicationWindow {
    id: wnd

    signal refreshed();

    minimumHeight: 500
    minimumWidth: 400

    title: "Barley break"

    GridView {
        id: grid

        header:Button {
            id: refresh

            width: wnd.width
            height: wnd.height * 0.1

            text: "refresh"

            onClicked: { Logic.refresh(); }
        }

        anchors.fill: parent

        interactive: false;

        cellWidth: width / 4
        cellHeight: ( parent.height - parent.height * 0.1 ) / 4

        model: model
        delegate: component

        moveDisplaced: Transition {
            NumberAnimation {
                properties: "x, y"
                easing.type: Easing.Linear
                duration: 300
            }
        }

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
                    Logic.move(index)
                    if (Logic.checkWin()) {
                        gameOverDialog.visible = true
                    }
                }
            }
            ScaleAnimator on scale {
                id: anim;
                from: 0;
                to: 1;
                duration: 500;
                easing.type: Easing.InOutSine
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

    Component.onCompleted: { Logic.initModel(grid.model, 16); }
}
