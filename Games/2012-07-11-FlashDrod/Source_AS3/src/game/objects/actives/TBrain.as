package game.objects.actives {
    import game.global.Game;
    import game.global.Gfx;
    import game.global.Room;
    
    import net.retrocade.camel.core.rGfx;

	/**
     * ...
     * @author 
     */
    public class TBrain extends TMonster {
        override public function getType():uint{ return C.M_BRAIN; }
        override public function isAggresive():Boolean{ return false; }
        
        override public function setGfx():void{
            gfx = T.BRAIN[animationFrame];
        }
        
        public function canSensePlayer():Boolean {
            return !Game.isInvisible || F.distanceInTiles(x, y, Game.player.x, Game.player.y) <= C.DEFAULT_SMELL_RANGE;
        }
    }
}