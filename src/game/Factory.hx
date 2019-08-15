package game;

import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;

class Factory {
    static public function init(game:phaser.Game) {
        game.load.bitmapFont('font', '../data/fonts/font.png', '../data/fonts/font.fnt');
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
        e.get(Transform).scale.set(0.3, 0.3);
        var s = e.get(Sprite);
        s.animations.add("idle", ["frame12", "frame2", "frame7", "frame2"]);
        s.animations.add("death", [for(i in 35...42) "frame" + i]);
        s.animations.play("idle", 5, true);
        s.anchor.set(0.5, 0.33);
        e.add(new Enemy());
        return e;
    }

    static public function createShip() {
        var e = new Entity();
        e.add(new Transform());
        e.add(new Sprite("rocket"));
        var s = e.get(Sprite);
        s.anchor.set(0.5, 0.5);
        e.add(new Ship());
        return e;
    }

    static public function createLaser() {
        var e = new Entity();
        e.add(new Transform());
        e.add(new Sprite("laser"));
        var s = e.get(Sprite);
        s.anchor.set(0.5, 0.5);
        e.add(new Laser());
        return e;
    }

    static public function createBitmapText(text) {
        var e = new Entity();
        e.add(new Transform());
        var t = new Text(text);
        t.font = "Main";
        t.fontSize = 5;
        t.stroke = '#ffffff';
        t.fill = 'white';
        e.add(t);
        return e;
    }
}

