package game;

import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;

class Factory {
    static public function init(game:phaser.Game) {
    }

    static public function createParallax(texture, factor) {
        var e = new Entity();
        e.add(new TileSprite(70, 64, texture));
        e.add(new Parallax(factor));
        e.add(new Transform());
        e.get(Transform).position.x = -2;
        return e;
    }
}

