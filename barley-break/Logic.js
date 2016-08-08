.pragma library

var gameField;
function createField() {
    var ret = [4];
    for(var i = 0; i < ret.length; ++i)
        ret = [4];
    return ret;
}

var targetComponent = Qt.createComponent("Target.qml");

var game_state;
function gameState(gamearea) {
    game_state = gamearea;
    gameField = createField();
    return game_state;
}

function move(target) {
    targe += 1;
}

function init() {
    targetComponent.createObject(game_state, {"col": 1,"row": 1} );
    //for(var i = 0; i < 4; ++i)
    //    for(var j = 0; j < 4; ++j) {
    //        if(i == 3 && j == 3) return;
    //        targetComponent.createObject(game_state, {"col": j,"row": i} );
    //    }
}
