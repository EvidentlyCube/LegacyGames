package tiles{
    import flash.display.MovieClip;
    
    import objects.Interactiver;

    public class Tile{
        public function Tile(x:Number, y:Number){
            Level.setTile(x/24, y/24, this);
        }
        
        public function hitH(o:Interactiver):void{
            o.hitH();
        }
        public function hitV(o:Interactiver):void{
            o.hitV();
        }
    }
}