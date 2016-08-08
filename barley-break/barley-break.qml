import QtQuick 2.6
import QtQuick.Controls 1.4
import "Logic.js" as Logic

// https://qmlbook.github.io/

ApplicationWindow {
    id: wnd;
    minimumHeight: 500;
    minimumWidth: 400;
    title: "Barley break";

    Button {
        id: refresh;
        width: parent.width;
        height: parent.height * 0.1;
        text: "refresh";
        onClicked: {  }
    }

    GameArea {
        id: gameArea;
        y: refresh.height;
        height: parent.height - refresh.height;
    }

    Component.onCompleted: {
        Logic.gameState(gameArea);
    }
}
