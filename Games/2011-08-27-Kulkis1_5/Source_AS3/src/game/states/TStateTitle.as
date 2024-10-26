package game.states {
	import flash.display.Bitmap;

	import game.display.rAnimGravitated;

	import game.display.rAnimSprite;

	import game.global.Game;
	import game.global.Level;
	import game.global.Make;
	import game.global.Score;
	import game.global.Sfx;
	import game.objects.TRibbon;
	import game.tiles.TTileBlock;
	import game.windows.TWinCredits;
	import game.windows.TWinOptions;

	import net.retrocade.retrocamel.components.RetrocamelStateBase;
	import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
	import net.retrocade.retrocamel.core.RetrocamelSoundManager;
	import net.retrocade.retrocamel.display.flash.RetrocamelBitmapText;
	import net.retrocade.retrocamel.display.flash.RetrocamelButton;
	import net.retrocade.retrocamel.display.flash.RetrocamelWindowFlash;
	import net.retrocade.retrocamel.display.global.RetrocamelTooltip;
	import net.retrocade.retrocamel.effects.RetrocamelEffectFadeScreen;
	import net.retrocade.retrocamel.effects.RetrocamelEffectMusicFade;
	import net.retrocade.retrocamel.effects.RetrocamelEffectQuake;
	import net.retrocade.retrocamel.global.RetrocamelSimpleSave;
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.utils.UtilsString;

	public class TStateTitle extends RetrocamelStateBase {

		[Embed(source="../../../assets/gfx/by_cage/bgs/title15_ani_00.png")] private var __logo_0__:Class;
		[Embed(source="../../../assets/gfx/by_cage/bgs/title15_ani_01.png")] private var __logo_1__:Class;
		[Embed(source="../../../assets/gfx/by_cage/bgs/title15_ani_02.png")] private var __logo_2__:Class;
		[Embed(source="../../../assets/gfx/by_cage/bgs/title15_ani_03.png")] private var __logo_3__:Class;
		[Embed(source="../../../assets/gfx/by_cage/bgs/title15_ani_04.png")] private var __logo_4__:Class;
		[Embed(source="../../../assets/gfx/by_cage/bgs/title15_ani_05.png")] private var __logo_5__:Class;
		[Embed(source="../../../assets/gfx/by_cage/bgs/title15_ani_06.png")] private var __logo_6__:Class;
		[Embed(source="../../../assets/gfx/by_cage/bgs/title15_ani_07.png")] private var __logo_7__:Class;
		[Embed(source="../../../assets/gfx/by_cage/bgs/title15_ani_08.png")] private var __logo_8__:Class;

		private static var _instance:TStateTitle;
		public static function get instance():TStateTitle {
			if (!_instance) {
				_instance = new TStateTitle();
			}
			return _instance;
		}


		private var _logo:Bitmap;
		private var _start:RetrocamelButton;
		private var _gameMode:RetrocamelButton;
		private var _continue:RetrocamelButton;
		private var _nextLevel:RetrocamelButton;
		private var _options:RetrocamelButton;
		private var _credits:RetrocamelButton;

		private var _ribbon1:TRibbon;

		private var _state:uint = 0;

		public function TStateTitle() {
			rAnimGravitated.blitLayer = Game.lGame;

			_logo = new TStatePreload['__logo_r__'];

			_logo.scaleX = 2;
			_logo.scaleY = 2;

			_logo.x = (S().gameWidth - _logo.width) / 2 | 0;
			_logo.y = 10;

			_start = Make().button(onStart, _("StartScratch"));
			_gameMode = Make().button(onGameMode, Game.isArtGallery ? _('levels_art_gallery') : _('levels_regular'), 260);
			_continue = Make().button(onContinue, _("Continue"), 240);
			_nextLevel = Make().button(onNextLevel, ">>");
			_options = Make().button(onOptions, _("Options"));
			_credits = Make().button(onCredits, _("Credits"));

			_gameMode.data.txt.positionToCenter();

			_start.x = 26;
			_gameMode.x = S().gameWidth - _gameMode.width - 6;
			_continue.x = 26;
			_nextLevel.x = _continue.x + _continue.width + 6;
			_credits.x = Math.max(0, (S().gameWidth / 3 - _credits.width) / 2 | 0);
			_options.x = (S().gameWidth * 5 / 3 - _credits.width) / 2 | 0;

			const OFFSET:Number = 46;

			_start.y = 268;
			_gameMode.y = 268;
			_nextLevel.y = _start.y + OFFSET;
			_continue.y = _start.y + OFFSET;
			_credits.y = _start.y + OFFSET * 2;
			_options.y = _start.y + OFFSET * 2;

			Score.level.set(RetrocamelSimpleSave.read("lastPlayed", 1));
		}

		override public function update():void {
			if (_state == 0) {
				var s:rAnimSprite = new rAnimSprite(_logo.x / 2, _logo.y / 2, 4, Game.lBG);
				s.addFrame(RetrocamelBitmapManager.getBD(__logo_0__));
				s.addFrame(RetrocamelBitmapManager.getBD(__logo_1__));
				s.addFrame(RetrocamelBitmapManager.getBD(__logo_2__));
				s.addFrame(RetrocamelBitmapManager.getBD(__logo_3__));
				s.addFrame(RetrocamelBitmapManager.getBD(__logo_4__));
				s.addFrame(RetrocamelBitmapManager.getBD(__logo_5__));
				s.addFrame(RetrocamelBitmapManager.getBD(__logo_6__));
				s.addFrame(RetrocamelBitmapManager.getBD(__logo_7__));
				s.addFrame(RetrocamelBitmapManager.getBD(__logo_8__));
				s.onFinishCallback = function ():void {
					_state = 2
				};

				Game.lMain.mouseChildren = false;

				_state = 1;

			} else if (_state == 1) {
				Game.lBG.clear();

			} else if (_state == 2) {
				RetrocamelEffectFadeScreen.makeIn().color(0xFFFFFF).duration(800).run();
				RetrocamelEffectQuake.make().power(20, 20).duration(800).run();
				Game.lGame.layer.alpha = 1;

				_logo.alpha = 1;
				_start.alpha = 1;
				_gameMode.alpha = 1;
				_continue.alpha = 1;
				_credits.alpha = 1;
				_options.alpha = 1;
				_nextLevel.alpha = 1;

				_state = 3;

				RetrocamelSoundManager.playMusic(Game.music);

				Sfx.sfxBlockBoom.play();
				Game.lBG.draw(RetrocamelBitmapManager.getBD(Level._bg_), 0, 0);

				Game.lMain.mouseChildren = true;
			}

			Game.lGame.clear();
			super.update();
		}

		override public function create():void {
			Game.lBG.clear();
			Game.lMain.clear();
			Game.lGame.clear();

			Game.lMain.add(_logo);
			Game.lMain.add(_start);
			Game.lMain.add(_gameMode);
			Game.lMain.add(_continue);
			Game.lMain.add(_nextLevel);
			Game.lMain.add(_credits);
			Game.lMain.add(_options);

			var r:TRibbon = new TRibbon( 105, -2, Game.lGame);
			r.addItem(RetrocamelBitmapManager.getBD(TTileBlock._gfx_block_1_), 1);
			r.addItem(RetrocamelBitmapManager.getBD(TTileBlock._gfx_block_2_), 1);
			r.addItem(RetrocamelBitmapManager.getBD(TTileBlock._gfx_block_3_), 1);
			r.addItem(RetrocamelBitmapManager.getBD(TTileBlock._gfx_block_4_), 1);
			/*r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_1_), 0.05);
			 r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_3_), 0.05);
			 r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_4_), 0.05);
			 r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_7_), 0.05);
			 r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_8_), 0.05);
			 r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_9_), 0.05);
			 r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_15_), 0.05);
			 r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_16_), 0.05);
			 r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_17_), 0.05);*/

			r.farthestEdge = S().levelWidth;
			r.addMany(20);
			r.moveAll(-S().levelWidth);

			r.swayPower = 10;
			r.swayOffset = -Math.PI / 75;
			r.swaySpeed = Math.PI / 60;

			_ribbon1 = r;

			Game.lGame.layer.alpha = 0;

			_logo.alpha = 0;
			_start.alpha = 0;
			_gameMode.alpha = 0;
			_continue.alpha = 0;
			_nextLevel.alpha = 0;
			_credits.alpha = 0;
			_options.alpha = 0;

			_state = 0;

			setContinueLevel();
		}

		override public function destroy():void {
			RetrocamelTooltip.unhook(_start);
			RetrocamelTooltip.unhook(_continue);

			Game.lMain.clear();
			Game.lGame.clear();
			_defaultGroup.clear();
		}


		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: On Start
		// ::::::::::::::::::::::::::::::::::::::::::::::

		private function onStart():void {
			RetrocamelEffectMusicFade.make(0).duration(500).run();
			RetrocamelEffectFadeScreen.makeOut().duration(500).callback(onStartFadeFinish).run();
			Sfx.sfxClick.play();
		}

		private function onStartFadeFinish():void {
			RetrocamelSoundManager.stopMusic();
			TStateIntro.instance.setToMe();
		}

		private function onGameMode(): void {
			Game.isArtGallery = Game.isArtGallery ? false : true;

			_gameMode.data.txt.text = Game.isArtGallery ? _('levels_art_gallery') : _('levels_regular');
			_gameMode.data.txt.positionToCenter();

			RetrocamelSimpleSave.writeFlush('isArtGallery', Game.isArtGallery ? "1" : "0");
		}

		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: On Continue
		// ::::::::::::::::::::::::::::::::::::::::::::::

		private function onContinue():void {
			RetrocamelEffectMusicFade.make(0).duration(500).run();
			RetrocamelEffectFadeScreen.makeOut().duration(500).callback(onContinueFadeFinish).run();
			Sfx.sfxClick.play();
		}

		private function onContinueFadeFinish():void {
			TStateGame.instance.setToMe();
			Level.continueGame();
		}

		private function onNextLevel():void {
			if (Score.level.get() == 26)
				Score.level.set(1);
			else
				Score.level.add(1);

			setContinueLevel();

			Sfx.sfxClick.play();
		}

		private function setContinueLevel():void {
			RetrocamelBitmapText(_continue.data.txt).text = _("Continue") + " " + UtilsString.padLeft(Score.level.get().toString(), 2);
			RetrocamelBitmapText(_continue.data.txt).positionToCenter();
		}


		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: On Options
		// ::::::::::::::::::::::::::::::::::::::::::::::

		private function onOptions():void {
			var win:RetrocamelWindowFlash = new TWinOptions();
			win.show();

			Sfx.sfxClick.play();
		}


		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: On Credits
		// ::::::::::::::::::::::::::::::::::::::::::::::

		private function onCredits():void {
			TWinCredits.instance.show();
			Sfx.sfxClick.play();
		}
	}
}