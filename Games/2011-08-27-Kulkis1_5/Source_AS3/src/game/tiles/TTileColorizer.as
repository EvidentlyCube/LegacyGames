package game.tiles {
	import game.global.Game;
	import game.global.Sfx;
	import game.objects.TGameObject;
	import game.objects.TPlayer;

	import net.retrocade.retrocamel.core.RetrocamelBitmapManager;

	/**
	 * ...
	 * @author
	 */
	public class TTileColorizer extends TTile {
		[Embed(source="../../../assets/gfx/by_cage/sprites/changer1.png")]
		public static var _gfx_block_1_:Class;
		[Embed(source="../../../assets/gfx/by_cage/sprites/changer2.png")]
		public static var _gfx_block_2_:Class;
		[Embed(source="../../../assets/gfx/by_cage/sprites/changer3.png")]
		public static var _gfx_block_3_:Class;
		[Embed(source="../../../assets/gfx/by_cage/sprites/changer4.png")]
		public static var _gfx_block_4_:Class;

		protected var color:uint;

		public function TTileColorizer(x:Number, y:Number, color:uint) {
			this.color = color;


			if (color < 5)
				gfx = RetrocamelBitmapManager.getBDExt(Game._general_, color * 16 - 16, 240, 16, 16);

			else if (color == 5)
				gfx = RetrocamelBitmapManager.getBDExt(Game._general_, 96, 208, 16, 16);

			else if (color == 6)
				gfx = RetrocamelBitmapManager.getBDExt(Game._general_, 112, 208, 16, 16);

			_x = x;
			_y = y;

			_w = 16;
			_h = 16;

			setLevel();

			Game.gAll.add(this);
			update();
		}

		override public function hitTop(o:TGameObject):Boolean {
			super.hitTop(o);
			if (o is TPlayer && TPlayer(o).colorID != color) {
				Sfx.sfxChangeColor.play();
				TPlayer(o).colorID = color;
			}

			return true;
		}

		override public function hitBottom(o:TGameObject):Boolean {
			super.hitBottom(o);
			if (o is TPlayer && TPlayer(o).colorID != color) {
				Sfx.sfxChangeColor.play();
				TPlayer(o).colorID = color;
			}

			return true;
		}
	}
}