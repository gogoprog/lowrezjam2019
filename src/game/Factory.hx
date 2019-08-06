package game;

import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;

class Factory {
    static public function init(game:phaser.Game) {
    }

    static public function createBackground() {
        var e = new Entity();
        e.add(new Sprite("back"));
        e.add(new Transform());
        return e;
    }
}

