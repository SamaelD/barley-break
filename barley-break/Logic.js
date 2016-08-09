var array;
var model;
var count;

function setModel(newModel) {
    model = newModel;
}


function move(index) {
    if (checkOutOfRange(index + 1)
            && model.get(index + 1).identifier === 0
            && checkBorder(index, true)) {
        model.move(index, index + 1, 1);
    }
    else if (checkOutOfRange(index - 1)
             && model.get(index - 1).identifier === 0
             && checkBorder(index, false)) {
        model.move(index, index - 1, 1);
    }
    else if (checkOutOfRange(index + 4) && model.get(index + 4).identifier === 0) {
        model.move(index, index + 4, 1);
        model.move(index + 3, index, 1);
    }
    else if (checkOutOfRange(index - 4) && model.get(index - 4).identifier === 0) {
        model.move(index, index - 4, 1);
        model.move(index - 3, index, 1);
    }
}

function checkBorder(currIndex, right) {
    if (right) {
        for (var i = 3; i < count; i += 4) {
            if (currIndex === i) {
                return false;
            }
        }
    }
    else {
        for (var i = 0; i < count; i += 4) {
            if (currIndex === i) {
                return false;
            }
        }
    }
    return true;
}

function checkOutOfRange(index) {
    if (index < 0 || index >= count) {
        return false;
    }
    return true;
}

function refresh() {
    array = setArray();
    for (var i = 0; i < model.count; ++i) {
        model.get(i).identifier = getIdentifier();
    }
}

function rand(min, max) {
    return Math.floor(Math.random() * (max-min) + min);
}

function getIdentifier() {
    var id = rand(0, array.length);
    var item = array[id];
    array.splice(id, 1);
    return item;
}

function setArray() {
    var arr = [];
    for (var i = 1; i <= model.count; ++i) {
        arr[i] = i;
    }
    return arr;
}

function checkWin() {
    for (var i = 1; i < 16; ++i){
        if (model.get(i-1).identifier !== i) {
            return false;
        }
    }
    return true;
}

function initModel(model, newCount) {
    count = newCount;
    for (var i = 0; i < count; ++i) {
        model.append({ identifier: i });
    }
}
