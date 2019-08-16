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

        var menuState = createState("menu");
        menuState.addInstance(new MenuSystem());
        createUiState("main", ".default");
        createUiState("lobby", ".lobby");
        createUiState("hud", ".hud");

        var introState = createState("intro");
        introState.addInstance(new IntroSystem());

        var ingameState = createState("ingame");
        ingameState.addInstance(new EnemySystem());

        createIngameState("idling");

        gotoMainMenu();

        var e = Factory.createParallax("back2", 0);
        engine.addEntity(e);
        var e = Factory.createParallax("back1", 0.5);
        engine.addEntity(e);
        var e = Factory.createParallax("back0", 1);
        engine.addEntity(e);
    }

    override function onGuiLoaded() {
        super.onGuiLoaded();
    }

    public function gotoMainMenu() {
        engine.updateComplete.addOnce(function() {
            changeState("menu");
            changeUiState("main");
        });
    }

    public function startIntro() {
        engine.updateComplete.addOnce(function() {
            changeUiState("hud");
            changeState("intro");
        });
    }

    public function startGame() {
        engine.updateComplete.addOnce(function() {
            changeUiState("hud");
            changeState("ingame");
            changeIngameState("idling");
        });
    }

    static function main():Void {
        new Game();
    }
}
