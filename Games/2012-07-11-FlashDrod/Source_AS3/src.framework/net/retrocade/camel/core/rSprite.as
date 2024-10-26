package net.retrocade.camel.core{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

    use namespace retrocamel_int;
	
	public class rSprite extends Sprite {

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
            x = ((rCore._settings.SIZE_GAME_WIDTH - width) / 2 | 0) + offset;
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

            x = ((width - this.width) / 2 | 0) + offset;
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Align Middle
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Vertically aligns this component to the middle of the screen
         * @param offset The offset from the middle at which this component should be aligned
         */
        public function alignMiddle(offset:Number = 0):void{
            y = ((rCore._settings.SIZE_GAME_HEIGHT - height) / 2 | 0) + offset;
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
                    height = parent.width;
            }

            y = ((height - this.height) / 2 | 0) + offset;
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
        // :: Constructor
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public function rSprite() {
           tabChildren = tabEnabled = false;
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