package game.windows {

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.net.navigateToURL;

import game.global.Level;
import game.global.Make;
import game.global.Music;
import game.global.Options;
import game.objects.TEscButton;
import game.states.TStateTitle;

import net.retrocade.retrocamel.core.RetrocamelCore;
import net.retrocade.retrocamel.display.flash.RetrocamelBitmapText;
import net.retrocade.retrocamel.display.flash.RetrocamelButton;
import net.retrocade.retrocamel.display.flash.RetrocamelWindowFlash;
import net.retrocade.retrocamel.display.global.RetrocamelTooltip;
import net.retrocade.retrocamel.effects.RetrocamelEffectFadeFlash;
import net.retrocade.retrocamel.effects.RetrocamelEffectFadeScreen;
import net.retrocade.retrocamel.locale._;
import net.retrocade.utils.UtilsDisplay;
import net.retrocade.utils.UtilsGraphic;

public class TWinPause extends RetrocamelWindowFlash {
    private static var _instance:TWinPause = new TWinPause();

    public static function get instance():TWinPause {
        return _instance;
    }


    protected var wrap:Sprite;
    protected var options:Options;

    protected var restart:RetrocamelButton;
    protected var toMenu:RetrocamelButton;
    protected var closer:RetrocamelButton;

    public function TWinPause() {
        this._blockUnder = true;
        this._pauseGame = true;

        wrap = new Sprite();

        var txt:RetrocamelBitmapText = Make.text(_("Game is Paused"), 0xFFFFFF, 2);

        options = new Options();
        closer = Make.button(onClose, _('Return to Game'));
        restart = Make.button(onRestart, _('Restart'));
        toMenu = Make.button(onMenu, _('Return to Title Screen'));

        wrap.addChild(txt);
        wrap.addChild(options);
        wrap.addChild(closer);
        wrap.addChild(restart);
        wrap.addChild(toMenu);
        addChild(wrap);

        options.y = 25;
        closer.y = options.y + options.height + 5;
        restart.y = closer.y + closer.height + 5;
        toMenu.y = restart.y + restart.height + 5;

        graphics.beginFill(0, 0.9);
        graphics.drawRect(0, 0, S().gameWidth, S().gameHeight);
        wrap.graphics.beginFill(0, 0);
        wrap.graphics.drawRect(0, 0, 300, options.height + closer.height + 75);

        txt.x = (wrap.width - txt.width) / 2 + 5 | 0;
        closer.x = (wrap.width - closer.width) / 2 + 5 | 0;
        options.x = (wrap.width - options.width) / 2 + 5 | 0;
        restart.x = (wrap.width - restart.width) / 2 + 5 | 0;
        toMenu.x = (wrap.width - toMenu.width) / 2 + 5 | 0;

        wrap.x = (S().gameWidth  - wrap.width)  / 2 | 0;
        wrap.y = (S().gameHeight - wrap.height) / 2 | 0;

        restart.rollOverCallback = RetrocamelTooltip.show;
        restart.rollOutCallback = RetrocamelTooltip.hide;

        toMenu.rollOverCallback = RetrocamelTooltip.show;
        toMenu.rollOutCallback = RetrocamelTooltip.hide;

        RetrocamelTooltip.hookToObject(restart, _('Click loses progress'));
        RetrocamelTooltip.hookToObject(toMenu, _('Click loses progress'));
    }

    override public function show():void {
        super.show();

        RetrocamelEffectFadeFlash.make(this).alpha(0, 1).duration(250).run();
        mouseEnabled = true;
        mouseChildren = true;

        TEscButton.disactivate();
    }


    // ::::::::::::::::::::::::::::::::::::::::::::::
    // :: RetrocamelButton Callbacks
    // ::::::::::::::::::::::::::::::::::::::::::::::

    private function onClose():void {
        mouseEnabled = false;
        mouseChildren = false;
        RetrocamelEffectFadeFlash.make(this).alpha(1, 0).duration(250).callback(efFinClose).run();
    }

    private function onRestart():void {
        mouseEnabled = false;
        mouseChildren = false;
        RetrocamelEffectFadeFlash.make(this).alpha(1, 0).duration(250).callback(efFinRestart).run();
    }

    private function onMenu():void {
        RetrocamelEffectFadeFlash.make(this).alpha(1, 0).duration(250).run();
        RetrocamelEffectFadeScreen.makeOut().duration(1000).callback(efFinReturnToMenu).run();
        Music.targetFadeFactor = 0;
    }


    // ::::::::::::::::::::::::::::::::::::::::::::::
    // :: Effect Callbacks
    // ::::::::::::::::::::::::::::::::::::::::::::::

    private function efFinClose():void {
        hide();
    }

    private function efFinReturnToMenu():void {
        hide();
        RetrocamelCore.setState(new TStateTitle);
        Music.pause();
        Music.musicFadeFactor = 1;
        Music.targetFadeFactor = 1;
    }

    private function efFinRestart():void {
        hide();

        if (Level.player)
            Level.player.kill();
    }

}
}