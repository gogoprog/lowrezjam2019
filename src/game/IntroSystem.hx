package game;

import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;

class IntroSystem extends ash.core.System {
    var totalTime:Float;
    var time:Float;
    var engine:Engine;
    private var text:Entity;

    var index:Int;
    var messages = [
                       "Hi",
                       "Nice evening?",
                       "Oh-oh!",
                       "Enemies ahead!",
                       "Kill them all!"
                   ];

    public function new() {
        super();
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        var e = Factory.createShip();
        engine.addEntity(e);
        this.engine = engine;
        totalTime = 0;
        time = 1;
        index = 0;
        text = Factory.createBitmapText("");
        engine.addEntity(text);
        text.get(Transform).position.set(6, 50);
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
        engine.removeEntity(text);
    }

    public override function update(dt:Float) {
        var ps = engine.getSystem(ParallaxSystem);
        var max = 50;

        if(ps.speed < max) {
            ps.speed += dt * 20;
        } else {
            ps.speed = max;
            time -= dt;

            if(time < 0) {
                time = 3;

                if(index >= messages.length) {
                    Game.instance.startGame();
                } else {
                    text.get(Text).text = messages[index];
                    index++;
                }
            }
        }
    }
}
