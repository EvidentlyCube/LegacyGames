package game.global {
	import flash.events.KeyboardEvent;
	import flash.media.Sound;

	import game.states.TStateTitle;
	import game.windows.TWinFocusPause;

	import net.retrocade.collision.RetrocamelSimpleCollider;

	import net.retrocade.constants.KeyConst;

	import net.retrocade.retrocamel.components.RetrocamelUpdatableGroup;
	import net.retrocade.retrocamel.core.RetrocamelInputManager;
	import net.retrocade.retrocamel.core.RetrocamelSoundManager;

	import net.retrocade.retrocamel.display.layers.RetrocamelLayerFlashBlit;

	import net.retrocade.retrocamel.display.layers.RetrocamelLayerFlashSprite;
	import net.retrocade.retrocamel.global.RetrocamelSimpleSave;
	import net.retrocade.retrocamel.particles.RetrocamelParticlesPixel;

	public class Game {
		[Embed(source='../../../assets/music/synthmania6/synthmania6_by_xceed.mp3')] private static var _music1_:Class;
		[Embed(source='../../../assets/music/sdv6/sdv6_by_grogon.mp3')] private static var _music2_:Class;
		[Embed(source='../../../assets/music/sequenceline/sequenceline_by_emax.mp3')] private static var _music3_:Class;

		[Embed(source='../../../assets/sfx/gameOver.mp3')]public static var _sfx_game_over_:Class;
		[Embed(source="../../../assets/gfx/by_cage/general.png")] public static var _general_:Class;


		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Game Variables
		// ::::::::::::::::::::::::::::::::::::::::::::::

		public static var lMain:RetrocamelLayerFlashSprite;
		public static var lBG:RetrocamelLayerFlashBlit;
		public static var lGame:RetrocamelLayerFlashBlit;
		public static var lPart:RetrocamelLayerFlashBlit;

		public static var gAll:RetrocamelUpdatableGroup = new RetrocamelUpdatableGroup();

		public static var partPixel:RetrocamelParticlesPixel;

		public static var isArtGallery: Boolean = false;

		private static var musics:Array;

		public static function get music():Sound {
			if (!musics) {
				musics = [];
				musics[0] = new _music1_;
				musics[1] = new _music2_;
				musics[2] = new _music3_;
			}

			return musics[musics.length * Math.random() | 0];
		}


		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Keys
		// ::::::::::::::::::::::::::::::::::::::::::::::

		public static var keyLeft:uint;
		public static var keyRight:uint;
		public static var keyAccelerate:uint;
		public static var keyDecelerate:uint;
		public static var keySound:uint;
		public static var keyMusic:uint;

		public static var allKeys:Array = ['keyLeft', 'keyRight', 'keySound', 'keyAccelerate', 'keyDecelerate', 'keyMusic'];


		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Init
		// ::::::::::::::::::::::::::::::::::::::::::::::

		public static function init():void {
			keyLeft = RetrocamelSimpleSave.read('optkeyLeft', KeyConst.LEFT);
			keyRight = RetrocamelSimpleSave.read('optkeyRight', KeyConst.RIGHT);
			keyAccelerate = RetrocamelSimpleSave.read('optkeyAccelerate', KeyConst.UP);
			keyDecelerate = RetrocamelSimpleSave.read('optkeyDecelerate', KeyConst.DOWN);
			keySound = RetrocamelSimpleSave.read('optkeySound', KeyConst.S);
			keyMusic = RetrocamelSimpleSave.read('optkeyMusic', KeyConst.M);
			isArtGallery = RetrocamelSimpleSave.read('isArtGallery', "0") === "1";

			Game.lBG = new RetrocamelLayerFlashBlit();
			Game.lGame = new RetrocamelLayerFlashBlit();
			Game.lPart = new RetrocamelLayerFlashBlit();
			Game.lMain = new RetrocamelLayerFlashSprite();

			Game.lGame.setScale(2, 2);
			Game.lBG.setScale(2, 2);
			Game.lPart.setScale(2, 2);

			Game.partPixel = new RetrocamelParticlesPixel(Game.lPart, 1000);
			TStateTitle.instance.setToMe();
			//TStateGame.instance.set();

			TWinFocusPause.hook();

			RetrocamelInputManager.addStageKeyDown(onKeyDown);

			RetrocamelSimpleCollider.initBitmapCollision(32, 32);
		}

		private static var oldSoundVolume:Number = 1;
		private static var oldMusicVolume:Number = 1;
		public static var disableQuickSFXToggle:Boolean = false;

		private static function onKeyDown(e:KeyboardEvent):void {
			if (disableQuickSFXToggle)
				return;

			if (e.keyCode == Game.keySound) {
				if (RetrocamelSoundManager.soundVolume == 0)
					RetrocamelSoundManager.soundVolume = oldSoundVolume;
				else {
					oldSoundVolume = RetrocamelSoundManager.soundVolume;
					RetrocamelSoundManager.soundVolume = 0;
				}

				RetrocamelSimpleSave.write('optVolumeSound', RetrocamelSoundManager.soundVolume);
				RetrocamelSimpleSave.flush();
			} else if (e.keyCode == Game.keyMusic) {
				if (RetrocamelSoundManager.musicVolume == 0)
					RetrocamelSoundManager.musicVolume = oldMusicVolume;
				else {
					oldMusicVolume = RetrocamelSoundManager.musicVolume;
					RetrocamelSoundManager.musicVolume = 0;
				}

				RetrocamelSimpleSave.write('optVolumeMusic', RetrocamelSoundManager.musicVolume);
				RetrocamelSimpleSave.flush();
			}
		}
	}
}