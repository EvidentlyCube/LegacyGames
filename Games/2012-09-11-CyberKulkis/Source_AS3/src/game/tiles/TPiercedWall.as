package game.tiles{
    import game.global.Game;
    import game.objects.TBullet;
    import game.objects.TGameObject;

    import net.retrocade.camel.core.rGfx;

    public class TPiercedWall extends TGameObject{
        private var blockX:Boolean;
        private var blockY:Boolean;
        public function TPiercedWall(x:uint, y:uint, tx:uint, ty:uint, blockx:Boolean, blocky:Boolean, isAlternate:Boolean){
            this.isAlternate = isAlternate;

            _x = x;
            _y = y;

            blockX = blockx;
            blockY = blocky;

            getAt(x, y).addObject(this);

            _gfx = rGfx.getBDExt(Game.generalGfxClass, tx, ty, 24, 24);
        }

        override public function draw():void{
            Game.lGame.draw(_gfx, x, y);
        }

        override public function enters(object:TGameObject, tx:int, ty:int):Boolean{
            return false;
        }

        override public function touched(object:TGameObject):void{
            if (object is TBullet && ((object.mx && blockX) || (object.my && blockY)) && bitmapCollision(object))
                object.stop();
        }

        override public function toggle():void{
            isAlternate = !isAlternate;
        }
    }
}