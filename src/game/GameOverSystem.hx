package game;

import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;

class GameOverSystem extends ash.core.System {
    private var text:Entity;
    private var title:Entity;
    private var time:Float;
    private var engine:Engine;

    public function new() {
        super();
    }

    public override function addToEngine(engine:Engine) {
        this.engine = engine;
        super.addToEngine(engine);
        text = Factory.createText("");
        text.get(Transform).position.set(10, 50);
        engine.addEntity(text);
        title = Factory.createText("");
        title.get(Transform).position.set(20, 5);
        title.get(Text).fontSize = 10;
        engine.addEntity(title);
        var miss = Game.instance.session.miss;

        if(miss == 0) {
            title.get(Text).text = "Good!";
            title.get(Text).fill = "yellow";
        } else {
            title.get(Text).text = "Failed.";
            title.get(Text).fill = "red";

            if(miss > 1) {
                text.get(Text).text = miss + " misses";
            } else {
                text.get(Text).text = miss + " miss";
            }
        }

        time = 0;
        engine.removeEntity(engine.getEntityByName("ship"));
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
        engine.removeEntity(text);
        engine.removeEntity(title);
    }

    public override function update(dt) {
        var mb = whiplash.Input.mouseButtons;
        time += dt;

        if(mb[0] && time > 2) {
            Game.instance.gotoMainMenu();
            mb[0] = false;
        }

        var ps = engine.getSystem(ParallaxSystem);

        if(ps.speed > 0) {
            ps.speed -= dt * 20;
        }

        if(ps.speed < 0) {
            ps.speed = 0;
        }
    }
}

