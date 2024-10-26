package game.global {
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;

	import game.global.Game;
	import game.global.levels.ILevelList;
	import game.global.levels.LevelListArtGallery;
	import game.global.levels.LevelListRegular;
	import game.objects.TDiamonds;
	import game.objects.TExit;
	import game.objects.THeart;
	import game.objects.THud;
	import game.objects.TKey;
	import game.objects.TPlayer;
	import game.objects.TSpikes;
	import game.objects.TSpikesLoop;
	import game.objects.TSpikesPingPong;
	import game.states.TStateMidtro;
	import game.states.TStateOutro;
	import game.states.TStateTitle;
	import game.tiles.TTileBlock;
	import game.tiles.TTileColorizer;
	import game.tiles.TTileFloor;
	import game.tiles.TTileWall;

	import net.retrocade.data.RetrocamelTileGrid;
	import net.retrocade.helpers.RetrocamelScrollAssist;
	import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
	import net.retrocade.retrocamel.core.RetrocamelSoundManager;
	import net.retrocade.retrocamel.display.flash.RetrocamelBitmapText;
	import net.retrocade.retrocamel.effects.RetrocamelEffectFadeScreen;
	import net.retrocade.retrocamel.effects.RetrocamelEffectMusicFade;
	import net.retrocade.retrocamel.effects.RetrocamelEffectQuake;
	import net.retrocade.retrocamel.global.RetrocamelSimpleSave;
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.vault.Safe;

	/**
	 * ...
	 * @author
	 */
	public class Level {

		[Embed(source='../../../assets/gfx/by_cage/bgs/bg.png')] public static var _bg_:Class;

		public static var blocksCount:Safe = new Safe(0);

		public static var level:RetrocamelTileGrid = new RetrocamelTileGrid(16, 14, S().tileWidth, S().tileHeight);
		public static var player:TPlayer;

		public static var heartCollected:Boolean = false;

		private static var _levelListRegular:ILevelList = new LevelListRegular();
		private static var _levelListArtGallery:ILevelList = new LevelListArtGallery();

		public static function getLevel(id:uint):ByteArray {
			if (Game.isArtGallery) {
				return _levelListArtGallery.getLevel(id);
			} else {
				return _levelListRegular.getLevel(id);
			}
		}

		public static function startGame():void {
			Score.resetGameStart();

			Score.level.set(1);
			Score.lives.set(3);
			Score.score.set(0);
			playLevel(Score.level.get());
			heartCollected = false;
		}

		public static function continueGame():void {
			Score.lives.set(3);
			Score.score.set(0);
			playLevel(Score.level.get());
			heartCollected = false;
		}

		public static function continueAfterMidtro():void {
			playLevel(Score.level.get());
			heartCollected = false;
		}

		public static function restartLevel():void {
			Score.mostLevelsNoDeath.set(0);
			playLevel(Score.level.get());
		}

		public static function levelCompleted():void {
			heartCollected = false;

			Score.mostLevelsNoDeath.add(1);
			Score.mostLevelsNoGameOver.add(1);

			Score.level.add(1);
			if (Score.level.get() == 27) {
				Score.level.set(1);
				TStateOutro.instance.setToMe();

			} else if (Score.level.get() == 7 || Score.level.get() == 13 || Score.level.get() == 19)
				TStateMidtro.instance.setToMe();

			else
				playLevel(Score.level.get());
		}

		private static function playLevel(id:uint):void {
        	TTileBlock.cheatClear = false;
        	TKey.cheatClear = false;
			RetrocamelSimpleSave.writeFlush('lastPlayed', Score.level.get());

			Score.scoreAtLevelStart.set(Score.score.get());

			Level.level.clear();
			Game.gAll.clear();
			Game.partPixel.clear();
			Game.lMain.clear();
			THud.instance.unhook();
			THud.instance.hookTo(Game.lGame);

			player = null;

			blocksCount.set(0);

			Game.lBG.draw(RetrocamelBitmapManager.getBD(_bg_), 0, 0);

			var lvlData:ByteArray = getLevel(id);
			if (lvlData == null)
				return;

			var xml:XML = new XML(lvlData.readUTFBytes(lvlData.length));

			RetrocamelScrollAssist.instance.setCorners(0, 0, parseInt(xml.width.text()), parseInt(xml.height.text()));

			level.init(parseInt(xml.width.text()) / 16, parseInt(xml.height.text()) / 16);

			Score.keys.set(xml.@KeysRequired);

			var item:XML;
			for each(item in xml.level.children()) {
				switch (toID(item.@tx, item.@ty)) {
					case(153): new TTileFloor(item.@x, item.@y, item.@tx, item.@ty); break;
					case(154): new TTileFloor(item.@x, item.@y, item.@tx, item.@ty); break;
					case(155): new TTileFloor(item.@x, item.@y, item.@tx, item.@ty); break;
					case(156): new TTileFloor(item.@x, item.@y, item.@tx, item.@ty); break;
					case(157): new TTileFloor(item.@x, item.@y, item.@tx, item.@ty); break;
					case(158): new TTileFloor(item.@x, item.@y, item.@tx, item.@ty); break;
					case(169): new TTileFloor(item.@x, item.@y, item.@tx, item.@ty); break;
					case(170): new TTileFloor(item.@x, item.@y, item.@tx, item.@ty); break;
					case(171): new TTileFloor(item.@x, item.@y, item.@tx, item.@ty); break;
					case(172): new TTileFloor(item.@x, item.@y, item.@tx, item.@ty); break;
					case(173): new TTileFloor(item.@x, item.@y, item.@tx, item.@ty); break;
					case(174): new TTileFloor(item.@x, item.@y, item.@tx, item.@ty); break;
					case(185): new TTileFloor(item.@x, item.@y, item.@tx, item.@ty); break;
					case(186): new TTileFloor(item.@x, item.@y, item.@tx, item.@ty); break;
					case(187): new TTileFloor(item.@x, item.@y, item.@tx, item.@ty); break;
					case(188): new TTileFloor(item.@x, item.@y, item.@tx, item.@ty); break;
					case(189): new TTileFloor(item.@x, item.@y, item.@tx, item.@ty); break;
					case(190): new TTileFloor(item.@x, item.@y, item.@tx, item.@ty); break;
					case(191): new TTileFloor(item.@x, item.@y, item.@tx, item.@ty); break;


					case(221): new TSpikes(item.@x, item.@y, 0, 0); break;
					case(222): new TSpikes(item.@x, item.@y, 1, 0); break;
					case(223): new TSpikes(item.@x, item.@y, 2, 0); break;

					case(237): new TSpikes(item.@x, item.@y, 0, 1); break;
					case(238): new TSpikes(item.@x, item.@y, 1, 1); break;
					case(239): new TSpikes(item.@x, item.@y, 2, 1); break;

					case(253): new TSpikes(item.@x, item.@y, 0, 2); break;
					case(254): new TSpikes(item.@x, item.@y, 1, 2); break;
					case(255): new TSpikes(item.@x, item.@y, 2, 2); break;


					case(224): new TTileBlock(item.@x, item.@y, 1); break;
					case(225): new TTileBlock(item.@x, item.@y, 2); break;
					case(226): new TTileBlock(item.@x, item.@y, 3); break;
					case(227): new TTileBlock(item.@x, item.@y, 4); break;
					case(208): new TTileBlock(item.@x, item.@y, 5); break;
					case(209): new TTileBlock(item.@x, item.@y, 6); break;

					case(228): new TExit(item.@x, item.@y); break;
					case(229): case(244): case(245): break;

					case(230): new TPlayer(item.@x, item.@y, 1); break;
					case(231): new TPlayer(item.@x, item.@y, 2); break;
					case(232): new TPlayer(item.@x, item.@y, 3); break;
					case(233): new TPlayer(item.@x, item.@y, 4); break;
					case(214): new TPlayer(item.@x, item.@y, 5); break;
					case(215): new TPlayer(item.@x, item.@y, 6); break;

					case(234): new THeart(item.@x, item.@y); break;

					case(240): new TTileColorizer(item.@x, item.@y, 1); break;
					case(241): new TTileColorizer(item.@x, item.@y, 2); break;
					case(242): new TTileColorizer(item.@x, item.@y, 3); break;
					case(243): new TTileColorizer(item.@x, item.@y, 4); break;
					case(210): new TTileColorizer(item.@x, item.@y, 5); break;
					case(211): new TTileColorizer(item.@x, item.@y, 6); break;

					case(246): new TDiamonds(item.@x, item.@y, 1); break;
					case(247): new TDiamonds(item.@x, item.@y, 2); break;
					case(248): new TDiamonds(item.@x, item.@y, 3); break;
					case(249): new TDiamonds(item.@x, item.@y, 4); break;

					case(250): new TKey(item.@x, item.@y); break;

					default: new TTileWall(item.@x, item.@y, item.@tx, item.@ty); break;
				}
			}

			for each(item in xml.actors.children()) {
				if (item.name() == "spikesLoop")
					new TSpikesLoop(item.@x, item.@y, item, item.@speed, item.@turnWait);
				else if (item.name() == "spikesPingPong")
					new TSpikesPingPong(item.@x, item.@y, item, item.@speed, item.@turnWait);
			}


			RetrocamelEffectMusicFade.make(1).duration(500).run();
			RetrocamelSoundManager.playMusic(Game.music);
			RetrocamelEffectFadeScreen.makeIn().duration(250).run();
		}

		private static function toID(tx:uint, ty:uint):uint {
			return (tx / 16) + (ty / 16 | 0) * 16;
		}

		public static function gameOver():void {
			Score.mostLevelsNoGameOver.set(0);

			RetrocamelSoundManager.playSound(Game._sfx_game_over_);

			RetrocamelEffectQuake.make().power(20, 20).duration(500).run();
			var t:RetrocamelBitmapText = Make().text(_("GAME OVER"), 0xFFFFFF, 6);
			t.positionToCenterScreen();
			t.y = (S().gameHeight - t.height) / 2 | 0;
			t.addShadow();

			Game.lMain.add(t);

			setTimeout(onGameOverEnd, 3000);
		}

		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Event Listeners & Callbacks
		// ::::::::::::::::::::::::::::::::::::::::::::::

		private static function onGameOverEnd():void {
			RetrocamelSoundManager.stopMusic();
			RetrocamelEffectFadeScreen.makeOut().duration(2000).callback(onGameOverFadeEnd).run();
		}

		private static function onGameOverFadeEnd():void {
			Game.lMain.clear();
			Game.partPixel.clear();

			TStateTitle.instance.setToMe();
		}
	}
}