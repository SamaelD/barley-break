import QtQuick 2.6
import QtQuick.Controls 1.4
import "Logic.js" as Logic

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
        x: 0; y: refresh.height;
        width: parent.width;
        height: parent.height - refresh.height;
    }

    Component.onCompleted: {
        Logic.gameState(gameArea);
        Logic.init();
    }
}
