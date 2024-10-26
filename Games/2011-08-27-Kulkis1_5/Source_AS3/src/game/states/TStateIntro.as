package game.states {
	import flash.media.Sound;

	import game.global.Game;
	import game.global.Level;

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
	public class TStateIntro extends RetrocamelStateBase {
		[Embed(source="../../../assets/music/intro/intro.mp3")]
		public static var _music_:Class;

		public static var music:Sound;

		private static var _instance:TStateIntro = new TStateIntro();
		public static function get instance():TStateIntro {
			return _instance;
		}


		private var _timer:Number = 0;
		private var _state:Number = 0;

		private var _text1:RetrocamelBitmapText;
		private var _text2:RetrocamelBitmapText;

		private var _ct:RetrocamelBitmapText;
		private var _ctTimer:uint = 0;

		public function TStateIntro() {
			music = new _music_;
		}

		override public function create():void {

			_text1 = new RetrocamelBitmapText();
			_text2 = new RetrocamelBitmapText();

			_text1.align = RetrocamelBitmapText.ALIGN_MIDDLE;
			_text2.align = RetrocamelBitmapText.ALIGN_MIDDLE;

			_text1.text = _text1.getWordWrapToWidth(_("intro1"), 230);
			_text2.text = _text2.getWordWrapToWidth(_("intro2"), 230);
			_text1.setScale(2);
			_text2.setScale(2);

			_text1.positionToCenterScreen();
			_text1.positionToMiddleScreen();
			_text2.positionToCenterScreen();
			_text2.positionToMiddleScreen();

			_text1.addShadow();
			_text2.addShadow();

			_ct = new RetrocamelBitmapText(_("Hit Space to Continue"));
			_ct.setScale(2);
			_ct.addShadow();
			_ct.positionToCenterScreen();
			_ct.y = S().gameHeight - _ct.height - 5;

			_timer = 0;
			_state = 0;

			RetrocamelEffectFadeScreen.makeIn().duration(400).run();
			RetrocamelEffectFadeFlash.make(_text1).alpha(0, 1).duration(500).run();

			Game.lMain.add(_text1);
			Game.lMain.add(_text2);
			Game.lMain.add(_ct);

			_text1.alpha = 0;
			_text2.alpha = 0;

			RetrocamelSoundManager.playMusic(music);
			RetrocamelEffectMusicFade.make(1).duration(500).run();
		}

		override public function destroy():void {
			Game.lMain.clear();
			RetrocamelSoundManager.stopMusic();
		}

		override public function update():void {
			if (RetrocamelInputManager.isAnyKeyHit() && _state != 99 && !RetrocamelInputManager.isKeyHit(KeyConst.SPACE)) {
				RetrocamelEffectFadeScreen.makeOut().duration(1000).callback(startGame).run();
				RetrocamelEffectMusicFade.make(0).duration(800).run();
				_state = 99;
			}

			_ctTimer++;

			_ct.visible = _ctTimer % 100 < 50;

			switch (_state) {
				case(0):
					if (_timer == 0 && RetrocamelInputManager.isKeyHit(KeyConst.SPACE)) {

						_timer = 1;

						RetrocamelEffectFadeFlash.make(_text1).alpha(1, 0).duration(500).callback(case0FadeFinished).run();
						function case0FadeFinished():void {
							_state = 2;
							_timer = 0;
							_ctTimer = 0;

							RetrocamelEffectFadeFlash.make(_text2).alpha(0, 1).duration(500).run();
						}
					}
					break;

				case(2):
					if (_timer == 0 && RetrocamelInputManager.isKeyHit(KeyConst.SPACE)) {
						RetrocamelEffectFadeScreen.makeOut().duration(1000).callback(startGame).run();
						RetrocamelEffectMusicFade.make(0).duration(800).run();
						_timer = 1;
					}
					break;
			}

		}

		private function startGame():void {
			RetrocamelCore.setState(TStateGame.instance);
			Level.startGame();
		}
	}
}