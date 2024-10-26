package game.states {
	import flash.display.MovieClip;
	import flash.display.Shape;

	import game.global.Game;
	import game.global.Level;

	import net.retrocade.constants.KeyConst;
	import net.retrocade.retrocamel.components.RetrocamelStateBase;
	import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
	import net.retrocade.retrocamel.core.RetrocamelInputManager;
	import net.retrocade.retrocamel.core.RetrocamelSoundManager;
	import net.retrocade.retrocamel.display.flash.RetrocamelBitmapText;
	import net.retrocade.retrocamel.effects.RetrocamelEffectFadeFlash;
	import net.retrocade.retrocamel.effects.RetrocamelEffectFadeScreen;
	import net.retrocade.retrocamel.effects.RetrocamelEffectMusicFade;
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.utils.UtilsGraphic;

	/**
	 * ...
	 * @author
	 */
	public class TStateOutro extends RetrocamelStateBase {
		private static var _instance:TStateOutro = new TStateOutro();
		public static function get instance():TStateOutro {
			return _instance;
		}


		private var _timer:Number = 0;
		private var _state:Number = 0;

		private var _ct:RetrocamelBitmapText;
		private var _ctTimer:uint = 0;

		private var _outro:MovieClip;
		private var _bg:Shape;

		private var _text:RetrocamelBitmapText;

		public function TStateOutro():void {
			_text = new RetrocamelBitmapText();

			_text.align = RetrocamelBitmapText.ALIGN_MIDDLE;
			_text.setScale(2);
			_text.addShadow();

			_ct = new RetrocamelBitmapText(_("Hit Space to Continue"));

			_bg = new Shape();
		}

		override public function create():void {
			_text.text = _text.getWordWrapToWidth(_("outro1"), 230);

			_text.positionToCenterScreen();
			_text.positionToMiddleScreen();

			_timer = 0;
			_state = 0;

			_ct.setScale(2);
			_ct.addShadow();
			_ct.positionToCenterScreen();
			_ct.y = S().gameHeight - _ct.height - 5;


			RetrocamelEffectFadeScreen.makeIn().duration(400).run();
			RetrocamelEffectFadeFlash.make(_text).alpha(0, 1).duration(500).run();

			Game.lMain.add(_bg);
			Game.lMain.add(_text);
			Game.lMain.add(_ct);


			_text.alpha = 0;

			RetrocamelSoundManager.playMusic(TStateIntro.music);
			RetrocamelEffectMusicFade.make(1).duration(500).run();


			Game.lBG.draw(RetrocamelBitmapManager.getBD(Level._bg_), 0, 0);

			UtilsGraphic.clear(_bg).rectFill(0, _text.y - 5, S().gameWidth, _text.height + 10, 0, 0.70);
		}

		override public function destroy():void {
			Game.lMain.clear();
			RetrocamelSoundManager.stopMusic();
			_outro = null;
		}

		override public function update():void {
			if (RetrocamelInputManager.isAnyKeyHit() && _state != 99 && !RetrocamelInputManager.isKeyHit(KeyConst.SPACE)) {
				RetrocamelEffectFadeScreen.makeOut().duration(1000).callback(endGame).run();
				RetrocamelEffectMusicFade.make(0).duration(800).run();
				_state = 99;
			}

			_ctTimer++;

			_ct.visible = _ctTimer % 100 < 50;

			switch (_state) {
				case(0):
					if (_timer == 0 && RetrocamelInputManager.isKeyHit(KeyConst.SPACE)) {
						_timer = 1;
						new RetrocamelEffectFadeFlash(_text).alpha(1, 0).duration(500).callback(case0FadeoutFinished).run();
						function case0FadeoutFinished():void {
							_state = 1;
							_timer = 0;

							_text.text = _text.getWordWrapToWidth(_("outro2"), 230);
							_text.positionToCenterScreen();
							_text.positionToMiddleScreen();

							UtilsGraphic.clear(_bg).rectFill(0, _text.y - 5, S().gameWidth, _text.height + 10, 0, 0.5);

							RetrocamelEffectFadeFlash.make(_text).alpha(0, 1).duration(500).run();
						}
					}
					break;

				case(1):
					if (_timer == 0 && RetrocamelInputManager.isKeyHit(KeyConst.SPACE)) {
						_timer = 1;
						new RetrocamelEffectFadeFlash(_text).alpha(1, 0).duration(500).callback(case1FadeoutFinished).run();
						function case1FadeoutFinished():void {
							_state = 2;
							_timer = 0;

							_text.text = _text.getWordWrapToWidth(_("outro3"), 230);
							_text.positionToCenterScreen();
							_text.positionToMiddleScreen();

							UtilsGraphic.clear(_bg).rectFill(0, _text.y - 5, S().gameWidth, _text.height + 10, 0, 0.5);

							RetrocamelEffectFadeFlash.make(_text).alpha(0, 1).duration(500).run();
						}
					}
					break;

				case(2):

					if (_timer == 0 && RetrocamelInputManager.isKeyHit(KeyConst.SPACE)) {
						_timer = 1;
						new RetrocamelEffectFadeFlash(_text).alpha(1, 0).duration(500).callback(case2FadeoutFinished).run();
						function case2FadeoutFinished():void {
							_state = 3;
							_timer = 0;

							_text.text = _text.getWordWrapToWidth(_("outro4"), 230);
							_text.positionToCenterScreen();
							_text.positionToMiddleScreen();

							UtilsGraphic.clear(_bg).rectFill(0, _text.y - 5, S().gameWidth, _text.height + 10, 0, 0.5);

							RetrocamelEffectFadeFlash.make(_text).alpha(0, 1).duration(500).run();
						}
					}
					break;

				case(3):
					if (_timer == 0 && RetrocamelInputManager.isKeyHit(KeyConst.SPACE)) {
						_timer = 1;
						startClosing();
					}
					break;
			}
		}

		private function startClosing():void {
			if (_state != 99) {
				RetrocamelEffectFadeScreen.makeOut().duration(2000).callback(endGame).run();
				RetrocamelEffectMusicFade.make(0).duration(1800).run();
				_state = 99;
			}
		}

		private function endGame():void {
			TStateTitle.instance.setToMe();
		}
	}
}