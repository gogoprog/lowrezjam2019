package game;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class BlinkNode extends Node<BlinkNode> {
    public var transform:Transform;
    public var blink:Blink;
    public var sprite:Sprite;
}

class BlinkSystem extends ListIteratingSystem<BlinkNode> {
    private var engine:Engine;

    public function new() {
        super(BlinkNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:BlinkNode, dt:Float):Void {
        var blink = node.blink;

        blink.time += dt;

        node.sprite.alpha = 0.5 + 0.5 * Math.cos(blink.time * 40);

        if(blink.time > 0.4) {
            node.sprite.alpha = 1;
            node.entity.remove(Blink);
        }
    }

    private function onNodeAdded(node:BlinkNode) {
    }

    private function onNodeRemoved(node:BlinkNode) {
    }
}


