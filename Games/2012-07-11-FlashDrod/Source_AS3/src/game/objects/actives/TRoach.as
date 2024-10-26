package game.objects.actives{
    import game.global.Game;
    import game.global.Room;
    import game.objects.TActiveObject;

    import net.retrocade.camel.core.rGfx;

    public class TRoach extends TMonster{
        override public function getType():uint{ return C.M_ROACH; }

        override public function process(lastCommand:uint):void{
            if (Game.doesBrainSensePlayer && getBrainMovement(room.pathmapGround)) {

            } else if (!Game.isInvisible || F.distanceInTiles(x, y, Game.player.x, Game.player.y) <= C.DEFAULT_SMELL_RANGE || Game.doesBrainSensePlayer) {
                getBeelineMovement(Game.player.x, Game.player.y);
            } else
                return;

            makeStandardMove();
            setOrientation(dxFirst, dyFirst);
        }

        override public function setGfx():void{
            gfx = T.ROACH[animationFrame][o];
        }
    }
}