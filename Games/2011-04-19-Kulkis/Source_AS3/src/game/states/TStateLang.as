package game.states {
import flash.display.Bitmap;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.net.navigateToURL;

import game.display.OldSwfPlayer;

import game.display.PixelBugEffect;
import game.global.Make;
import game.global.preloader.Pre;
import game.global.preloader.Preloader;

import net.retrocade.retrocamel.components.RetrocamelStateBase;
import net.retrocade.retrocamel.core.retrocamel_int;
import net.retrocade.retrocamel.display.flash.RetrocamelBitmapText;
import net.retrocade.retrocamel.display.flash.RetrocamelButton;
import net.retrocade.retrocamel.display.global.RetrocamelTooltip;
import net.retrocade.retrocamel.display.layers.RetrocamelLayerFlashBlit;
import net.retrocade.retrocamel.display.layers.RetrocamelLayerFlashSprite;
import net.retrocade.retrocamel.effects.RetrocamelEffectFadeScreen;
import net.retrocade.retrocamel.locale.RetrocamelLocale;
import net.retrocade.retrocamel.locale._;
import net.retrocade.utils.UtilsGraphic;

use namespace retrocamel_int;

/**
 * ...
 * @author Maurycy Zarzycki
 */
public class TStateLang extends RetrocamelStateBase {
    /****************************************************************************************************************/
    /**                                                                                                  VARIABLES  */
    /****************************************************************************************************************/

    private var _logo:Bitmap;
    private var _parent:Sprite;
    private var _blitLayer:RetrocamelLayerFlashBlit;
    private var _spriteLayer:RetrocamelLayerFlashSprite;

    private var _flags:Array = [];
    private var _flagsGroup:Sprite;

    private var _langText:RetrocamelBitmapText;
    private var _loadingTextWaveAnimator:Number = 0;

    private var _startupFunction:Function;

    private var _loadFinished:Boolean = false;

    /****************************************************************************************************************/
    /**                                                                                                  FUNCTIONS  */
    /****************************************************************************************************************/

    // ::::::::::::::::::::::::::::::::::::::::::::::::
    // :: Creation
    // ::::::::::::::::::::::::::::::::::::::::::::::::

    public function TStateLang(parent:Sprite, startupFunction:Function) {
        _startupFunction = startupFunction;
        _logo = new Pre.__logo__;
        _logo.smoothing = false;
        _logo.scaleX = 2;
        _logo.scaleY = 2;

        _loadFinished = false;

        _parent = parent;
        _blitLayer = Preloader.layerBlit;
        _spriteLayer = Preloader.layerSprite;

        _spriteLayer.add(_logo);
        _logo.x = (S().gameWidth - _logo.width) / 2;
        _logo.y = _logo.x / 2;

        _flagsGroup = new Sprite();

        var flag:RetrocamelButton;
        var lastFlag:RetrocamelButton;
        var tempFlag:RetrocamelButton;
        var slide:Number;

        for each(var s:String in S().languages) {
            //flag = new RetrocamelButton(onButtonClick, onButtonOver, onButtonOut, true);
            flag = Make.button(onButtonClick, S().languagesNames[S().languages.indexOf(s)]);
            flag.rollOutCallback = onButtonOut;
            flag.rollOverCallback = onButtonOver;
            flag.data.lang = s;

            RetrocamelTooltip.hook(flag, S().languagesNames[S().languages.indexOf(s)]);

            //flag.data.txt.text = S.LANGUAGES_NAMES[S.LANGUAGES.indexOf(s)];
            //flag.data.grid9.width = flag.width;

            _flags.push(flag);

            if (lastFlag) {
                flag.x = lastFlag.x + lastFlag.width + 8;
                flag.y = lastFlag.y;

                if (flag.x + flag.width > S().gameWidth - 100) {
                    slide = (S().gameWidth - 100 - lastFlag.x - lastFlag.width) / 2 | 0;
                    for each (tempFlag in _flags) {
                        if (tempFlag.y == flag.y)
                            tempFlag.x += slide;
                    }

                    flag.x = 0;
                    flag.y += 44;
                }
            }

            lastFlag = flag;

            _flagsGroup.addChild(flag);
        }

        _flagsGroup.visible = false;

        slide = (S().gameWidth - 100 - lastFlag.x - lastFlag.width) / 2 | 0;
        for each (tempFlag in _flags) {
            if (tempFlag.y == flag.y)
                tempFlag.x += slide;
        }

        _flagsGroup.x = 50;
        _flagsGroup.y = S().gameHeight - 50 - _flagsGroup.height;

        _langText = Make.text('asd', 0xFFFFFF, 2, 0, 60);
        _langText.text = RetrocamelLocale.get(null, 'choseLanguage');

        _parent.addChild(_flagsGroup);
        _parent.addChild(_langText);

        updateText();
    }

    public function notifyLoadFinished():void {
        _loadFinished = true;
        _langText.text = RetrocamelLocale.get(null, 'choseLanguage');

        _flagsGroup.visible = true;
        centerizeMessage();
    }

    override public function create():void {
        new PixelBugEffect(_blitLayer, S().gameWidth, S().gameHeight, 1 + Math.random() * 5, 0xFFAA0000, 0xFF220000);
        new PixelBugEffect(_blitLayer, S().gameWidth, S().gameHeight, 1 + Math.random() * 5, 0xFF00AA00, 0xFF002200);
        new PixelBugEffect(_blitLayer, S().gameWidth, S().gameHeight, 1 + Math.random() * 5, 0xFF0000AA, 0xFF000022);
        new PixelBugEffect(_blitLayer, S().gameWidth, S().gameHeight, 1 + Math.random() * 5, 0xFFAAAA00, 0xFF222200);
        new PixelBugEffect(_blitLayer, S().gameWidth, S().gameHeight, 1 + Math.random() * 5, 0xFFAA00AA, 0xFF220022);
        new PixelBugEffect(_blitLayer, S().gameWidth, S().gameHeight, 1 + Math.random() * 5, 0xFF00AAAA, 0xFF002222);
        new PixelBugEffect(_blitLayer, S().gameWidth, S().gameHeight, 1 + Math.random() * 5, 0xFFAA0000, 0xFF220000);
        new PixelBugEffect(_blitLayer, S().gameWidth, S().gameHeight, 1 + Math.random() * 5, 0xFF00AA00, 0xFF002200);
        new PixelBugEffect(_blitLayer, S().gameWidth, S().gameHeight, 1 + Math.random() * 5, 0xFF0000AA, 0xFF000022);
        new PixelBugEffect(_blitLayer, S().gameWidth, S().gameHeight, 1 + Math.random() * 5, 0xFFAAAA00, 0xFF222200);
        new PixelBugEffect(_blitLayer, S().gameWidth, S().gameHeight, 1 + Math.random() * 5, 0xFFAA00AA, 0xFF220022);
        new PixelBugEffect(_blitLayer, S().gameWidth, S().gameHeight, 1 + Math.random() * 5, 0xFF00AAAA, 0xFF002222);
        new PixelBugEffect(_blitLayer, S().gameWidth, S().gameHeight, 1 + Math.random() * 5, 0xFFAA0000, 0xFF220000);
        new PixelBugEffect(_blitLayer, S().gameWidth, S().gameHeight, 1 + Math.random() * 5, 0xFF00AA00, 0xFF002200);
        new PixelBugEffect(_blitLayer, S().gameWidth, S().gameHeight, 1 + Math.random() * 5, 0xFF0000AA, 0xFF000022);
        new PixelBugEffect(_blitLayer, S().gameWidth, S().gameHeight, 1 + Math.random() * 5, 0xFFAAAA00, 0xFF222200);
        new PixelBugEffect(_blitLayer, S().gameWidth, S().gameHeight, 1 + Math.random() * 5, 0xFFAA00AA, 0xFF220022);
        new PixelBugEffect(_blitLayer, S().gameWidth, S().gameHeight, 1 + Math.random() * 5, 0xFF00AAAA, 0xFF002222);
    }

    override public function update():void {
        if (!_loadFinished){
            updateText();
        }

        _loadingTextWaveAnimator += Math.PI / 110;
        super.update();
    }

    private function updateText(): void {
        _langText.text = _("loading") + " " + Preloader.percent.toFixed(1) + "%";

        centerizeMessage();
    }

// ::::::::::::::::::::::::::::::::::::::::::::::::
    // :: Helpers
    // ::::::::::::::::::::::::::::::::::::::::::::::::

    private function centerizeMessage():void {
        _langText.positionToCenterScreen();
        _langText.y = _logo.y + _logo.height + 25 + Math.sin(_loadingTextWaveAnimator) * 8.3;
    }


    // ::::::::::::::::::::::::::::::::::::::::::::::::
    // :: Events
    // ::::::::::::::::::::::::::::::::::::::::::::::::

    private function onFaded():void {
        _parent.removeChild(_flagsGroup);
        _parent.removeChild(_langText);

        _startupFunction();
    }

    private function onButtonClick(data:RetrocamelButton):void {
        RetrocamelEffectFadeScreen.makeOut().duration(1000).callback(onFaded).run();

        _flagsGroup.mouseChildren = false;

        RetrocamelLocale.selected = data.data.lang;
    }

    private function onButtonOver(data:RetrocamelButton):void {
        _langText.text = RetrocamelLocale.get(data.data.lang as String, 'choseLanguage');
        centerizeMessage();
    }

    private function onButtonOut(data:RetrocamelButton):void {
        _langText.text = RetrocamelLocale.get(null, 'choseLanguage');
        centerizeMessage();
    }

}

}