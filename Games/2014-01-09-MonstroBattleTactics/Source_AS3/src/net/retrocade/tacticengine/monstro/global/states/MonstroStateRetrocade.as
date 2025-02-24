
package net.retrocade.tacticengine.monstro.global.states {

	import flash.events.Event;

	import net.retrocade.retrocamel.components.RetrocamelStateBase;
	import net.retrocade.retrocamel.core.RetrocamelInputManager;
	import net.retrocade.tacticengine.monstro.global.core.MonstroData;
	import net.retrocade.tacticengine.monstro.global.states.titleScreen.MonstroRetrocadeLogoVideoPlayer;

	public class MonstroStateRetrocade extends RetrocamelStateBase {
		public static function show():void {
			var instance:MonstroStateRetrocade = new MonstroStateRetrocade();

			instance.setToMe();
		}

		private var _sawIntro:Boolean;
		private var _video:MonstroRetrocadeLogoVideoPlayer;

		override public function create():void {
			super.create();

			_l("MonstroStateRetrocade::create()");

			_sawIntro = MonstroData.getSawIntro(false);
			_l("MonstroStateRetrocade::create() -> sawIntro=" + _sawIntro);

			_video = new MonstroRetrocadeLogoVideoPlayer("video/retrocadeLogo.mp4", MonstroStateTitle.show);
			_l("MonstroStateRetrocade::create() -> loaded video");
			RetrocamelInputManager.flushAll();

			RetrocamelInputManager.addStageMouseDown(preventDefault, false, 100);
			RetrocamelInputManager.addStageMouseClick(preventDefault, false, 100);
		}


		override public function update():void {
			_l("MonstroStateRetrocade::update()");

			if (!_sawIntro) {
				return;
			}

			if (RetrocamelInputManager.isAnyKeyDown() || RetrocamelInputManager.isMouseDown) {
				RetrocamelInputManager.flushAll();
				MonstroStateTitle.show();
			}
		}

		override public function destroy():void {
			_l("MonstroStateRetrocade::destroy()");

			RetrocamelInputManager.removeStageMouseDown(preventDefault);
			RetrocamelInputManager.removeStageMouseClick(preventDefault);

			_video.dispose();
			_video = null;

			super.destroy();
		}

		private function preventDefault(event:Event):void {
			_video.stop();

			event.stopImmediatePropagation();
			event.preventDefault();

			RetrocamelInputManager.flushAll();
			MonstroStateTitle.show();
		}
	}
}
