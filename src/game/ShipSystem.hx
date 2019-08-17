package game;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class ShipNode extends Node<ShipNode> {
    public var transform:Transform;
    public var ship:Ship;
}

class ShipSystem extends ListIteratingSystem<ShipNode> {
    private var engine:Engine;

    public function new() {
        super(ShipNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:ShipNode, dt:Float):Void {
        var m = whiplash.Input.mouseCoordinates;
        var mb = whiplash.Input.mouseButtons;
        var ship = node.ship;

        node.transform.position.x = 5;
        node.transform.position.y = m.y;

        ship.timeSinceFire += dt;

        if(ship.timeSinceFire > ship.fireInterval) {
            if(mb[0]) {
                var e = Factory.createLaser();
                var p = e.get(Transform).position;
                p.x = node.transform.position.x;
                p.y = node.transform.position.y;
                engine.addEntity(e);
                ship.timeSinceFire = 0;
                whiplash.AudioManager.playSound("laser");
            }
        }
    }

    private function onNodeAdded(node:ShipNode) {
    }

    private function onNodeRemoved(node:ShipNode) {
    }
}


