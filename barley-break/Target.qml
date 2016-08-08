import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "Logic.js" as Logic

Button {
    id: target;
    width: parent.width/4;
    height: parent.height/4;
    style: ButtonStyle {
        background: Rectangle {
            color: mouse.containsMouse ? "crimson" : "blue";
            border.color: "black";
            radius: 5;
        }
    }

    property int row: 0;
    property int col: 0;

    x: col * (width - 1);
    y: row * (height - 1);

    MouseArea {
        id: mouse;
        anchors.fill: parent;
        hoverEnabled: true;
        onClicked: {
            Logic.move(target);
            x: col * (width - 1);
        }
    }
}
