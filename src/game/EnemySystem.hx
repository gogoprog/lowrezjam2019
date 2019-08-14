package game;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class EnemyNode extends Node<EnemyNode> {
    public var transform:Transform;
    public var shake:Enemy;
}

class EnemySystem extends ListIteratingSystem<EnemyNode> {
    private var engine:Engine;

    public function new() {
        super(EnemyNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:EnemyNode, dt:Float):Void {
    }

    private function onNodeAdded(node:EnemyNode) {
    }

    private function onNodeRemoved(node:EnemyNode) {
    }
}


