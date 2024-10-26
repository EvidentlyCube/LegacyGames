package game.widgets {
    import flash.events.Event;
    import game.global.Core;
    import game.global.Sfx;
    import net.retrocade.camel.core.rDisplay;
	import net.retrocade.camel.core.rInput;
	/**
     * ...
     * @author Maurycy Zarzycki
     */
    public class TWidgetVolumeMuter {

        private static var _initialVolume:Number = 0;

        public static function init():void {
            rDisplay.stage.addEventListener(Event.ACTIVATE, onActivate);
            rDisplay.stage.addEventListener(Event.DEACTIVATE, onDeactivate);
        }

        private static function onDeactivate(e:Event):void{
            Sfx.volume = 0;

            rDisplay.stage.addEventListener(Event.ENTER_FRAME, step);
			
			rInput.flushAll();
        }

        private static function onActivate(e:Event):void{
            Sfx.volume = Core.volumeMusic;

            rDisplay.stage.removeEventListener(Event.ENTER_FRAME, step);
			
			rInput.flushAll();
        }

        private static function step(e:Event):void {
            Sfx.volume = 0;
        }
    }
}