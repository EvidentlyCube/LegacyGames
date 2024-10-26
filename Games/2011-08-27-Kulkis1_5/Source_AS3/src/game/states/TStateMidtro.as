package game.states {
	import game.global.Game;
	import game.global.Level;
	import game.global.Score;

	import net.retrocade.constants.KeyConst;

	import net.retrocade.retrocamel.components.RetrocamelStateBase;
	import net.retrocade.retrocamel.core.RetrocamelCore;
	import net.retrocade.retrocamel.core.RetrocamelInputManager;
	import net.retrocade.retrocamel.core.RetrocamelSoundManager;
	import net.retrocade.retrocamel.display.flash.RetrocamelBitmapText;
	import net.retrocade.retrocamel.effects.RetrocamelEffectFadeFlash;
	import net.retrocade.retrocamel.effects.RetrocamelEffectFadeScreen;
	import net.retrocade.retrocamel.effects.RetrocamelEffectMusicFade;
	import net.retrocade.retrocamel.locale._;

	/**
	 * ...
	 * @author
	 */
	public class TStateMidtro extends RetrocamelStateBase {
		private static var _instance:TStateMidtro = new TStateMidtro();
		public static function get instance():TStateMidtro {
			return _instance;
		}

		private var _timer:Number = 0;

		private var _text1:RetrocamelBitmapText;

		private var _ct:RetrocamelBitmapText;
		private var _ctTimer:uint = 0;

		private var _isClosing:Boolean = false;

		public function TStateMidtro() {
			_text1 = new RetrocamelBitmapText();
		}

		override public function create():void {
			_isClosing = false;

			_text1.align = RetrocamelBitmapText.ALIGN_MIDDLE;

			var txt:String;

			switch (Score.level.get()) {
				case(7):
					txt = _('midtro7');
					break;

				case(13):
					txt = _('midtro13');
					break;

				case(19):
					txt = _('midtro19');
					break;
			}

			_text1.text = _text1.getWordWrapToWidth(txt, 230);
			_text1.setScale(2);

			_text1.positionToCenterScreen();
			_text1.positionToMiddleScreen();
			_text1.addShadow();

			_ct = new RetrocamelBitmapText(_("Hit Space to Continue"));
			_ct.setScale(2);
			_ct.addShadow();
			_ct.positionToCenterScreen();
			_ct.y = S().gameHeight - _ct.height - 5;


			_timer = 0;

			RetrocamelEffectFadeScreen.makeIn().duration(400).run();
			RetrocamelEffectFadeFlash.make(_text1).alpha(0, 1).duration(500).run();

			Game.lMain.add(_text1);
			Game.lMain.add(_ct);

			_text1.alpha = 0;

			RetrocamelSoundManager.playMusic(TStateIntro.music);
			RetrocamelEffectMusicFade.make(1).duration(500).run();
		}

		override public function destroy():void {
			Game.lMain.clear();
			RetrocamelSoundManager.stopMusic();
		}

		override public function update():void {
			if (RetrocamelInputManager.isKeyHit(KeyConst.SPACE) && !_isClosing) {
				RetrocamelEffectFadeScreen.makeOut().duration(1000).callback(continueGame).run();
				RetrocamelEffectMusicFade.make(0).duration(800).run();
			}


			_ctTimer++;

			_ct.visible = _ctTimer % 100 < 50;


			_timer++;
			if (_timer == 0 && RetrocamelInputManager.isKeyHit(KeyConst.SPACE))
				RetrocamelEffectFadeFlash.make(_text1).alpha(1, 0).duration(500).callback(startClosing).run();

		}

		private function startClosing():void {
			RetrocamelEffectFadeScreen.makeOut().duration(1000).callback(continueGame).run();
			_isClosing = true;
		}

		private function continueGame():void {
			RetrocamelCore.setState(TStateGame.instance);
			Level.continueAfterMidtro();
		}
	}
}