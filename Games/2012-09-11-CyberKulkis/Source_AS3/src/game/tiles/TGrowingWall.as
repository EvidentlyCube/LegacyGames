package game.tiles{
    import game.global.Game;
    import game.global.Sfx;
    import game.objects.TClone;
    import game.objects.TGameObject;
    import game.objects.TPlayer;

    import net.retrocade.camel.core.rGfx;

    public class TGrowingWall extends TGameObject{
        private static var __gfx:Array;
        public static function refreshGfx(): void {
            __gfx = [];
            __gfx[0] = rGfx.getBDExt(Game.generalGfxClass, 216, 72, 24, 24);
            __gfx[1] = rGfx.getBDExt(Game.generalGfxClass, 240, 72, 24, 24);
            __gfx[2] = rGfx.getBDExt(Game.generalGfxClass, 264, 72, 24, 24);
            __gfx[3] = rGfx.getBDExt(Game.generalGfxClass, 288, 72, 24, 24);
            __gfx[4] = rGfx.getBDExt(Game.generalGfxClass, 312, 72, 24, 24);
            __gfx[5] = rGfx.getBDExt(Game.generalGfxClass, 336, 72, 24, 24);
            __gfx[6] = rGfx.getBDExt(Game.generalGfxClass, 360, 72, 24, 24);
            __gfx[7] = rGfx.getBDExt(Game.generalGfxClass, 384, 72, 24, 24);
            __gfx[8] = rGfx.getBDExt(Game.generalGfxClass, 408, 72, 24, 24);

        }

        private var frame:uint = 0;

        public function TGrowingWall(x:uint, y:uint, isAlternate:Boolean){
            _x = x;
            _y = y;

            getAt(x, y).addObject(this);

            _gfx = __gfx[0];
        }

        override public function draw():void{
            Game.lGame.draw(_gfx, x, y);
        }

        override public function update():void{
            frame++;
            if (frame == 17){
                nullifyDefault();
                return;
            }

            _gfx = __gfx[frame / 2 | 0];
        }

        override public function enters(object:TGameObject, tx:int, ty:int):Boolean{
            return frame < 17
        }

        override public function touched(object:TGameObject):void{
            if (frame == 17 && bitmapCollision(object))
                object.stop();
        }

        override public function movedInto(object:TGameObject, tx:int, ty:int):void{
            if (frame > 0)
                return;

            if (object is TPlayer || object is TClone){
                addDefault();
                frame = 1;
                Sfx.growingWall();
            }
        }

        override public function toggle():void{
            isAlternate = !isAlternate;
        }
    }
}