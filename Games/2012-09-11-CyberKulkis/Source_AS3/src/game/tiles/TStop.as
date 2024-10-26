package game.tiles{
    import game.global.Game;
    import game.global.Sfx;
    import game.objects.TClone;
    import game.objects.TCrate;
    import game.objects.TGameObject;
    import game.objects.TPlayer;

    import net.retrocade.camel.core.rGfx;

    public class TStop extends TGameObject{
        public function TStop(x:uint, y:uint, isAlternate:Boolean){
            this.isAlternate = isAlternate;

            _x = x;
            _y = y;

            getAt(x, y).addObject(this);

            _gfx = rGfx.getBDExt(Game.generalGfxClass, 168, 48, 24, 24);
        }

        override public function draw():void{
            Game.lGame.draw(_gfx, x, y);
        }

        override public function movedInto(object:TGameObject, tx:int, ty:int):void{
            if (object is TPlayer || object is TCrate || object is TClone){
                object.stop();
                Sfx.stopper();
            }
        }

        override public function toggle():void{
            isAlternate = !isAlternate;
        }
    }
}