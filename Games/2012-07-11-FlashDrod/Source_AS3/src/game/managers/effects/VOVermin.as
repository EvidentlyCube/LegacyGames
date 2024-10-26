package game.managers.effects{
    public class VOVermin{
        public static const ACC_HARD_LEFT :uint = 0;
        public static const ACC_LEFT      :uint = 1;
        public static const ACC_FORWARD   :uint = 2; 
        public static const ACC_RIGHT     :uint = 3;
        public static const ACC_HARD_RIGHT:uint = 4;
        public static const ACC_COUNT     :uint = 5
        
        public var x:Number;
        public var y:Number;
        public var angle:Number;
        public var acceleration:uint;
        public var size:uint;
        public var type:uint;
        public var active:Boolean = true;
    }
}