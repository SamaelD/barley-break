var array;
var model;
var count;

function setModel(newModel, newCount) {
    model = newModel;
    count = newCount;

    refresh();
}

function initModel() {
    model.clear();
    for (var i = 1; i < count; ++i) {
        model.append({ identifier: i });
    }
    model.append({ identifier: 0 });
}

function move(index, grid) {
    if (checkOutOfRange(index + 1)
            && model.get(index + 1).identifier === 0
            && checkBorder(index, true)) {
        model.move(index, index + 1, 1); ++grid.moveCounter;
    }
    else if (checkOutOfRange(index - 1)
             && model.get(index - 1).identifier === 0
             && checkBorder(index, false)) {
        model.move(index, index - 1, 1); ++grid.moveCounter;
    }
    else if (checkOutOfRange(index + 4) && model.get(index + 4).identifier === 0) {
        model.move(index, index + 4, 1);
        model.move(index + 3, index, 1); ++grid.moveCounter;
    }
    else if (checkOutOfRange(index - 4) && model.get(index - 4).identifier === 0) {
        model.move(index, index - 4, 1);
        model.move(index - 3, index, 1); ++grid.moveCounter;
    }
}

function checkOutOfRange(index) {
    if (index < 0 || index >= count) {
        return false;
    }
    return true;
}

function checkBorder(currIndex, right) {
    for (var i = (right ? 3 : 0); i < count; i += 4) {
        if (currIndex === i) {
            return false;
        }
    }
    return true;
}


function refresh() {
    initModel();
    array = setArray();
    for (var i = 0; i < model.count; ++i) {
        model.get(i).identifier = getIdentifier();
    }
    if (countInversion() % 2 !== 0){
        model.move(count - 2, count - 1, 1);
    }
}

function setArray() {
    var arr = [];
    for (var i = 0; i < model.count; ++i) {
        arr[i] = i;
    }
    return arr;
}

function getIdentifier() {
    var id = rand(0, array.length);
    var item = array[id];
    array.splice(id, 1);
    return item;
}

function rand(min, max) {
    return Math.floor(Math.random() * (max-min) + min);
}

function countInversion() {
    var cnt = 0;
    for (var i = 0; i < count - 1; ++i) {
        for (var j = i + 1; j < count; ++j) {
            if (model.get(i).identifier > model.get(j).identifier) {
                ++cnt;
            }
        }
    }
    return cnt;
}

function checkWin() {
    for (var i = 1; i < 16; ++i) {
        if (model.get(i-1).identifier !== i) {
            return false;
        }
    }
    return true;
}
