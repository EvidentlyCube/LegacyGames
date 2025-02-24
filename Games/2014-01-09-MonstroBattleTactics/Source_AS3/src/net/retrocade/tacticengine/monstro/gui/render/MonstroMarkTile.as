package net.retrocade.tacticengine.monstro.gui.render
{
	import net.retrocade.retrocamel.core.RetrocamelCore;
	import net.retrocade.retrocamel.interfaces.IRetrocamelUpdatable;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class MonstroMarkTile extends Image implements IRetrocamelUpdatable
	{
		private static var _textureCache:Array = [];

		public static function resetCache():void{
			_textureCache = [];

			for (var i:int = 1; i < 9; i++){
				_textureCache[i] = [];
				for (var j:int = 0; j < 8; j++){
					_textureCache[i][j] = MonstroGfx.getTileTexture((j) * MonstroConsts.tileWidth, (20 + i) * MonstroConsts.tileHeight);
				}
			}
		}

		private var _framesCache:Array;
		private var _type:uint;
		private var _frame:Number = 0;

		public function MonstroMarkTile()
		{
			super(MonstroGfx.getTileTexture(29 * MonstroConsts.tileWidth, 10 * MonstroConsts.tileHeight));

			RetrocamelCore.groupAfter.add(this);

			_type = MonstroConsts.MARK_TYPE_RESET;

			visible = false;
		}


		public function update():void
		{
			_frame += 1;
			if (_frame >= 40){
				_frame = 0;
			}

			if (_type === MonstroConsts.MARK_TYPE_RESET || _frame % 5 === 0){
				return;
			}

			texture = _framesCache[_frame / 5 | 0];
		}

		public function set markType(value:uint):void{
			_type = value;
			_framesCache = _textureCache[_type];

			visible = _type !== MonstroConsts.MARK_TYPE_RESET;

			if (_type > 0){
				texture = _framesCache[_frame / 5 | 0];
			}
		}
	}
}
