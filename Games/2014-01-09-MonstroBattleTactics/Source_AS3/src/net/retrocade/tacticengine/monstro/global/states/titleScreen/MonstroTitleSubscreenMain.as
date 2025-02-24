
package net.retrocade.tacticengine.monstro.global.states.titleScreen {
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroData;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroDisplayGroup;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroPrettyWindowGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroTextButton;

	import net.retrocade.utils.UtilsArray;

	public class MonstroTitleSubscreenMain extends MonstroTitleSubscreenRoot {
		public static const START_GAME:String = "start_game";
		public static const WATCH_INTRO:String = "watch_intro";
		public static const OPTIONS_SOUND:String = "options_sound";
		public static const OPTIONS_GAMEPLAY:String = "options_gameplay";
		public static const OPTIONS_DISPLAY:String = "OPTIONS_DISPLAY";
		public static const ACHIEVEMENTS:String = "ACHIEVEMENTS";
		public static const CREDITS:String = "credits";
		public static const QUIT:String = "quit";

		private var _background:MonstroPrettyWindowGrid9;
		private var _buttonStart:MonstroTextButton;
		private var _buttonWatchIntro:MonstroTextButton;
		private var _buttonOptionsSound:MonstroTextButton;
		private var _buttonOptionsDisplay:MonstroTextButton;
		private var _buttonOptionsGameplay:MonstroTextButton;
		private var _buttonAchievements:MonstroTextButton;
		private var _buttonCredits:MonstroTextButton;
		private var _buttonQuit:MonstroTextButton;

		private var _isInitialAppearance:Boolean;

		public function MonstroTitleSubscreenMain(isInitialApeparance:Boolean = false) {
			super(isInitialApeparance ? 1 : 1.2);

			_isInitialAppearance = isInitialApeparance;

			initCreateObjects();
			initSetProperties();

			var displayGroup:MonstroDisplayGroup = new MonstroDisplayGroup();

			addChild(_background);
			addChildren(buttons);

			displayGroup.addElements(buttons);
			displayGroup.verticalize(MonstroConsts.hudSpacer);

			_background.wrapAround(displayGroup);

			refreshPosition();

			_sliderCounter.onFinishedShowing.add(initialShowFinished);

			touchable = false;
		}

		override public function dispose():void {
			super.dispose();

			_buttonStart.dispose();
			_buttonWatchIntro.dispose();
			_buttonOptionsSound.dispose();
			_buttonOptionsDisplay.dispose();
			_buttonOptionsGameplay.dispose();
			_buttonAchievements.dispose();
			_buttonQuit.dispose();
			_buttonCredits.dispose();

			_buttonWatchIntro = null;
			_buttonOptionsSound = null;
			_buttonOptionsDisplay = null;
			_buttonOptionsGameplay = null;
			_buttonAchievements = null;
			_buttonQuit = null;
			_buttonCredits = null;
		}

		private function initCreateObjects():void {
			_background = new MonstroPrettyWindowGrid9();
			_buttonStart = new MonstroTextButton(_("title_startGame"), onClick, 400);
			_buttonWatchIntro = new MonstroTextButton(_("title_watchIntro"), onClick, 400);
			_buttonOptionsGameplay = new MonstroTextButton(_("title_options_gameplay"), onClick, 400);
			_buttonOptionsDisplay = new MonstroTextButton(_("title_options_display"), onClick, 400);
			_buttonOptionsSound = new MonstroTextButton(_("title_options_audio"), onClick, 400);
			_buttonAchievements = new MonstroTextButton(_("title_achievements"), onClick, 400);
			_buttonCredits = new MonstroTextButton(_("title_credits"), onClick, 400);
			_buttonQuit = new MonstroTextButton(_("title_quit"), onClick, 400);
		}

		private function initialShowFinished():void{
			_isInitialAppearance = false;
			touchable = true;
		}

		private function initSetProperties():void {
			_buttonStart.data.type = START_GAME;
			_buttonWatchIntro.data.type = WATCH_INTRO;
			_buttonOptionsSound.data.type = OPTIONS_SOUND;
			_buttonOptionsGameplay.data.type = OPTIONS_GAMEPLAY;
			_buttonOptionsDisplay.data.type = OPTIONS_DISPLAY;
			_buttonAchievements.data.type = ACHIEVEMENTS;
			_buttonCredits.data.type = CREDITS;
			_buttonQuit.data.type = QUIT;

			_background.header = "Monstro: Battle Tactics";
		}

		override protected function refreshPosition():void {
			var calculatedPosition:Number = _sliderCounter.positionFactor;
			if (_isInitialAppearance){
				center = MonstroConsts.gameWidth / 2 + calculatedPosition * (MonstroConsts.gameWidth / 2 + width);
			} else {
				center = MonstroConsts.gameWidth / 2 - calculatedPosition * (MonstroConsts.gameWidth / 2 + width);
			}

			alignMiddle();
		}

		private function get buttons():Array{
			var buttons: Array = [_buttonStart, _buttonWatchIntro, _buttonOptionsGameplay, _buttonOptionsDisplay, _buttonOptionsSound, _buttonCredits, _buttonQuit];

			if (CF::flash) {
				UtilsArray.pluck(buttons, _buttonQuit);
			}
			if (!MonstroData.getSawIntro(false)) {
				UtilsArray.pluck(buttons, _buttonWatchIntro);
			}
			if (!CF::steam) {
				UtilsArray.pluck(buttons, _buttonAchievements);
			}

			return buttons;
		}
	}
}
