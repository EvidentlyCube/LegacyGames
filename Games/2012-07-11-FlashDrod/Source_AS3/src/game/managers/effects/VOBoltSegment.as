package game.managers.effects{
    public class VOBoltSegment{
        public var bitmap:VOBitmapSegment;
        
        public var xSource:int;
        public var ySource:int;
        
        public var xPosition:int;
        public var yPosition:int;
        
        public function VOBoltSegment(bitmap:VOBitmapSegment, x1:int, y1:int, x2:int, y2:int){
            this.bitmap    = bitmap;
            this.xSource   = x1;
            this.ySource   = y1;
            this.xPosition = x2;
            this.yPosition = y2;
        }
    }
}