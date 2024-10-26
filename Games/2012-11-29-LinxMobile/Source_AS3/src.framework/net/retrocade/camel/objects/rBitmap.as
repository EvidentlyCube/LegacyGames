package net.retrocade.camel.objects
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.retrocamel_int;
    
    use namespace retrocamel_int;
    
    public class rBitmap extends Bitmap{
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Constructor
        // ::::::::::::::::::::::::::::::::::::::::::::::
        
        public function rBitmap(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false){
            super(bitmapData, pixelSnapping, smoothing);
        }
		
		
		
		// INCLUDE
		
		/******************************************************************************************************/
		/**                                                                                        VARIABLES  */
		/******************************************************************************************************/
		
		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Pixel snapping
		// ::::::::::::::::::::::::::::::::::::::::::::::
		
		/**
		 * If true X and Y can never have anything in the fractional part. Do mind that changing this proprety directly 
		 * and not through the setter won't change X and Y values accordingly.
		 */
		protected var _coordsSnapping:Boolean = true;
		
		/**
		 * If true, X and Y can never have anything in the fractional part. Changing it to true from false will round down
		 * X and Y.
		 */
		public function get coordsSnapping():Boolean{
			return _coordsSnapping;
		}
		
		/**
		 * @private 
		 */
		public function set coordsSnapping(value:Boolean):void{
			if (_coordsSnapping != value){
				_coordsSnapping = value;
				if (_coordsSnapping){
					x |= 0;
					y |= 0;
				}
			}
		}
		
		
		
		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: X override
		// ::::::::::::::::::::::::::::::::::::::::::::::
		
		/**
		 * @inherit
		 */
		override public function get x():Number{
			return (_coordsSnapping ? (super.x | 0) : super.x);
		}
		
		/**
		 * @inherit
		 */
		override public function set x(value:Number):void{
			super.x = (_coordsSnapping ? (value | 0) : value)
		}
		
		
		
		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Y override
		// ::::::::::::::::::::::::::::::::::::::::::::::
		
		/**
		 * @inherit
		 */
		override public function get y():Number{
			return (_coordsSnapping ? (super.y | 0) : super.y);
		}
		
		/**
		 * @inherit
		 */
		override public function set y(value:Number):void{
			super.y = (_coordsSnapping ? (value | 0) : value)
		}
		
		
		/******************************************************************************************************/
		/**                                                                                           ALIGNS  */
		/******************************************************************************************************/
		
		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Align Center
		// ::::::::::::::::::::::::::::::::::::::::::::::
		
		/**
		 * Horizontally aligns this component to the center of the screen
		 * @param offset The offset from the center at which this component should be aligned
		 */
		public function alignCenter(offset:Number = 0):void{
			x = ((rCore.settings.gameWidth - width) / 2 | 0) + offset | 0;
		}
		
		/**
		 * Horizontally aligns this component to the center of its parent or specified width
		 * @param offset The offset from the center at which this component should be aligned
		 * @param width The width against which to center this object. If left alone, it centers
		 * against the parent.
		 */
		public function alignCenterParent(offset:Number = 0, width:Number = NaN):void {
			if (isNaN(width)){
				if (!parent)
					return;
				else
					width = parent.width;
			}
			
			x = ((width - this.width) / 2) + offset;
		}
		
		
		
		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Align Middle
		// ::::::::::::::::::::::::::::::::::::::::::::::
		
		/**
		 * Vertically aligns this component to the middle of the screen
		 * @param offset The offset from the middle at which this component should be aligned
		 */
		public function alignMiddle(offset:Number = 0):void{
			y = ((rCore.settings.gameHeight - height) / 2) + offset;
		}
		
		/**
		 * Vertically aligns this component to the middle of its parent or specified height
		 * @param offset The offset from the middle at which this component should be aligned
		 * @param height The width against which to center this object. If left alone, it centers
		 * against the parent.
		 */
		public function alignMiddleParent(offset:Number = 0, height:Number = NaN):void{
			if (isNaN(height)){
				if (!parent)
					return;
				else
					height = parent.height;
			}
			
			y = ((height - this.height) / 2) + offset;
		}
		
		
		
		/******************************************************************************************************/
		/**                                                                        POSTION GETTERS / SETTERS  */
		/******************************************************************************************************/
		
		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Bottom
		// ::::::::::::::::::::::::::::::::::::::::::::::
		
		/**
		 * The bottom edge of the sprite (y + height)
		 */
		public function get bottom():Number{
			return y + height;
		}
		
		/**
		 * @private
		 */
		public function set bottom(newVal:Number):void{
			y = newVal - height;
		}
		
		
		
		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Center
		// ::::::::::::::::::::::::::::::::::::::::::::::
		
		/**
		 * Horizontal center of this sprite
		 */
		public function get center():Number {
			if (_coordsSnapping)
				return x + width / 2 | 0;
			else 
				return x + width / 2;
		}
		
		/**
		 * @private
		 */
		public function set center(value:Number):void {
			x = value - width / 2;
		}
		
		
		
		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Middle
		// ::::::::::::::::::::::::::::::::::::::::::::::
		
		/**
		 * Vertical middle of this sprite
		 */
		public function get middle():Number {
			if (_coordsSnapping)
				return y + height / 2 | 0;
			else
				return y + height / 2;
		}
		
		/**
		 * @private
		 */
		public function set middle(value:Number):void {
			y = value - height / 2;
		}
		
		
		
		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Right
		// ::::::::::::::::::::::::::::::::::::::::::::::
		
		/**
		 * The right edge of the sprite (x + width)
		 */
		public function get right():Number{
			return x + width;
		}
		
		/**
		 * @private
		 */
		public function set right(newVal:Number):void{
			x = newVal - width;
		}
		
		
		
		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Misc Functions
		// ::::::::::::::::::::::::::::::::::::::::::::::
		
		/**
		 * Sets the position and the size of this sprite
		 * @param	x Target x
		 * @param	y Target y
		 * @param	width Target width
		 * @param	height Target height
		 */
		public function setSizePosition(x:Number, y:Number, width:Number, height:Number):void {
			this.x      = x;
			this.y      = y;
			this.width  = width;
			this.height = height;
		}
        
    }
}