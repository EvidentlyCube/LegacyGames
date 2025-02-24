package net.retrocade.tacticengine.monstro.global.core {
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.system.Security;
    import flash.utils.getDefinitionByName;

    import net.retrocade.random.Random;

    import net.retrocade.retrocamel.core.RetrocamelCore;
    import net.retrocade.tacticengine.core.FPSFixer;

    import net.retrocade.tacticengine.monstro.global.states.MonstroStatePreloader;

    /**
     * ...
     * @author Maurycy Zarzycki
     */
    dynamic public class Preloader extends MovieClip {
        private static const CROSS_DOMAIN_URL:String = "http://remote.retrocade.net/crossdomain.xml";

        public static var progress:Number = 0;


        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

        public static var afterLoad:Boolean = false;


        private var _state:MonstroStatePreloader;
        public static var adsFinished:Boolean = false;

        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        public function Preloader(){
            Security.loadPolicyFile(CROSS_DOMAIN_URL);

//            var lc:LocalConnection = new LocalConnection();
//            if (lc.domain.indexOf("retrocade_old.net") == -1 && lc.domain.indexOf("localhost") == -1){
//                return;
//            }

            addEventListener(Event.ENTER_FRAME, initRoot);
            addEventListener(Event.ENTER_FRAME, checkFrame);

            initRoot();
        }

        private function initRoot(e:Event = null):void{
            if (stage){
y
                removeEventListener(Event.ENTER_FRAME, initRoot);
                CoreInit.init(this);

                _state = new MonstroStatePreloader();
                _state.addEventListener(Event.COMPLETE, onPreloaderComplete);
                RetrocamelCore.setState(_state);
                onAdsLoaded();
            }
        }

        public function onAdsLoaded():void {
            adsFinished = true;
        }

        private function onPreloaderComplete(e:Event):void{
            _state.removeEventListener(Event.COMPLETE, onPreloaderComplete);
            _state = null;

            startup();
        }

        private function checkFrame(e:Event):void{
            var realProgress:Number = stage.loaderInfo.bytesLoaded / stage.loaderInfo.bytesTotal;

            progress = Math.min(realProgress, progress + Random.defaultEngine.getNumberRange(0.001, adsFinished ? 0.1 : 0.005));

            if (progress >= 1){
                gotoAndStop(2);

                if (currentFrame != 2)
                    return;

                removeEventListener(Event.ENTER_FRAME, checkFrame);

                afterLoad = true;
            }
        }


        public function startup():void{
            stage.focus = stage;

            FPSFixer.init();
            var mainClass:Class = Class(getDefinitionByName("net.retrocade.tacticengine.monstro.global.core.CoreStarter"));
            addChild(new mainClass() as DisplayObject);
            stage.frameRate = 30;
        }
    }
}

