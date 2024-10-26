package game.managers{
    public class VOStairs{
        public var left    :uint;
        public var right   :uint;
        public var top     :uint;
        public var bottom  :uint;
        public var entrance:uint;
        public function VOStairs(xml:XML){
            entrance = xml.@EntranceID;
            left     = xml.@Left;
            right    = xml.@Right;
            top      = xml.@Top;
            bottom   = xml.@Bottom;
        }
    }
}