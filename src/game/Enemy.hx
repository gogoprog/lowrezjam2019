package game;

class Enemy {
    public var time:Float = 0.0;

    public var speed:Float = 30;
    public var hp:Int = 100;
    public var dying:Bool = false;
    public var vy:Float = 0;

    public var pathIndex:Int;
    public var pathStepIndex:Int;
    public var pathStepTime:Float;


    public function new() {
    }
}
