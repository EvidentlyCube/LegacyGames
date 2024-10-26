package game.objects.actives {
    import game.global.CueEvents;
    import game.global.Game;
    import game.global.Room;
    
    import net.retrocade.camel.core.rGfx;
	/**
     * ...
     * @author 
     */
    public class TRoachEgg extends TMonster {     
        override public function getType():uint{ return C.M_REGG; }
        override public function isAggresive():Boolean{ return false; }
        
        override public function initialize(xml:XML = null):void{
            o = C.SW;
        }
        
        override public function setGfx():void{
            ASSERT(o == C.SW || o == C.W || o == C.NW || o == C.N);
            gfx = T.REGG[animationFrame][o];
        }
        
        override public function process(lastCommand:uint):void {
            switch(o) {
                case(C.SW):
                    o = C.W;
                    break;
                    
                case(C.W):
                    o = C.NW;
                    break;
                    
                case(C.NW):
                    o = C.N;
                    break;
                    
                case(C.N):
                    CueEvents.add(C.CID_EGG_HATCHED, this);
                    room.killMonster(this);
                    
                    room.addNewMonster(C.M_ROACH, x, y, 0);
                    return;
            }
            
            setGfx();
        }
    }

}