package{
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.display.StageQuality;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.net.LocalConnection;
    import flash.utils.getDefinitionByName;
    import flash.utils.getTimer;
    import flash.utils.setTimeout;
    import flash.ui.Keyboard;

    import game.global.Pre;
    import game.global.Sfx;
    import game.global.Make;
    import game.states.TStateLang;
    import game.states.TStatePreload;

    import net.retrocade.camel.animations.rAnimC64;
    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rDisplay;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.core.rSave;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.layers.rLayerBlit;
    import net.retrocade.camel.layers.rLayerSprite;
    import net.retrocade.standalone.Colorizer;

    /**
     * ...
     * @author Maurycy Zarzycki
     */
    public class Preloader extends MovieClip {
        [Embed(source="../assets/gfx/by_cage/cursors/cursor_arrow.png")]  public static var _gfx_arrow:Class;
        public static var cursorGfx:BitmapData;

        public static var loaderLayer:rLayerSprite;
        public static var loaderLayerBG:rLayerBlit;

        public static const DEBUG_MODE:Boolean = false;

        public static var percent:Number = 0;

        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

        private var _afterAd  :Boolean = false;
        private var _afterLoad:Boolean = false;

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

            rCore.setState(new TStatePreload());

            _afterAd = true;
            Pre.setCursor();

            addEventListener(Event.ENTER_FRAME, checkFrame);

            _startedAt = getTimer();

            initKeyboardShortcuts();
        }

		private function initKeyboardShortcuts():void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, function(event: KeyboardEvent): void {
				switch (event.keyCode) {
					case(Keyboard.F4):
						if (rDisplay.scaleToFit && rDisplay.scaleToInteger) {
							rDisplay.scaleToFit = true;
							rDisplay.scaleToInteger = false;

						} else if (rDisplay.scaleToFit && !rDisplay.scaleToInteger) {
							rDisplay.scaleToFit = false;
							rDisplay.scaleToInteger = false;

						} else {
							rDisplay.scaleToFit = true;
							rDisplay.scaleToInteger = true;
						}
						rSave.write('scaleToFit', rDisplay.scaleToFit ? "1" : "0");
						rSave.write('scaleToInteger', rDisplay.scaleToInteger ? "1" : "0");
						rSave.flush();
						break;
					case(Keyboard.F9):
						if (rDisplay.quality === StageQuality.HIGH) {
							rDisplay.quality = StageQuality.LOW;
						} else if (rDisplay.quality === StageQuality.LOW) {
							rDisplay.quality = StageQuality.MEDIUM;
						} else {
							rDisplay.quality = StageQuality.HIGH;
						}
						break;
					case(Keyboard.ENTER):
						if (event.altKey) {
							rDisplay.toggleFullScreen();
						}
						break;
				}
			});
		}
        private function checkFrame(e:Event):void{
            percent = stage.loaderInfo.bytesLoaded * 100 / stage.loaderInfo.bytesTotal
            if (stage.loaderInfo.bytesLoaded >= stage.loaderInfo.bytesTotal){
                gotoAndStop(2);
                removeEventListener(Event.ENTER_FRAME, checkFrame);

                dispatchEvent(new Event("gameloaded", false, false));

                _afterLoad = true;

                if (_afterAd)
                    initLanguageSelection();

            }
        }

        private function initLanguageSelection():void{
            if (!_afterLoad){
                _afterAd = true;
                return;
            }

            new rEffFadeScreen(1, 0, 0, 500, loadLanguagesState);
        }

        private function loadLanguagesState():void{
            new rEffFadeScreen(0, 1, 0, 500);

            rCore.setState(new TStateLang(startup));
        }

        private function soundMakeFinished():void{
            stage.frameRate = 60;
        }

        public function startup():void{
            loaderLayer  .removeLayer();
            loaderLayerBG.removeLayer();

            stage.focus = stage;

            var mainClass:Class = Class(getDefinitionByName("Main"));
            addChild(new mainClass() as DisplayObject);
            stage.frameRate = 60;
        }

    }

}