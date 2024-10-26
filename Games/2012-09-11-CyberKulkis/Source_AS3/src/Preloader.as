package{
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.net.LocalConnection;
    import flash.utils.getDefinitionByName;
    import flash.utils.getTimer;
    import flash.utils.setTimeout;

    import game.global.Make;
    import game.global.Pre;
    import game.states.TStatePreload;

    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rDisplay;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.layers.rLayerBlit;
    import net.retrocade.camel.layers.rLayerSprite;
    import net.retrocade.standalone.Colorizer;

    /**
     * ...
     * @author Maurycy Zarzycki
     */
    dynamic public class Preloader extends MovieClip {
        public static var loaderLayer:rLayerSprite;
        public static var loaderLayerBG:rLayerBlit;

        public static const DEBUG_MODE:Boolean = false;

        public static var percent:Number = 0;

        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

        private var _startedAt:Number;



        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        public function Preloader(){
            /*var lc:LocalConnection = new LocalConnection();
            if (lc.domain.indexOf("localhost") == -1 &&
            lc.domain.indexOf("flashgamelicense") == -1)
            return;
            /*
            if ((new Date).fullYear > 2011 || (new Date).month > 6 || (new Date).day > 31)
            return;
            */

            addEventListener(Event.ENTER_FRAME, init);
        }

        private function init(e:Event):void{
            if (!stage)
                return;

            removeEventListener(Event.ENTER_FRAME, init);

            stage.frameRate = 60;

            Pre.preCoreInit();

            rCore .init(stage, this, S(), Make());
            rDisplay.setBackgroundColor(0);

            Pre.init();

            loaderLayerBG = new rLayerBlit();
            loaderLayer   = new rLayerSprite();
            loaderLayerBG.setScale(2, 2);

            addEventListener(Event.ENTER_FRAME, checkFrame);

            _startedAt = getTimer();
        }

        private function checkFrame(e:Event):void{
            percent = stage.loaderInfo.bytesLoaded * 100 / stage.loaderInfo.bytesTotal
            if (stage.loaderInfo.bytesLoaded >= stage.loaderInfo.bytesTotal){
                gotoAndStop(2);

                removeEventListener(Event.ENTER_FRAME, checkFrame);

                dispatchEvent(new Event("gameloaded", false, false));

                initFirstState();
            }
        }

        private function initFirstState():void{
            TStatePreload.instance.set();
            TStatePreload.instance.addEventListener("start", startup);
        }

        private function soundMakeFinished():void{
            stage.frameRate = 60;
        }

        public function startup(e:Event):void{
            loaderLayer  .removeLayer();
            loaderLayerBG.removeLayer();

            stage.focus = stage;

            var mainClass:Class = Class(getDefinitionByName("Main"));
            addChild(new mainClass() as DisplayObject);
            stage.frameRate = 60;
        }

    }

}