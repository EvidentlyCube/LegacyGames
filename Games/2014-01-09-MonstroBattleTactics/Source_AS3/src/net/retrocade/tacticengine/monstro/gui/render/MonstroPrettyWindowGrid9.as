package net.retrocade.tacticengine.monstro.gui.render
{
	import flash.geom.Rectangle;

	import net.retrocade.tacticengine.monstro.global.core.CoreInit;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;

	import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;

	import starling.display.DisplayObject;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;

	public class MonstroPrettyWindowGrid9 extends Sprite
	{
		public static const LEFT_EDGE:uint = 63 + 16;
		public static const TOP_EDGE:uint = 82 + 16;
		public static const RIGHT_EDGE:uint = 65 + 16;
		public static const BOTTOM_EDGE:uint = 43 + 16;

		private var _frame:MonstroGrid9;
		private var _background:Image;
		private var _header:TextField;

		public function MonstroPrettyWindowGrid9()
		{
			_frame = new MonstroGrid9(CoreInit.guiTexture, new Rectangle(115, 110, 157, 208), MonstroGfx.windowUiFrameTexture.region);
			_background = new Image(MonstroGfx.windowUiBackgroundTexture);
			_header = new TextField(32, 55, "Header!", MonstroConsts.FONT_NEW_ROCKER_48_SHADOW, 44, 0xFFFFFF);
			_header.hAlign = HAlign.CENTER;

			addChild(_background);
			addChild(_frame);
			addChild(_header);

			_background.x = 45;
			_background.y = 45;

			this.width = 100;
			this.height = 100;
		}

		private var _widthCache:Number;
		private var _heightCache:Number;
		override public function set width(value:Number):void
		{
			_frame.width = value;
			_background.width = value - 90;

			_widthCache = _frame.width;

			readjustBackground();
			refreshHeaderTextField();
		}


		override public function set height(value:Number):void
		{
			_frame.height = value;
			_background.height = value - 70;

			_heightCache = _frame.height;

			readjustBackground();
			refreshHeaderTextField();
		}

		override public function get height():Number {
			return _heightCache;
		}

		override public function get width():Number {
			return _widthCache;
		}

		public function set innerWidth(value:Number):void{
			width = value + LEFT_EDGE + RIGHT_EDGE
		}

		public function set innerHeight(value:Number):void{
			height = value + TOP_EDGE + BOTTOM_EDGE
		}

		public function get innerWidth():Number{
			return width - LEFT_EDGE - RIGHT_EDGE;
		}

		public function get innerHeight():Number{
			return height - TOP_EDGE - BOTTOM_EDGE;
		}

		public function wrapAround(displayObject:DisplayObject):void{
			innerWidth = displayObject.width;
			innerHeight = displayObject.height;
			displayObject.x = LEFT_EDGE + x;
			displayObject.y = TOP_EDGE + y;
		}

		public function set header(text:String):void{
			_header.text = text;
			refreshHeaderTextField();
		}

		private function refreshHeaderTextField():void{
			_header.width = _frame.width;
			_header.y = 20;
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

		override public function dispose():void {
			removeChildren();

			_frame.dispose();
			_background.dispose();
			_header.dispose();

			_frame = null;
			_background = null;
			_header = null;

			super.dispose();
		}
	}
}
