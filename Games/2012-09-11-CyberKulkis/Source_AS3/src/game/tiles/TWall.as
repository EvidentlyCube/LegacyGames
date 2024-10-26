package game.tiles{
    import game.global.Game;
    import game.objects.TGameObject;

    import net.retrocade.camel.core.rGfx;

    public class TWall extends TGameObject{
        public function TWall(x:uint, y:uint, tx:int, ty:int, isAlternate:Boolean){
            this.isAlternate = isAlternate;

            _x = x;
            _y = y;

            getAt(x, y).addObject(this);

            if (tx != -1 && ty != -1)
                _gfx = rGfx.getBDExt(Game.generalGfxClass, tx, ty, 24, 24);
        }

        override public function draw():void{
            Game.lGame.draw(_gfx, x, y);
        }

        override public function enters(object:TGameObject, tx:int, ty:int):Boolean{
            return false;
        }

        override public function touched(object:TGameObject):void{
            if (bitmapCollision(object))
                object.stop();
        }

        override public function toggle():void{
            isAlternate = !isAlternate;
        }
    }
}