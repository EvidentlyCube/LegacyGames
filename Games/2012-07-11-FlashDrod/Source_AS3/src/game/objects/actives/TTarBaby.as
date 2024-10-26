package game.objects.actives{
    import game.global.Game;
    import game.global.Room;
    import game.objects.TActiveObject;
    
    import net.retrocade.camel.core.rGfx;

    public class TTarBaby extends TRoach{
        override public function getType():uint{ return C.M_TARBABY; }

        override public function setGfx():void{
            gfx = T.TARBABY[animationFrame][o];
        }
    }
}