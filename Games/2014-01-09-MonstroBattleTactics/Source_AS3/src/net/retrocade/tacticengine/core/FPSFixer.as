

package net.retrocade.tacticengine.core {
    import flash.events.Event;
    import flash.text.TextField;
    import flash.utils.getTimer;

    import net.retrocade.functions.printf;

    import net.retrocade.retrocamel.core.RetrocamelDisplayManager;

    public class FPSFixer {
        public static const EXPECTED_FPS:Number = 60;

        public static function get currentFPS():Number{
            return RetrocamelDisplayManager.flashStage.frameRate;
        }

        public static function get factor():Number{
            return EXPECTED_FPS / currentFPS;
        }

        public static function init():void{
//            jitterDebug = new TextField();
//            jitterDebug.background = true;
//            jitterDebug.backgroundColor = 0x000000;
//            jitterDebug.textColor = 0xFFFFFF;
//            jitterDebug.width = 120;
//            jitterDebug.height = 50;
//            RetrocamelDisplayManager.flashApplication.addChild(jitterDebug);
//            RetrocamelDisplayManager.flashApplication.addEventListener(Event.ENTER_FRAME, update);
        }

//        private static var jitterDebug:TextField;
//        private static var lastUpdateTime:Number;
//        private static var jitterLevel:uint = 0;
//        private static var fpsCounterTime:Number = 0;
//        private static var fpsCounterFrames:uint = 0;
//        private static var lastFrameRate:Number = 0;
//
//        private static function update(e:Event):void{
//            if (jitterLevel > 0){
//                jitterLevel--;
//            }
//
//            var currentTime:Number = getTimer();
//
//            if (lastUpdateTime == 0){
//                lastUpdateTime = currentTime;
//            }
//
//            var timeDelta:Number = currentTime - lastUpdateTime;
//
//            if (timeDelta > 1000/10){
//                jitterLevel += 10;
//            } else if (timeDelta > 1000/20){
//                jitterLevel += 8;
//            } else if (timeDelta > 1000/33){
//                jitterLevel += 5;
//            } else if (timeDelta > 1000/50){
//                jitterLevel += 2;
//            }
//
//            fpsCounterFrames++;
//            if (fpsCounterTime === 0 || fpsCounterTime + 1000 < currentTime){
//                lastFrameRate = fpsCounterFrames;
//                fpsCounterFrames = 0;
//                fpsCounterTime = currentTime;
//            }
//
//            if (jitterDebug.parent){
//                jitterDebug.parent.removeChild(jitterDebug);
//                RetrocamelDisplayManager.flashApplication.addChild(jitterDebug);
//
//                jitterDebug.text = printf(
//                    "Jitter: %%\nCurrent FPS: %%/%%",
//                    jitterLevel,
//                    lastFrameRate,
//                    currentFPS
//                );
//            }
//        }
    }
}
