package game.tiles {
	import game.global.Game;
	import game.objects.TGameObject;

	import net.retrocade.retrocamel.core.RetrocamelBitmapManager;

	public class TTileFloor extends TTile {
		public function TTileFloor(x:Number, y:Number, tx:uint, ty:uint) {
			gfx = RetrocamelBitmapManager.getBDExt(Game._general_, tx, ty, 16, 16);

			_x = x;
			_y = y;

			_w = 16;
			_h = 16;

			setLevel();

			drawMe();
		}

		override public function hitRight(o:TGameObject):Boolean {
			return false;
		}

		override public function hitLeft(o:TGameObject):Boolean {
			return false;
		}

		override public function hitTop(o:TGameObject):Boolean {
			return false;
		}

		override public function hitBottom(o:TGameObject):Boolean {
			return false;
		}
	}
}