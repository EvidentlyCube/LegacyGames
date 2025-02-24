package starling.extensions.lighting.core
{
	import starling.utils.Color;
	/**
	 * @author Szenia
	 */
	public class LightBase
	{
		protected var _brightness:Number;

		protected var _offsetX:Number;
		protected var _offsetY:Number;
		private var _scale:Number;

		protected var _r:Number;
		protected var _g:Number;
		protected var _b:Number;
		
		/**
		 * abstract baseclass for all lights
		 * 
		 * do not instanciate directly, use subclasses instead
		 */
		public function LightBase(color:uint, brightness:Number = 1)
		{
			_brightness = brightness;
			
			setColor(color);
		}
		
		final public function setColor(color:uint):void
		{
			_r = Color.getRed(color) / 255;
			_g = Color.getGreen(color) / 255;
			_b = Color.getBlue(color) / 255;
		}
		
		final public function get red():Number
		{
			return _r * _brightness;
		}

		final public function get green():Number
		{
			return _g * _brightness;
		}

		final public function get blue():Number
		{
			return _b * _brightness;
		}

		final public function get brightness():Number
		{
			return _brightness;
		}

		final public function set brightness(brightness:Number):void
		{
			_brightness = brightness;
		}

		public function get offsetX():Number
		{
			return _offsetX;
		}

		public function set offsetX(value:Number):void
		{
			_offsetX = value;
		}

		public function get offsetY():Number
		{
			return _offsetY;
		}

		public function set offsetY(value:Number):void
		{
			_offsetY = value;
		}

		public function get scale():Number
		{
			return _scale;
		}

		public function set scale(value:Number):void
		{
			_scale = value;
		}
	}
}
