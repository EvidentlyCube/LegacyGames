package game.objects.actives{
    import game.global.Game;
    import game.global.Room;
    import game.objects.TActiveObject;

    import net.retrocade.camel.core.rGfx;

    public class TWraithwing extends TMonster{
        override public function getType():uint{ return C.M_WWING; }

        override public function isFlying():Boolean{ return true; }

        override public function process(lastCommand:uint):void{
            if (Game.doesBrainSensePlayer && getBrainMovement(room.pathmapAir)) {

            } else if (!Game.isInvisible || F.distanceInTiles(x, y, Game.player.x, Game.player.y) <= C.DEFAULT_SMELL_RANGE || Game.doesBrainSensePlayer) {
                getBeelineMovement(Game.player.x, Game.player.y);
            } else
                return;

            var distance:int = F.distanceInTiles(Game.player.x, Game.player.y, x, y);
            var runaway:Boolean = true;

            if (distance <= 5){
                var distance2:uint;

                for each(var monster:TMonster in room.monsters.getAllOriginal()){
                    if (!monster || !(monster is TWraithwing) || monster == this)
                        continue;

                    distance2 = F.distanceInTiles(monster.x, monster.y, Game.player.x, Game.player.y);

                    if ((distance2 > distance ? distance2 - distance : distance - distance2) <= 2 &&
                        F.distanceInTiles(monster.x, monster.y, x, y) >= 3){
                        runaway = false;
                        break;
                    }
                }

                if (runaway){
                    if (distance == 5)
                        dx = dy = 0;
                    else {
                        dxFirst = dx = -dxFirst;
                        dyFirst = dy = -dyFirst;
                        getBestMove();
                    }
                }
            } // End: (distance < 5)

            makeStandardMove();
            setOrientation(dxFirst, dyFirst);
        }

        override public function setGfx():void{
            gfx = T.WWING[animationFrame][o];
        }
    }
}