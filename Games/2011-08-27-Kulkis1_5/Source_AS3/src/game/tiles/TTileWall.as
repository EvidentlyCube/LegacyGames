package game.tiles {
	import game.global.Game;

	import net.retrocade.retrocamel.core.RetrocamelBitmapManager;

	/**
	 * ...
	 * @author
	 */
	public class TTileWall extends TTile {
		public function TTileWall(x:Number, y:Number, tx:uint, ty:uint) {
			gfx = RetrocamelBitmapManager.getBDExt(Game._general_, tx, ty, 16, 16);

			_x = x;
			_y = y;

			_w = 16;
			_h = 16;

			setLevel();

			drawMe();
		}

	}

}