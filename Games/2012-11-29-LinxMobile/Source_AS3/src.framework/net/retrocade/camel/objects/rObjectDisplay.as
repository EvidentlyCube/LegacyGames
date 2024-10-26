package net.retrocade.camel.objects{
    import flash.display.DisplayObject;

    public class rObjectDisplay extends rObject{
        
        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/
        
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: X Position
        // ::::::::::::::::::::::::::::::::::::::::::::::
        
        /**
         * X position of the object 
         */
        protected var _x     :Number;
        
        /**
         * X position of the object
         */
        public function get x():Number{
            return _x;
        }
        
        /**
         * @private 
         */
        public function set x(value:Number):void{
            _x = value;
        }
        
        public function get center():Number{
            return _x + _width / 2;
        }
        
        public function set center(value:Number):void{
            _x = value - _width / 2;
        }
        
        public function get right():Number{
            return _x + _width - 1;
        }
        
        public function set right(value:Number):void{
            _x = value - _width + 1;
        }
        
        
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Y Position
        // ::::::::::::::::::::::::::::::::::::::::::::::
        
        /**
         * Y position of the object 
         */
        protected var _y     :Number;
        
        /**
         * Y position of the object
         */
        public function get y():Number{
            return _y;
        }
        
        /**
         * @private 
         */
        public function set y(value:Number):void{
            _y = value;
        }
        
        public function get middle():Number{
            return _y + _height / 2;
        }
        
        public function set middle(value:Number):void{
            _y = value - _height / 2;
        }
        
        public function get bottom():Number{
            return _y + _height - 1;
        }
        
        public function set bottom(value:Number):void {
            _y = value - _height + 1;
        }
        
        
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Dimensions
        // ::::::::::::::::::::::::::::::::::::::::::::::
        
        /**
         * Width of the object, always unsigned integer
         */
        protected var _width :uint;
        
        public function get width():uint {
            return _width;
        }
        
        /**
         * Height of the object, always unsigned integer 
         */
        protected var _height:uint;
        
        public function get height():Number {
            return _height;
        }
        
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Graphic
        // ::::::::::::::::::::::::::::::::::::::::::::::
        
        /**
         * Graphics of the object 
         */
        protected var _gfx:*;
        
        /**
         * Retrieves the DisplayObject representing this object, if any is set 
         */
        public function get gfx():*{
            return _gfx;
        }
        
        
        
        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/
        
        public function rObjectDisplay(){
            super();
        }
        
        public function draw():void{
            
        }
    }
}