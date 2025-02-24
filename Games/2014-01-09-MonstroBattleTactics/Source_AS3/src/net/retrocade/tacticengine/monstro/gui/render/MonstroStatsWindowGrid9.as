package net.retrocade.tacticengine.monstro.gui.render
{
	import flash.geom.Rectangle;

	import net.retrocade.tacticengine.monstro.global.core.CoreInit;

	import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;

	import starling.display.DisplayObject;

	import starling.display.Image;
	import starling.display.Sprite;

	public class MonstroStatsWindowGrid9 extends Sprite
	{
		private var _frame:MonstroGrid9;
		private var _background:Image;

		public function MonstroStatsWindowGrid9()
		{
			_frame = new MonstroGrid9(CoreInit.guiTexture, new Rectangle(34, 32, 76, 132), MonstroGfx.windowUiHudFrameTexture.region);
			_background = new Image(MonstroGfx.windowUiBackgroundTexture);

			addChild(_background);
			addChild(_frame);

			_background.x = 10;
			_background.y = 10;

			this.width = 100;
			this.height = 100;
		}

		public function destroy():void{
			_frame.dispose();
			_background.dispose();
		}

		public function get innerX():Number{
			return x + 20;
		}

		public function get innerY():Number{
			return y + 20;
		}

		public function get innerWidth():Number{
			return width - 40;
		}

		public function get innerHeight():Number{
			return height - 40;
		}

		override public function set width(value:Number):void
		{
			_frame.width = value;
			_background.width = _frame.width - 20;

			readjustBackground();
		}

		public function wrapAround(displayObject:DisplayObject):void{
			width = displayObject.width + 40;
			height = displayObject.height + 40;
			displayObject.x = 20 + x;
			displayObject.y = 20 + y;
		}

		override public function set height(value:Number):void
		{
			_frame.height = value;
			_background.height = _frame.height - 20;

			readjustBackground();
		}

		private function readjustBackground():void{
			var widthRatio:Number = _background.width / _background.texture.width;
			var heightRatio:Number = _background.height / _background.texture.height;

			_background.internalVertexData.setTexCoords(0, 0, 0);
			_background.internalVertexData.setTexCoords(1, widthRatio, 0);
			_background.internalVertexData.setTexCoords(2, 0, heightRatio);
			_background.internalVertexData.setTexCoords(3, widthRatio, heightRatio);

			_background.readjustSize();
		}
	}
}
