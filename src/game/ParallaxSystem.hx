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
    private var engine:Engine;
    private var camera:phaser.Camera;

    public function new() {
        super(ParallaxNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
        camera = whiplash.Lib.phaserGame.camera;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt) {
        super.update(dt);

        camera.x += dt * 100;

    }

    private function updateNode(node:ParallaxNode, dt:Float):Void {
        var sprite = node.sprite;
        var position = node.transform.position;
        sprite.tilePosition.x = - camera.x * node.parallax.factor;
        position.x = camera.x;
        position.y = camera.y;
    }

    private function onNodeAdded(node:ParallaxNode) {
    }

    private function onNodeRemoved(node:ParallaxNode) {
    }
}

