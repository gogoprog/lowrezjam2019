package game;

import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;

class Factory {
    static public function init(game:phaser.Game) {
    }

    static public function createParallax(texture, factor) {
        var e = new Entity();
        e.add(new TileSprite(65, 64, texture));
        e.add(new Parallax(factor));
        e.add(new Transform());
        return e;
    }
}

