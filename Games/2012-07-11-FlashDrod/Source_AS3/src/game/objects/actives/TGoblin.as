package game.objects.actives{
    import game.global.Game;
    import game.global.Gfx;
    import game.global.Room;
    import game.objects.TActiveObject;

    import net.retrocade.camel.core.rGfx;

    public class TGoblin extends TMonster{
        override public function getType():uint{ return C.M_GOBLIN; }

        override public function process(lastCommand:uint):void{
            if (Game.doesBrainSensePlayer || !Game.isInvisible || F.distanceInTiles(x, y, Game.player.x, Game.player.y) <= C.DEFAULT_SMELL_RANGE)
                getAvoidSwordMovement(Game.player.x, Game.player.y);
            else
                return;

            makeStandardMove();
            setOrientation(dxFirst, dyFirst);
        }

        override public function setGfx():void{
            gfx = T.GOBLIN[animationFrame][o];
        }
    }
}