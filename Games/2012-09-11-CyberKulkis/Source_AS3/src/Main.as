package{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.ByteArray;


	import net.retrocade.camel.core.rWindows;
	import net.retrocade.camel.core.rCore;
	import game.global.Game;
	import game.global.Sfx;
	import game.global.LevelManager;
	import game.states.TStateGame;

	/**
	 * ...
	 * @author Maurycy Zarzycki
	 */
	[Frame(factoryClass="Preloader")]

	public class Main extends Sprite{

        // ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Layers
		// ::::::::::::::::::::::::::::::::::::::::::::::

		public function Main():void{
            if (stage)
                init();
			else
                addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);

            Game.init();

			CheatCodes.Init();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, CheatCodes.HandleKey);
			CheatCodes.AddCheat('toot', function(): void {
                if (rCore.currentState is TStateGame && !rWindows.isAnyWindowOpen) {
                	LevelManager.levelCompleted();
                    Sfx.exitOpened();
                }
			});
		}
	}

}