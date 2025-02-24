package{
    import flash.display.MovieClip;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
    import flash.utils.setTimeout;
    
    import net.retrocade.retrocamel.core.RetrocamelCore;
    import net.retrocade.retrocamel.core.RetrocamelStarlingCore;
    import net.retrocade.tacticengine.monstro.global.core.MonstroRoot;

    import starling.core.Starling;

    public class Main extends MovieClip{

        public function Main(){
            trace("nop!");
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            stage.frameRate = 60;


            addEventListener(flash.events.Event.ENTER_FRAME, step);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        }

		private f

        public function step(e:flash.events.Event):void{
            removeEventListener(flash.events.Event.ENTER_FRAME, step);

            Starling.handleLostContext = true;
            setTimeout(RetrocamelStarlingCore.initialize, 1000, MonstroRoot, stage, new Rectangle(0, 0, S().gameFullscreenWidth, S().gameFullscreenHeight));
        }
    }
}