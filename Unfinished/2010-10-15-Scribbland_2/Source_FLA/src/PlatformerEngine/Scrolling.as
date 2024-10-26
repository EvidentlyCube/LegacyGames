package src.PlatformerEngine{
    public class Scrolling    {
        private static var corner_left  :int     = 0;
        private static var corner_top   :int     = 0;
        private static var corner_right :int     = 0;
        private static var corner_bottom:int     = 0;
        
        private static var _x           :Number  = 0;
        private static var _y           :Number  = 0;
        
        private static var to_x         :Number  = 0;
        private static var to_y         :Number  = 0;
        
        private static var speed        :Number  = 1;
        private static var locked       :Boolean = false;
        
        private static var hScroll      :Boolean = true;
        private static var vScroll      :Boolean = true;
        
        private static var followingObject:ObjInteractive;
        
        internal static function updateScrolling():void{
            if (!locked && followingObject){
                to_x = followingObject.xMid - Settings.SCREEN_WIDTH/2;
                to_y = followingObject.yMid - Settings.SCREEN_HEIGHT/2;
            }
            
            if (hScroll && _x != to_x){
                _x = Math.max(corner_left, Math.min(corner_right, _x+(to_x-_x)*speed));
            }
            
            if (vScroll && _y != to_y){
                _y = Math.max(corner_top, Math.min(corner_bottom, _y+(to_y-_y)*speed));
            }
            
            Gfx.setScroll(-x, -y);
        } 
        
        public static function follow(o:ObjInteractive):void{
            followingObject = o;
        }
        
        public static function setSpeed(_spd:Number):void{
            speed = _spd;
        }
        
        public static function setCorners(_l:Number, _t:Number, _r:Number, _b:Number):void{
            corner_left   = _l;
            corner_top    = _t;
            corner_right  = _r - Settings.SCREEN_WIDTH;
            corner_bottom = _b - Settings.SCREEN_HEIGHT;
        } 
        
        public static function scrollTo(toX:Number, toY:Number):void{
            to_x = toX;
            to_y = toY;
        }
        
        public static function setScroll(toX:Number, toY:Number):void{
            _x = to_x = toX;
            _y = to_y = toY;
        }
        
        public static function scrollingTypes(h:Boolean, v:Boolean):void{
            hScroll = h;
            vScroll = v;
        }
        
        public static function lockScrolling()  :void{ locked = true;  }
        public static function unlockScrolling():void{ locked = false; }
        
        public static function get x():Number{ return Math.floor(_x); }
        public static function get y():Number{ return Math.floor(_y); }
        
        public static function get edgeLeft  ():Number{ return corner_left;   }
        public static function get edgeRight ():Number{ return corner_right;  }
        public static function get edgeTop   ():Number{ return corner_top;    }
        public static function get edgeBottom():Number{ return corner_bottom; }
    }
}