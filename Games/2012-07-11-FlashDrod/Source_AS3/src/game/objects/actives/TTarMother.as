package game.objects.actives{
    import game.global.CueEvents;
    import game.global.Game;
    import game.global.Room;

    import net.retrocade.camel.core.rGfx;

    public class TTarMother extends TMonster{
        override public function getType():uint { return C.M_TARMOTHER; }
        override public function isAggresive():Boolean{ return false; }

        public var leftEye:Boolean;

        override public function initialize(xml:XML = null):void{
            leftEye = (o == C.NO_ORIENTATION || o == C.W);
        }

        override public function process(lastCommand:uint):void {

            var isScared:Boolean = room.isSwordWithinRect(x - (leftEye ? 1 : 2), y - 1, x + (leftEye ? 2 : 1), y + 1);

            if (Game.spawnCycleCount % C.TURNS_PER_CYCLE == C.TURNS_PER_CYCLE - 1)
                o = (leftEye != isScared ? C.W : C.SW);
            else
                o = (leftEye != isScared ? C.NO_ORIENTATION : C.S);

            if ((Game.spawnCycleCount % C.TURNS_PER_CYCLE == 0) &&
                    (Game.doesBrainSensePlayer || !Game.isInvisible ||
                    F.distanceInTiles(x, y, Game.player.x, Game.player.y) <= C.DEFAULT_SMELL_RANGE))
                CueEvents.add(C.CID_TAR_GREW, this);

            setGfx();
        }

        override public function setGfx():void{
            switch(o){
                case(C.NO_ORIENTATION):
                    gfx = T.TI_TMOTHER_WO;
                    break;

                case(C.S):
                    gfx = T.TI_TMOTHER_EO;
                    break;

                case(C.W):
                    gfx = T.TI_TMOTHER_WC;
                    break;

                case(C.SW):
                    gfx = T.TI_TMOTHER_EC;
                    break;
            }

        }

        override public function getSnapshot():Object {
            var object:Object = super.getSnapshot();

            object.leftEye = leftEye;

            return object;
        }
    }
}