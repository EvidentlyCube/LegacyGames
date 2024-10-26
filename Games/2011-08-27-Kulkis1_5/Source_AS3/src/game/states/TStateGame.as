package game.states {
	import flash.display.BitmapData;

	import game.global.Game;
	import game.global.Level;
	import game.objects.THud;
	import game.objects.TPlayer;
	import game.tiles.TTile;
	import game.windows.TWinPause;

	import net.retrocade.constants.KeyConst;

	import net.retrocade.helpers.RetrocamelScrollAssist;

	import net.retrocade.retrocamel.components.RetrocamelStateBase;
	import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
	import net.retrocade.retrocamel.core.RetrocamelInputManager;

	public class TStateGame extends RetrocamelStateBase {
		private static var _instance:TStateGame = new TStateGame();
		public static function get instance():TStateGame {
			return _instance;
		}

		override public function create():void {
			_defaultGroup = Game.gAll;
		}

		override public function destroy():void {
			TPlayer.lastPlayer = null;
			_defaultGroup.clear();
			THud.instance.unhook();
			Game.lGame.clear();
			Game.lBG.clear();
			Game.lMain.clear();

			RetrocamelScrollAssist.instance.setScroll(0, 0);
		}

		override public function update():void {
			if (RetrocamelInputManager.isKeyHit(KeyConst.ESCAPE) && Level.player) {
				TWinPause.instance.show();
				return;
			}

			if (Level.player && Game.gAll.contains(Level.player)) {
				Game.gAll.moveToTop(Level.player);
			}

			Game.lGame.clear();
			Game.lBG.clear();
			Game.gAll.update();

			if (Level.player) {
				Level.player.draw();
			}

			var scrX:int = RetrocamelScrollAssist.x % 256;
			var scrY:int = RetrocamelScrollAssist.y % 224;

			var bd:BitmapData = RetrocamelBitmapManager.getBD(Level._bg_);
			if (scrX != 0 || scrY != 0) {
				Game.lBG.drawImageRect(bd, RetrocamelScrollAssist.x, RetrocamelScrollAssist.y, scrX, scrY, 256 - scrX, 224 - scrY);
				Game.lBG.drawImageRect(bd, RetrocamelScrollAssist.x + 256 - scrX, RetrocamelScrollAssist.y, 0, scrY, scrX, 224 - scrY);
				Game.lBG.drawImageRect(bd, RetrocamelScrollAssist.x, RetrocamelScrollAssist.y + 224 - scrY, scrX, 0, 256 - scrX, scrY);
				Game.lBG.drawImageRect(bd, RetrocamelScrollAssist.x + 256 - scrX, RetrocamelScrollAssist.y + 224 - scrY, 0, 0, scrX, scrY);


			} else {
				Game.lBG.draw(RetrocamelBitmapManager.getBD(Level._bg_), RetrocamelScrollAssist.x, RetrocamelScrollAssist.y);
			}


			var i:int;
			var j:int;

			var l:int;
			var k:int;

			var tile:TTile;

			i = Math.floor(RetrocamelScrollAssist.x / 16) - 1;
			j = Math.floor(RetrocamelScrollAssist.y / 16) - 1;

			l = i + 18;
			k = j + 16;

			for (j = k - 16; j < k; j++) {
				for (i = l - 18; i < l; i++) {
					if ((tile = Level.level.get(i * 16, j * 16))) {
						tile.drawMe();
					}
				}
			}
		}
	}
}