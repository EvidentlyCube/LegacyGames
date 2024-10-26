package game.global.preloader {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.net.LocalConnection;
import flash.utils.getDefinitionByName;
import flash.events.KeyboardEvent;

import game.objects.*;
import game.tiles.*;
import game.global.Sfx;
import game.states.TStateLang;

import net.retrocade.retrocamel.core.RetrocamelCore;
import net.retrocade.retrocamel.core.RetrocamelDisplayManager;
import net.retrocade.retrocamel.display.layers.RetrocamelLayerFlashBlit;
import net.retrocade.retrocamel.display.layers.RetrocamelLayerFlashSprite;

/**
 * ...
 * @author Maurycy Zarzycki
 */
public class Preloader extends MovieClip {
    public static var layerSprite:RetrocamelLayerFlashSprite;
    public static var layerBlit:RetrocamelLayerFlashBlit;

    public static var percent:Number = 0;

    /****************************************************************************************************************/
    /**                                                                                                  VARIABLES  */
    /****************************************************************************************************************/

    private var _state:TStateLang;

    private var _simulateSlowDownload:Boolean;

    /****************************************************************************************************************/
    /**                                                                                                  FUNCTIONS  */

    /****************************************************************************************************************/

    public function Preloader() {
        _simulateSlowDownload = false;

        addEventListener(Event.ENTER_FRAME, init);
    }

    private function init(e:Event):void {
        if (!stage)
            return;

        removeEventListener(Event.ENTER_FRAME, init);

        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
        stage.frameRate = 60;

        Pre.preCoreInit();

        RetrocamelCore.initFlash(stage, this, S());
        Sfx.initialize();
        RetrocamelDisplayManager.setBackgroundColor(0);

        Pre.init();

        layerBlit = new RetrocamelLayerFlashBlit();
        layerSprite = new RetrocamelLayerFlashSprite();
        layerBlit.setScale(2, 2);

        _state = new TStateLang(layerSprite.layer as Sprite, startup);
        RetrocamelCore.setState(_state);

        addEventListener(Event.ENTER_FRAME, checkFrame);

        CheatCodes.Init();
        stage.addEventListener(KeyboardEvent.KEY_DOWN, CheatCodes.HandleKey);
        CheatCodes.AddCheat('clear', function(): void {
            TTileBlock.cheatClear = true;
        });
        CheatCodes.AddCheat('exit', function(): void {
            if (TExit.lastExit && TPlayer.lastPlayer) {
                TTileBlock.cheatClear = true;

                TPlayer.lastPlayer.forceStop();
                TPlayer.lastPlayer.x = TExit.lastExit.x + TExit.lastExit.width / 2 - TPlayer.lastPlayer.width / 2 | 0;
                TPlayer.lastPlayer.y = TExit.lastExit.y + TExit.lastExit.height / 2 - TPlayer.lastPlayer.height / 2 | 0;
            }
        });
    }

    private function checkFrame(e:Event):void {
        if (_simulateSlowDownload) {
            var maxPercent:Number = stage.loaderInfo.bytesLoaded * 100 / stage.loaderInfo.bytesTotal;
            percent = Math.min(
                    maxPercent,
                    percent + Math.random() * 4.9 + 0.1
            );

        } else {
            percent = stage.loaderInfo.bytesLoaded * 100 / stage.loaderInfo.bytesTotal;
        }

        if (percent >= 100) {
            gotoAndStop(2);
            removeEventListener(Event.ENTER_FRAME, checkFrame);

            dispatchEvent(new Event("gameloaded", false, false));

            _state.notifyLoadFinished();
        }
    }

    public function startup():void {
        layerSprite.removeLayer();
        layerBlit.removeLayer();

        stage.focus = stage;

        var mainClass:Class = Class(getDefinitionByName("game.global.Main"));
        addChild(new mainClass() as DisplayObject);
        stage.frameRate = 60;
    }

}

}