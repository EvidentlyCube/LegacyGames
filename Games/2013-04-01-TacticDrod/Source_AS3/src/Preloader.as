package {
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.net.LocalConnection;
    import flash.utils.getDefinitionByName;

    import net.retrocade.camel.global.rCore;

    import net.retrocade.tacticengine.monstro.core.CoreInit;
    import net.retrocade.tacticengine.monstro.states.MonstroStatePreloader;

    /**
     * ...
     * @author Maurycy Zarzycki
     */
    dynamic public class Preloader extends MovieClip {

        public static var progress:Number = 0;


        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

        private var _afterLoad:Boolean = false;


        private var _state:MonstroStatePreloader;

        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        public function Preloader(){
            addEventListener(Event.ENTER_FRAME, initRoot);
            addEventListener(Event.ENTER_FRAME, checkFrame);
        }

        private function initRoot(e:Event = null):void{
            if (stage){
                removeEventListener(Event.ENTER_FRAME, initRoot);
                CoreInit.init(this);


                _state = new MonstroStatePreloader();
                _state.addEventListener(Event.COMPLETE, onPreloaderComplete);
                rCore.setState(_state);
            }
        }

        private function onPreloaderComplete(e:Event):void{
            _state.removeEventListener(Event.COMPLETE, onPreloaderComplete);
            _state = null;

            startup();
        }

        private function checkFrame(e:Event):void{
            progress = stage.loaderInfo.bytesLoaded / stage.loaderInfo.bytesTotal;

            if (stage.loaderInfo.bytesLoaded >= stage.loaderInfo.bytesTotal){
                gotoAndStop(2);

                if (currentFrame != 2)
                    return;

                removeEventListener(Event.ENTER_FRAME, checkFrame);

                _afterLoad = true;
            }
        }


        public function startup():void{
            stage.focus = stage;

            addChild(new CoreStarter() as DisplayObject);
            stage.frameRate = 60;
        }
    }
}

