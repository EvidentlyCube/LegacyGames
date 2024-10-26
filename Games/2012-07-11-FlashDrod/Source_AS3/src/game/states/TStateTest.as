package game.states{
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.net.FileReference;
    import flash.ui.Keyboard;

    import game.global.DB;

    import net.retrocade.camel.core.rDisplay;
    import net.retrocade.camel.core.rState;
    import net.retrocade.utils.Key;

    public class TStateTest extends rState{
        [Embed(source="/../assets/sfx/ShortHarps.mp3", mimeType='application/octet-stream')] private static var lol:Class;

        public function TStateTest(){
            super();
        }

        override public function create():void{
            rDisplay.stage.addEventListener(KeyboardEvent.KEY_DOWN, k);
        }

        private function k(e:KeyboardEvent):void{
            DB.getSpeech(1);
        }

    }
}