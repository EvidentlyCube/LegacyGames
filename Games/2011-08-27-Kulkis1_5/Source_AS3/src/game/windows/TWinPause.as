package game.windows {
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	import game.global.Level;
	import game.global.Make;
	import game.global.Options;
	import game.states.TStateTitle;

	import net.retrocade.retrocamel.core.RetrocamelSoundManager;
	import net.retrocade.retrocamel.display.flash.RetrocamelBitmapText;
	import net.retrocade.retrocamel.display.flash.RetrocamelButton;
	import net.retrocade.retrocamel.display.flash.RetrocamelWindowFlash;
	import net.retrocade.retrocamel.display.global.RetrocamelTooltip;
	import net.retrocade.retrocamel.effects.RetrocamelEffectFadeFlash;
	import net.retrocade.retrocamel.effects.RetrocamelEffectFadeScreen;
	import net.retrocade.retrocamel.effects.RetrocamelEffectMusicFade;
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.utils.UtilsGraphic;

	public class TWinPause extends RetrocamelWindowFlash {
		private static var _instance:TWinPause = new TWinPause();

		public static function get instance():TWinPause {
			return _instance;
		}


		protected var options:Options;

		protected var restart:RetrocamelButton;
		protected var toMenu:RetrocamelButton;
		protected var closer:RetrocamelButton;
		protected var help:RetrocamelButton;

		public function TWinPause() {
			this._blockUnder = true;
			this._pauseGame = true;

			var txt:RetrocamelBitmapText = Make().text(_("Game is Paused"), 0xFFFFFF, 2);

			options = new Options();
			closer = Make().button(onClose, _('Return to Game'));
			restart = Make().button(onRestart, _('Restart'));
			toMenu = Make().button(onMenu, _('Return to Title Screen'));
			help = Make().button(onHelp, _('Walkthrough'));

			addChild(txt);
			addChild(options);
			addChild(closer);
			addChild(restart);
			addChild(toMenu);
			addChild(help);

			options.y = 25;
			closer.y = options.y + options.height + 5;
			restart.y = closer.y + closer.height + 5;
			toMenu.y = restart.y + restart.height + 5;
			help.y = toMenu.y + toMenu.height + 5;

			graphics.beginFill(0);
			graphics.drawRect(0, 0, 300, options.height + closer.height + 75);

			txt.x = (width - txt.width) / 2 + 5 | 0;
			closer.x = (width - closer.width) / 2 + 5 | 0;
			options.x = (width - options.width) / 2 + 5 | 0;
			restart.x = (width - restart.width) / 2 + 5 | 0;
			toMenu.x = (width - toMenu.width) / 2 + 5 | 0;
			help.x = (width - help.width) / 2 + 5 | 0;

			centerWindow();

			UtilsGraphic.clear(this).beginFill(0, 0.5).drawRect(-x, -y, S().gameWidth, S().gameHeight)
				.beginFill(0).drawRect(0, 0, options.width + 10, help.y + help.height + 10);

			restart.rollOverCallback = RetrocamelTooltip.show;
			restart.rollOutCallback = RetrocamelTooltip.hide;

			toMenu.rollOverCallback = RetrocamelTooltip.show;
			toMenu.rollOutCallback = RetrocamelTooltip.hide;

			help.rollOverCallback = RetrocamelTooltip.show;
			help.rollOutCallback = RetrocamelTooltip.hide;

			RetrocamelTooltip.hookToObject(restart, _('Click loses progress'));
			RetrocamelTooltip.hookToObject(toMenu, _('Click loses progress'));
			RetrocamelTooltip.hookToObject(help, _('helpTooltip'));
		}

		override public function show():void {
			super.show();
			RetrocamelEffectFadeFlash.make(this).alpha(0, 10).duration(250).run();
			mouseEnabled = true;
			mouseChildren = true;
		}


		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: RetrocamelButton Callbacks
		// ::::::::::::::::::::::::::::::::::::::::::::::

		private function onClose():void {
			mouseEnabled = false;
			mouseChildren = false;
			RetrocamelEffectFadeFlash.make(this).alpha(1, 0).duration(250).callback(hide).run();
		}

		private function onRestart():void {
			mouseEnabled = false;
			mouseChildren = false;
			RetrocamelEffectFadeFlash.make(this).alpha(1, 0).duration(250).callback(efFinRestart).run();
		}

		private function onMenu():void {
			RetrocamelEffectFadeFlash.make(this).alpha(1, 0).duration(250).run();
			RetrocamelEffectMusicFade.make(0).duration(200).run();
			RetrocamelEffectFadeScreen.makeOut().duration(1000).callback(efFinReturnToMenu).run();
		}

		private function onHelp():void {
			navigateToURL(new URLRequest("http://retrocade.net/article/9/walkthrough-kulkis-15"), "_blank");
		}


		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Effect Callbacks
		// ::::::::::::::::::::::::::::::::::::::::::::::

		private function efFinReturnToMenu():void {
			hide();
			RetrocamelSoundManager.stopMusic();
			RetrocamelSoundManager.resetMusicFadeVolume();
			TStateTitle.instance.setToMe();
		}

		private function efFinRestart():void {
			hide();

			if (Level.player)
				Level.player.kill();
		}

	}
}