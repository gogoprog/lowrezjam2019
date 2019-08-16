package game;

import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;

class MenuSystem extends ash.core.System {
    private var text:Entity;

    public function new() {
        super();
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        text = Factory.createBitmapText("Click to play");
        engine.addEntity(text);
        text.get(Transform).position.set(10, 50);
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
        engine.removeEntity(text);
    }

    public override function update(dt) {
        var mb = whiplash.Input.mouseButtons;

        if(mb[0]) {
            Game.instance.startIntro();
        }
    }
}

