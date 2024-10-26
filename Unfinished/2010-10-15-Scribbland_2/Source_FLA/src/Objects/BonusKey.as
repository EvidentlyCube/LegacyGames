package src.Objects{
    import flash.display.MovieClip;
    
    import src.PlatformerEngine.Level;
    import src.PlatformerEngine.ObjDisplay;
    
    public class BonusKey extends Bonus{
        public function BonusKey(x:int, y:int, gfx:MovieClip){
            _gfx = gfx;
            
            super(x, y, 11, 17);
        }
        
        override public function undo():void{
            Level.keys.add(-1);
            super.undo();
        }
        
        override public function collect():void{
            Level.keys.add(1);
            super.collect();
        }
    }
}