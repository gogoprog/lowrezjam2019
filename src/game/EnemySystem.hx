package game;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.Point;

class EnemyNode extends Node<EnemyNode> {
    public var transform:Transform;
    public var enemy:Enemy;
    public var sprite:Sprite;
}

typedef Path = Array<Point>;

class EnemySystem extends ListIteratingSystem<EnemyNode> {
    private var engine:Engine;
    private var time:Float = 0;
    private var index:Int = 0;

    private var paths:Array<Path> = [
                                        [ new Point(80, 32), new Point(32, 32), new Point(32, 0), new Point(32, 80) ],
                                        [ new Point(80, 0), new Point(32, 32), new Point(32, 80) ],
                                        [ new Point(80, 64), new Point(32, 32), new Point(32, -20) ],
                                        [ new Point(80, 64), new Point(32, 32), new Point(50, 32), new Point(32, 20), new Point(32, 42), new Point(32, 20), new Point(32, 42), new Point(64, 100) ]
                                    ];

    private var timeline:Dynamic = [
                                       [0, 250, 0.3],
                                       [0, 250, 0.3],
                                       [0, 250, 0.3],
                                       null,
                                       [1, 250, 0.3],
                                       [1, 250, 0.3],
                                       [1, 250, 0.3],
                                       null,
                                       [2, 200, 0.3],
                                       [2, 200, 0.3],
                                       [2, 200, 0.3],
                                       null,
                                       [3, 1500, 0.6],
                                       null,
                                       null,
                                       null,
                                       null,
                                       [3, 1500, 0.6],
                                   ];

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

    public override function update(dt) {
        super.update(dt);
        time += dt;

        if(time > 1) {
            if(index < timeline.length) {
                var event = timeline[index];

                if(event != null) {
                    var e = Factory.createEnemy();
                    var en = e.get(Enemy);
                    en.pathIndex = event[0];
                    en.hp = event[1];
                    var s = event[2];
                    e.get(Transform).scale.set(s, s);
                    engine.addEntity(e);
                }
            }

            index++;
            time -= 1;
        }
    }

    private function updateNode(node:EnemyNode, dt:Float):Void {
        var enemy = node.enemy;

        if(enemy.hp <= 0) {
            if(!enemy.dying) {
                node.sprite.animations.play("death", 6, false);
                whiplash.AudioManager.playSound("death");
                enemy.dying = true;
            }

            var p = node.transform.position;
            enemy.vy += dt * 100;
            p.y += enemy.vy *dt;

            if(p.y > 100) {
                engine.removeEntity(node.entity);
            }

            return;
        }

        enemy.time += dt;
        enemy.pathStepTime += dt;

        var path = paths[enemy.pathIndex];

        var a = path[enemy.pathStepIndex];
        var b = path[enemy.pathStepIndex + 1];

        if(b == null) {
            engine.removeEntity(node.entity);
            return;
        } else {
            var delta = b - a;
            var len = delta.getLength();
            var totalTime = len / enemy.speed;
            var f = enemy.pathStepTime / totalTime;
            var p = a + (b - a) * f;
            node.transform.position.copyFrom(p);

            if(f > 1) {
                enemy.pathStepIndex++;
                enemy.pathStepTime -= totalTime;
            }
        }
    }

    private function onNodeAdded(node:EnemyNode) {
        var enemy = node.enemy;
        enemy.time = 0;
        enemy.pathStepTime = 0;
        enemy.pathStepIndex = 0;
        updateNode(node, 0);
    }

    private function onNodeRemoved(node:EnemyNode) {
    }
}


