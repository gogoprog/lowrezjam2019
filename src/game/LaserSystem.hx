package game;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class LaserNode extends Node<LaserNode> {
    public var transform:Transform;
    public var shake:Laser;
}

class LaserSystem extends ListIteratingSystem<LaserNode> {
    private var engine:Engine;
    private var enemyList:NodeList<EnemyNode>;

    public function new() {
        super(LaserNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:LaserNode, dt:Float):Void {
        var t = node.transform;
        var p = t.position;
        p.x += dt * 30;

        if(p.x > 80) {
            engine.removeEntity(node.entity);
        }
    }

    private function onNodeAdded(node:LaserNode) {
    }

    private function onNodeRemoved(node:LaserNode) {
    }
}


