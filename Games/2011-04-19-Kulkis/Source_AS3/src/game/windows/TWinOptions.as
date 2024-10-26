package game.windows {
import flash.display.Bitmap;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.net.URLRequest;
import flash.net.navigateToURL;

import game.global.Make;
import game.global.Options;

import net.retrocade.retrocamel.core.RetrocamelCore;

import net.retrocade.retrocamel.core.RetrocamelDisplayManager;

import net.retrocade.retrocamel.display.flash.RetrocamelBitmapText;
import net.retrocade.retrocamel.display.flash.RetrocamelButton;
import net.retrocade.retrocamel.display.flash.RetrocamelWindowFlash;
import net.retrocade.retrocamel.effects.RetrocamelEffectFadeFlash;
import net.retrocade.retrocamel.locale._;
import net.retrocade.utils.UtilsDisplay;

/**
 * ...
 * @author Maurycy Zarzycki
 */
public class TWinOptions extends RetrocamelWindowFlash {
    protected var wrap:Sprite;
    protected var options:Options;

    protected var closer:RetrocamelButton;

    public function TWinOptions() {
        this._blockUnder = true;
        this._pauseGame = false;

        wrap = new Sprite();

        var txt:RetrocamelBitmapText = Make.text(_("Options"), 0xFFFFFF, 3);

        options = new Options();
        closer = Make.button(onClose, _('Close'));


        wrap.addChild(txt);
        wrap.addChild(options);
        wrap.addChild(closer);
        addChild(wrap);

        graphics.beginFill(0, 0.9);
        graphics.drawRect(0, 0, S().gameWidth, S().gameHeight);

        wrap.graphics.beginFill(0, 0);
        wrap.graphics.drawRect(0, 0, width + 10, options.height + closer.height + 75);

        options.x = (wrap.width - options.width) / 2 | 0;
        options.y = 55;

        txt.x = (wrap.width - txt.width) / 2 | 0;

        closer.x = (wrap.width - closer.width) / 2 | 0;
        closer.y = wrap.height - closer.height - 10;

        wrap.x = (S().gameWidth  - wrap.width)  / 2 | 0;
        wrap.y = (S().gameHeight - wrap.height) / 2 | 0;

        RetrocamelEffectFadeFlash.make(this).alpha(0, 1).duration(250).run();
    }

    private function onClose():void {
        mouseEnabled = false;
        mouseChildren = false;
        RetrocamelEffectFadeFlash.make(this).alpha(1, 0).duration(250).callback(hide).run();
    }
}
}