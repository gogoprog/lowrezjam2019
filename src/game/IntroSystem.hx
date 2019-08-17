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
                       "Report in!",
                       "Reporting in.",
                       "Area clear...",
                       "Oh noes!",
                       "Monsters ahead!",
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
        time = 0;
        index = 0;
        text = Factory.createText("");
        engine.addEntity(text);
        text.get(Transform).position.set(6, 50);
        whiplash.AudioManager.playSound("engine");
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
        engine.removeEntity(text);
    }

    public override function update(dt:Float) {
        var mb = whiplash.Input.mouseButtons;
        var ps = engine.getSystem(ParallaxSystem);
        var max = 50;

        if(ps.speed < max) {
            ps.speed += dt * 20;

            if(mb[0]) {
                ps.speed = max;
                mb[0] = false;
            }
        } else {
            ps.speed = max;
            time -= dt;

            if(mb[0]) {
                time = -1;
                mb[0] = false;
            }

            if(time < 0) {
                time = 2;

                if(index >= messages.length) {
                    Game.instance.startGame();
                } else {
                    text.get(Text).text = messages[index];
                    whiplash.AudioManager.playSound("beep");

                    if(index == 3) {
                        whiplash.AudioManager.playSound("growl");
                    }

                    index++;
                }
            }
        }
    }
}

