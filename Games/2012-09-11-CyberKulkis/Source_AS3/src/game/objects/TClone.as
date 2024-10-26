package game.objects{
    import game.global.Game;
    import game.global.Level;
    import game.tiles.TTile;

    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.utils.Key;

    public class TClone extends TGameObject{
        private static var __GFX:Array;

        public static function refreshGfx(): void {
            __GFX = [];
            __GFX[0] = rGfx.getBDExt(Game.generalGfxClass, 360, 120, 24, 24);
            __GFX[1] = rGfx.getBDExt(Game.generalGfxClass, 384, 120, 24, 24);
            __GFX[2] = rGfx.getBDExt(Game.generalGfxClass, 408, 120, 24, 24);
            __GFX[3] = rGfx.getBDExt(Game.generalGfxClass, 432, 120, 24, 24);

        }

        public function TClone(x:uint, y:uint, startdir:uint){
            this.x = x;
            this.y = y;

            getAt(x, y).addObject(this);

            addDefault();

            _gfx = __GFX[startdir];
        }

        override public function update():void{
            super.update();

            if (movementWait == 0){
                if (mx || my)
                    move(mx, my);
                else if (TPlayer.movedX || TPlayer.movedY)
                    move(TPlayer.movedX, TPlayer.movedY);
            }

            getAt(x, y).touched(this);
        }

        override public function move(tx:int, ty:int, force:Boolean = false):Boolean{
            if (super.move(tx, ty, force) == false){
                mx = my = 0;
                return false;
            }

            _gfx = __GFX[frameFromDelta(mx, my)];

            return true;
        }

        override public function enters(object:TGameObject, tx:int, ty:int):Boolean{
            if (object is TCrate){
                if (mx == -tx && my == -ty)
                    stop();
                return false;
            } else if (object is TClone)
                return false;

            return true;
        }

        override public function touched(object:TGameObject):void{
            if (object is TPlayer && bitmapCollision(object))
                object.kill();
        }
    }
}