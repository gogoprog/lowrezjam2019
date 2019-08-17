package game;

import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;

class MenuSystem extends ash.core.System {
    private var text:Entity;
    private var title:Entity;

    public function new() {
        super();
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        text = Factory.createText("Click to play");
        engine.addEntity(text);
        text.get(Transform).position.set(10, 50);
        title = Factory.createText("Damn\nNight");
        engine.addEntity(title);
        title.get(Transform).position.set(20, 5);
        title.get(Text).fontSize = 10;
        title.get(Text).fill = "yellow";
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
        engine.removeEntity(text);
        engine.removeEntity(title);
    }

    public override function update(dt) {
        var mb = whiplash.Input.mouseButtons;

        if(mb[0]) {
            Game.instance.startIntro();
            mb[0] = false;
        }
    }
}

