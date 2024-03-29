package game;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class ParallaxNode extends Node<ParallaxNode> {
    public var transform:Transform;
    public var parallax:Parallax;
    public var sprite:TileSprite;
}

class ParallaxSystem extends ListIteratingSystem<ParallaxNode> {
    public var speed:Float = 0;
    private var engine:Engine;

    public function new() {
        super(ParallaxNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt:Float) {
        Game.instance.session.worldX += dt * speed;
        super.update(dt);
    }

    private function updateNode(node:ParallaxNode, dt:Float):Void {
        var sprite = node.sprite;
        var position = node.transform.position;
        sprite.tilePosition.x = - Game.instance.session.worldX * node.parallax.factor;

        while(sprite.tilePosition.x > 96) {
            sprite.tilePosition.x -= 96;
        }
    }

    private function onNodeAdded(node:ParallaxNode) {
    }

    private function onNodeRemoved(node:ParallaxNode) {
    }
}

