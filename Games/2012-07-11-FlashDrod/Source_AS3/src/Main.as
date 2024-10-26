package{
    import flash.display.BitmapData;
    import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;
    import game.global.Commands;
    import game.global.CueEvents;
    import game.global.Game;
    import game.global.Room;
    import net.retrocade.camel.core.rCore;
    import net.retrocade.standalone.Bitext;
    import net.retrocade.standalone.BitextFont;

	import game.global.Core;

	/**
	 * ...
	 * @author Maurycy Zarzycki
	 */
	[Frame(factoryClass="Preloader")]

    CF::play
    public class Main extends Sprite{

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Layers
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public function Main():void {
            if (stage)
                init();
            else
                addEventListener(Event.ADDED_TO_STAGE, init);
        }

        private function init(e:Event = null):void{
            removeEventListener(Event.ADDED_TO_STAGE, init);

            Core.init();
        }
    }

}