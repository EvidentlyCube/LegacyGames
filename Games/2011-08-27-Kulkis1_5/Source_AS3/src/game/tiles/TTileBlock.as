package game.tiles {
	import game.global.Game;
	import game.global.Level;
	import game.global.Score;
	import game.global.Sfx;
	import game.objects.TGameObject;
	import game.objects.TPlayer;

	import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
	import net.retrocade.retrocamel.effects.RetrocamelEffectQuake;
	import net.retrocade.utils.UtilsNumber;

	/**
	 * ...
	 * @author
	 */
	public class TTileBlock extends TTile {
		[Embed(source="../../../assets/gfx/by_cage/sprites/block1.png")] public static var _gfx_block_1_:Class;
		[Embed(source="../../../assets/gfx/by_cage/sprites/block2.png")] public static var _gfx_block_2_:Class;
		[Embed(source="../../../assets/gfx/by_cage/sprites/block3.png")] public static var _gfx_block_3_:Class;
		[Embed(source="../../../assets/gfx/by_cage/sprites/block4.png")] public static var _gfx_block_4_:Class;

		[Embed(source="../../../assets/gfx/by_cage/sprites/block1_01.gif")] public static var _gfx_block_1_1_:Class;
		[Embed(source="../../../assets/gfx/by_cage/sprites/block1_02.gif")] public static var _gfx_block_1_2_:Class;
		[Embed(source="../../../assets/gfx/by_cage/sprites/block1_03.gif")] public static var _gfx_block_1_3_:Class;
		[Embed(source="../../../assets/gfx/by_cage/sprites/block2_01.gif")] public static var _gfx_block_2_1_:Class;
		[Embed(source="../../../assets/gfx/by_cage/sprites/block2_02.gif")] public static var _gfx_block_2_2_:Class;
		[Embed(source="../../../assets/gfx/by_cage/sprites/block2_03.gif")] public static var _gfx_block_2_3_:Class;
		[Embed(source="../../../assets/gfx/by_cage/sprites/block3_01.gif")] public static var _gfx_block_3_1_:Class;
		[Embed(source="../../../assets/gfx/by_cage/sprites/block3_02.gif")] public static var _gfx_block_3_2_:Class;
		[Embed(source="../../../assets/gfx/by_cage/sprites/block3_03.gif")] public static var _gfx_block_3_3_:Class;
		[Embed(source="../../../assets/gfx/by_cage/sprites/block4_01.gif")] public static var _gfx_block_4_1_:Class;
		[Embed(source="../../../assets/gfx/by_cage/sprites/block4_02.gif")] public static var _gfx_block_4_2_:Class;
		[Embed(source="../../../assets/gfx/by_cage/sprites/block4_03.gif")] public static var _gfx_block_4_3_:Class;

    	public static var cheatClear: Boolean = false;


		protected var color:uint;

		protected var animWait:Number = 0;
		protected var animFrame:Number = 0;

		public function TTileBlock(x:Number, y:Number, color:uint) {
			this.color = color;

			getGfx(0);

			_x = x;
			_y = y;

			_w = 16;
			_h = 16;

			setLevel();

			setLevel();
			Game.gAll.add(this);

			Level.blocksCount.add(1);

			animWait = 30 + Math.random() * 570 | 0;

			update();
		}


		private function getGfx(frame:uint):void{
			if (color < 5)
				gfx = RetrocamelBitmapManager.getBDExt(Game._general_, color * 16 - 16, 176 + frame * 16, 16, 16);

			else if (color == 5)
				gfx = RetrocamelBitmapManager.getBDExt(Game._general_, 64, 160 + frame * 16, 16, 16);

			else if (color == 6)
				gfx = RetrocamelBitmapManager.getBDExt(Game._general_, 80, 160 + frame * 16, 16, 16);
		}

		override public function update():void {
			if (animWait-- == 0) {
				animWait = 30 + Math.random() * 570 | 0;
				if (animFrame == 0) {
					animFrame = 1;
				}
			}

			if (animFrame > 0) {
				animFrame += 0.15;
				if (animFrame < 4)
					getGfx(animFrame | 0);
				else {
					getGfx(0);
					animFrame = 0;
				}
			}

			if (cheatClear) {
				destroy(Math.random() < 0.5 ? 1 : -1);
			}
		}

		override public function hitTop(o:TGameObject):Boolean {
			super.hitTop(o);
			if (o is TPlayer && TPlayer(o).colorID == color)
				destroy();

			return true;
		}

		override public function hitBottom(o:TGameObject):Boolean {
			super.hitBottom(o);
			if (o is TPlayer && TPlayer(o).colorID == color)
				destroy(-1);

			return true;
		}

		private function destroy(dir:Number = 1):void {
			Game.gAll.nullify(this);
			unsetLevel();
			Sfx.sfxBlockBoom.play();

			Score.blockDestroyed();

			Level.blocksCount.add(-1);

			RetrocamelEffectQuake.make().power(5, 5).duration(100).run();

			var scrollX:Number = 0;
			var scrollY:Number = 0;

			for (var i:uint = 0; i < _w; i++) {
				for (var j:uint = 0; j < _h; j++) {
					Game.partPixel.add(_x + i + scrollX, _y + j + scrollY, gfx.getPixel32(i, j),
						Math.min(UtilsNumber.randomWaved(15, 14), UtilsNumber.randomWaved(15, 14), UtilsNumber.randomWaved(15, 14)),
						UtilsNumber.randomWaved(0, 150), UtilsNumber.randomWaved(100, 100) * dir);
				}
			}
		}
	}

}