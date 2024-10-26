package{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
    import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.LocalConnection;
	import flash.utils.getDefinitionByName;
	import net.retrocade.camel.core.rSave;
	import net.retrocade.camel.rLang;

	import game.global.Pre;
	import game.states.TStatePreloader;

	import net.retrocade.camel.animations.rAnimC64;
	import net.retrocade.camel.core.rCore;
	import net.retrocade.camel.core.rDisplay;
	import net.retrocade.camel.core.rSound;
	import net.retrocade.camel.effects.rEffFadeScreen;
	import net.retrocade.camel.layers.rLayerBlit;
	import net.retrocade.camel.layers.rLayerSprite;

	/**
	 * ...
	 * @author Maurycy Zarzycki
	 */
	dynamic public class Preloader extends MovieClip {
        public static var loaderLayer:rLayerSprite;


        /****************************************************************************************************************/
		/**                                                                                                  VARIABLES  */
		/****************************************************************************************************************/

        private var _afterAd  :Boolean = true;
        private var _afterLoad:Boolean = false;



        /****************************************************************************************************************/
		/**                                                                                                  FUNCTIONS  */
		/****************************************************************************************************************/

		public function Preloader(){
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			// stage.align     = StageAlign.TOP_LEFT;
            stage.frameRate = 60;

            rCore .init(stage, this, S);
            Pre.init();

            rDisplay.setBackgroundColor(0);

            loaderLayer   = new rLayerSprite();

			rCore.setState(new TStatePreloader(getStage, isWeirdLoad, startup));

            addEventListener(Event.ENTER_FRAME, checkFrame);
		}

        private function getStage():Stage{
            return stage;
        }

        private var _lastTotal:Array = [];
        private function isWeirdLoad():Boolean {
            _lastTotal.push(stage.loaderInfo.bytesTotal);

            if (_lastTotal.length > 100)
                _lastTotal.shift();

            for each(var i:Number in _lastTotal) {
                if (i != stage.loaderInfo.bytesTotal)
                    return true;
            }

            return false;
        }

        private function checkFrame(e:Event):void{
            if (stage.loaderInfo.bytesLoaded >= stage.loaderInfo.bytesTotal && !isWeirdLoad()){
                gotoAndStop(2);

                if (currentFrame != 2)
                    return;

                removeEventListener(Event.ENTER_FRAME, checkFrame);

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

            //loadLanguagesState();
        }

        private function loadLanguagesState():void{
            //startup();
        }

		public function startup():void{
            loaderLayer.removeLayer();

            stage.focus = stage;

			addChild(new Main());
            stage.frameRate = 60;
		}
	}
}

