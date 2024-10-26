package game.objects {
	import flash.display.BitmapData;

	import game.global.Game;
	import game.global.Level;
	import game.global.Score;
	import game.global.Sfx;

	import net.retrocade.collision.RetrocamelSimpleCollider;
	import net.retrocade.helpers.RetrocamelScrollAssist;
	import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
	import net.retrocade.retrocamel.core.RetrocamelSoundManager;
	import net.retrocade.utils.UtilsNumber;

	/**
	 * ...
	 * @author
	 */
	public class THeart extends TGameObject {
		[Embed(source="../../../assets/gfx/by_cage/sprites/spikes.png")]
		public static var _gfx_spikes_:Class;

		public function THeart(x:Number, y:Number) {
			if (Level.heartCollected)
				return;

			_x = x + 3;
			_y = y + 3;

			_width = 10;
			_height = 10;

			_gfx = RetrocamelBitmapManager.getBDExt(Game._general_, 160, 224, 16, 16);

			addDefault();
		}

		override public function update():void {
			Game.lGame.draw(_gfx, x - 3, y - 3);

			if (!player)
				return;

			if (RetrocamelSimpleCollider.rectRect(_x, _y, _width, _height, player.x, player.y, player.width, player.height) && RetrocamelSimpleCollider.bitmap(_gfx, _x - 3, _y - 3, 1, 1, 0, player.gfx, player.x - 2, player.y - 2, 1, 1, 0)) {
				blow(_gfx);
				nullifyDefault();
				Score.lives.add(1);
				Level.heartCollected = true;
				RetrocamelSoundManager.playSound(Sfx.extraLife);
			}
		}

		private function blow(bd:BitmapData):void {

			var scrollX:Number = 0;
			var scrollY:Number = 0;

			for (var i:uint = 0; i < _width; i++) {
				for (var j:uint = 0; j < _height; j++) {
					Game.partPixel.add(_x + i + scrollX, _y + j + scrollY, bd.getPixel32(i + 3, j + 3),
						UtilsNumber.randomWaved(15, 14),
						200 * Math.random() / (i - 6), 200 * Math.random() / (j - 5));
				}
			}
		}
	}
}