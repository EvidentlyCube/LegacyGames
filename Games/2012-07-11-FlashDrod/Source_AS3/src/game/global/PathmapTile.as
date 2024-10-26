package game.global{
    import game.objects.actives.TMonster;
    public class PathmapTile{
        public var isObstacle:Boolean;
 
        public var targetDistance:uint;
        public var steps         :uint = 0;
        
        public var destinationSquares:Array = [];
        
        public var x:uint = 0;
        public var y:uint = 0;
        
        public function PathmapTile(x:uint, y:uint){
            this.x = x;
            this.y = y;
        }
    }
}