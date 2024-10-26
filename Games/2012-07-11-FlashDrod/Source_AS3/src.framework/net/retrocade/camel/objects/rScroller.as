package net.retrocade.camel.objects{    
    
    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rDisplay;
    import net.retrocade.camel.core.retrocamel_int;
    import net.retrocade.utils.UNumber;
    
    use namespace retrocamel_int;

    public class rScroller extends rObject{
        /****************************************************************************************************************/
        /**                                                                                              STATIC ACCESS  */
        /****************************************************************************************************************/
        
        /**
         * Instance of the currently used scroller 
         */
        private static var _instance:rScroller = new rScroller();
        
        public static function get instance():rScroller{
            return _instance;
        }
        
        public static function get x():Number{
            return _instance._x | 0;
        }
        
        public static function get y():Number{
            return _instance._y | 0;
        }
        
 
        
        
        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/
        
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Edges of the scroller
        // ::::::::::::::::::::::::::::::::::::::::::::::
        
        private var corner_left  :int     = 0;
        private var corner_top   :int     = 0;
        private var corner_right :int     = 0;
        private var corner_bottom:int     = 0;
        
        
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Current position
        // ::::::::::::::::::::::::::::::::::::::::::::::
  
        private var _x           :Number  = 0;
        private var _y           :Number  = 0;
  
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Position to scroll to
        // ::::::::::::::::::::::::::::::::::::::::::::::
        
        private var to_x         :Number  = 0;
        private var to_y         :Number  = 0;
        
        
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Miscellanous variables
        // ::::::::::::::::::::::::::::::::::::::::::::::
        
        public  var speed        :Number  = 1;
        private var locked       :Boolean = false;
        
        private var hScroll      :Boolean = true;
        private var vScroll      :Boolean = true;
        
        public  var followingObject:rObjectDisplay;
        
        
        
        /****************************************************************************************************************/
        /**                                                                                                  Functions  */
        /****************************************************************************************************************/
        
        /**
         * Constructor 
         */
        public function rScroller(){
            _instance = this;
        }
        
        override public function update():void{
            if (!locked && followingObject){
                to_x = followingObject.xMid - rCore._settings.SIZE_LEVEL_WIDTH  / rCore._settings.SCROLLER_SCALE / 2;
                to_y = followingObject.yMid - rCore._settings.SIZE_LEVEL_HEIGHT / rCore._settings.SCROLLER_SCALE / 2;
            }
            
            if (hScroll && _x != to_x)
                _x = UNumber.limit(UNumber.approach(_x, to_x, speed), corner_right, corner_left);
            
            if (vScroll && _y != to_y)
                _y = UNumber.limit(UNumber.approach(_y, to_y, speed), corner_bottom, corner_top);
        } 
        
        /**
         * Sets the edges of the scroller, maximum postion which can be displayed by it
         * @param _l Left edge of the scroller (this is the last pixel which will be displayed)
         * @param _t Top edge of the scroller (this is the last pixel which will be displayed)
         * @param _r Right edge of the scroller (this is the last pixel which will be displayed)
         * @param _b Bottom edge of the scroller (this is the last pixel which will be displayed)
         */
        public function setCorners(_l:Number, _t:Number, _r:Number, _b:Number):void{
            corner_left   = _l;
            corner_top    = _t;
            corner_right  = _r - rCore._settings.SIZE_LEVEL_WIDTH;
            corner_bottom = _b - rCore._settings.SIZE_LEVEL_HEIGHT;
        }
        
        /**
         * Tells the scroller to scroll to given position, only applicable if locked or there is no following object
         * @param toX X position to scroll to
         * @param toY Y position to scroll to
         */
        public function scrollTo(toX:Number, toY:Number):void{
            to_x = UNumber.limit(toX - rCore._settings.SIZE_LEVEL_WIDTH / 2, corner_right, corner_left)
            to_y = UNumber.limit(toY - rCore._settings.SIZE_LEVEL_HEIGHT / 2, corner_bottom, corner_top);
        }
        
        /**
         * Sets the scroller position to given coordinates immediately
         * @param toX X position to set the scroller to
         * @param toY Y position to set the scroller to
         */
        public function setScroll(toX:Number, toY:Number):void{
            _x = to_x = Math.max(corner_left, Math.min(corner_right,  toX));
            _y = to_y = Math.max(corner_top,  Math.min(corner_bottom, toY));
        }
        
        public function scrollingTypes(h:Boolean, v:Boolean):void{
            hScroll = h;
            vScroll = v;
        }
        
        public function lockScrolling()  :void{ locked = true;  }
        public function unlockScrolling():void{ locked = false; }
        
        public function get x():Number{ return Math.floor(_x); }
        public function get y():Number{ return Math.floor(_y); }
        
        public function get edgeLeft  ():Number{ return corner_left;   }
        public function get edgeRight ():Number{ return corner_right  + rCore._settings.SIZE_LEVEL_WIDTH;;  }
        public function get edgeTop   ():Number{ return corner_top      }
        public function get edgeBottom():Number{ return corner_bottom + rCore._settings.SIZE_LEVEL_HEIGHT; }
    }
}