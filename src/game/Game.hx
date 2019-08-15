package game;

import firefalcom.*;
import ash.core.Entity;
import ash.core.Engine;
import ash.tools.ListIteratingSystem;
import ash.core.Node;
import ashextension.*;
import whiplash.*;
import js.jquery.*;
import whiplash.phaser.*;
import whiplash.math.*;

class Game extends Application {
    public var session:Session = new Session();
    static public var instance:Game;

    public function new() {
        super(Config.gameWidth, Config.gameHeight, ".root");
        instance = this;
    }

    override function preload():Void {
        super.preload();
        Factory.init(game);
    }

    override function create():Void {
        var game = whiplash.Lib.phaserGame;
        game.world.setBounds(-1000, 0, 2000, 10000);
        whiplash.Input.setup(new JQuery(".root")[0]);
        Factory.init(game);
        AudioManager.init(game);
        game.stage.disableVisibilityChange = true;
        engine.addSystem(new ParallaxSystem(), 9);
        engine.addSystem(new ShipSystem(), 9);
        engine.addSystem(new LaserSystem(), 9);
        engine.addSystem(new EnemySystem(), 9);

        var menuState = createState("menu");
        createUiState("main", ".default");
        createUiState("lobby", ".lobby");
        createUiState("hud", ".hud");

        var ingameState = createState("ingame");

        createIngameState("idling");

        gotoMainMenu();
    }

    override function onGuiLoaded() {
        super.onGuiLoaded();
        new JQuery(".play").on("click", function() {
            changeUiState("hud");
            changeState("ingame");
            changeIngameState("idling");
        });
        new JQuery(".abort").on("click", function() {
            changeUiState("main");
            changeState("menu");
        });
    }

    public function gotoMainMenu() {
        engine.updateComplete.addOnce(function() {
            changeState("menu");
            changeUiState("main");
            //debug:
            startGame();
        });
    }

    public function startGame() {
        engine.updateComplete.addOnce(function() {
            changeUiState("hud");
            changeState("ingame");
            changeIngameState("idling");
            var e = Factory.createParallax("back2", 0);
            engine.addEntity(e);
            var e = Factory.createParallax("back1", 0.5);
            engine.addEntity(e);
            var e = Factory.createParallax("back0", 1);
            engine.addEntity(e);


            var e = Factory.createShip();
            engine.addEntity(e);

            var e = Factory.createBitmapText("welcome");
            engine.addEntity(e);
        });
    }

    static function main():Void {
        new Game();
    }
}
