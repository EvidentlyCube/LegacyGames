package game.objects {
	import game.global.Game;

	import net.retrocade.collision.RetrocamelSimpleCollider;
	import net.retrocade.retrocamel.core.RetrocamelBitmapManager;

	/**
	 * ...
	 * @author
	 */
	public class TSpikes extends TGameObject {
		[Embed(source="../../../assets/gfx/by_cage/sprites/spikes.png")]
		public static var _gfx_spikes_:Class;

		public function TSpikes(x:Number, y:Number, tx:uint, ty:uint) {
			_x = x;
			_y = y;

			_width = 16;
			_height = 16;

			_gfx = RetrocamelBitmapManager.getBDExt(Game._general_, 208 + tx * 16, 208 + ty * 16, 16, 16);

			addDefault();

			update();
		}

		override public function update():void {
			Game.lGame.draw(_gfx, x, y);

			if (!player)
				return;

			if (RetrocamelSimpleCollider.rectRect(_x, _y, _width, _height, player.x, player.y, player.width, player.height) && RetrocamelSimpleCollider.bitmap(_gfx, _x, _y, 1, 1, 0, player.gfx, player.x - 2, player.y - 2, 1, 1, 0)) {
				player.kill();
			}
		}
	}
}