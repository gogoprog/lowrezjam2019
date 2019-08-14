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

    static public function createEnemy() {
        var e = new Entity();
        e.add(new Transform());
        e.add(new Sprite("enemy"));
        e.get(Transform).scale.set(0.6, 0.6);
        var s = e.get(Sprite);
        s.animations.add("idle", ["frame12", "frame2", "frame7", "frame2"]);
        s.animations.play("idle", 5, true);
        s.anchor.set(0.5, 0.5);
        s.tint = 0xffffff;
        return e;
    }
}

