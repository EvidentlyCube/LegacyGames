package game.global {
import flash.display.Sprite;
import flash.events.Event;

/**
 * ...
 * @author Maurycy Zarzycki
 */
public class Main extends Sprite {

    // ::::::::::::::::::::::::::::::::::::::::::::::
    // :: Layers
    // ::::::::::::::::::::::::::::::::::::::::::::::

    public function Main():void {
        if (stage)
            init();
        else
            addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event = null):void {
        removeEventListener(Event.ADDED_TO_STAGE, init);

        Game.init();
    }
}

}