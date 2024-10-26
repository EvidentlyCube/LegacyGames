package game.tiles {
	import flash.display.BitmapData;

	import game.global.Game;
	import game.global.Level;
	import game.objects.TGameObject;

	import net.retrocade.retrocamel.components.RetrocamelUpdatableObject;

	public class TTile extends RetrocamelUpdatableObject {
		protected var _x:Number;
		protected var _y:Number;

		protected var _w:Number;
		protected var _h:Number;

		public var gfx:BitmapData;

		public function TTile() {
		}

		public function hitRight(o:TGameObject):Boolean {
			o.x = _x + _w;
			return true;
		}

		public function hitLeft(o:TGameObject):Boolean {
			o.right = _x - 1;
			return true;
		}

		public function hitTop(o:TGameObject):Boolean {
			o.bottom = _y - 1;
			return true;
		}

		public function hitBottom(o:TGameObject):Boolean {
			o.y = _y + _h;
			return true;
		}

		final protected function setLevel():void {
			Level.level.set(_x, _y, this);
		}

		final protected function unsetLevel():void {
			Level.level.set(_x, _y, null);
		}

		final public function drawMe():void {
			Game.lBG.draw(gfx, _x, _y);
		}

	}
}