package game;

import whiplash.math.Point;

class Config {
    static public var gameWidth:Int = 480;
    static public var gameHeight:Int = 800;
    static public var blockSize:Int = 32;
    static public var blockStartY:Int = 400;
    static public var rowSpace:Int = 200;
    static public var rowSize:Int = 11;
    static public var levelWidth:Float = rowSize * blockSize;
    static public var playerDecalY = 150.0;
    static public var playerExtent = new Point(50, 64);
    static public var playerScale = new Point(2, 2);
    static public var playerImpulse = 400;
    static public var playerPenetration = 10;
}
