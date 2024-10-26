package game.tiles{
    import game.global.Game;
    import game.global.Sfx;
    import game.objects.TBullet;
    import game.objects.TGameObject;

    import net.retrocade.camel.core.rGfx;

    public class TRotationWall extends TGameObject{
        private static var _gfxCW:Array;
        private static var _gfxCCW:Array;

        public static function refreshGfx(): void {
            _gfxCW  = [];
            _gfxCCW = [];

            _gfxCW[0]  = rGfx.getBDExt(Game.generalGfxClass, 0,   336, 24, 24);
            _gfxCW[1]  = rGfx.getBDExt(Game.generalGfxClass, 24,  336, 24, 24);
            _gfxCW[2]  = rGfx.getBDExt(Game.generalGfxClass, 48,  336, 24, 24);
            _gfxCW[3]  = rGfx.getBDExt(Game.generalGfxClass, 72,  336, 24, 24);
            _gfxCW[4]  = rGfx.getBDExt(Game.generalGfxClass, 96,  336, 24, 24);
            _gfxCW[5]  = rGfx.getBDExt(Game.generalGfxClass, 120, 336, 24, 24);
            _gfxCW[6]  = rGfx.getBDExt(Game.generalGfxClass, 144, 336, 24, 24);
            _gfxCW[7]  = rGfx.getBDExt(Game.generalGfxClass, 168, 336, 24, 24);

            _gfxCCW[0] = rGfx.getBDExt(Game.generalGfxClass, 240, 336, 24, 24);
            _gfxCCW[1] = rGfx.getBDExt(Game.generalGfxClass, 264, 336, 24, 24);
            _gfxCCW[2] = rGfx.getBDExt(Game.generalGfxClass, 288, 336, 24, 24);
            _gfxCCW[3] = rGfx.getBDExt(Game.generalGfxClass, 312, 336, 24, 24);
            _gfxCCW[4] = rGfx.getBDExt(Game.generalGfxClass, 336, 336, 24, 24);
            _gfxCCW[5] = rGfx.getBDExt(Game.generalGfxClass, 360, 336, 24, 24);
            _gfxCCW[6] = rGfx.getBDExt(Game.generalGfxClass, 384, 336, 24, 24);
            _gfxCCW[7] = rGfx.getBDExt(Game.generalGfxClass, 408, 336, 24, 24);
        }

        private var isCW:Boolean;
        private var frame:uint = 0;

        public function TRotationWall(x:uint, y:uint, cw:Boolean, isAlternate:Boolean){
            _x = x;
            _y = y;

            isCW = cw;

            _gfx = _gfxCW[0];

            getAt(x, y).addObject(this);
        }

        override public function draw():void{
            frame++;
            if (frame == 7 * 3)
                frame = 0;

            _gfx = (isCW ? _gfxCW[frame / 3 | 0] : _gfxCCW[frame / 3 | 0]);
            Game.lGame.draw(_gfx, x, y);
        }

        override public function enters(object:TGameObject, tx:int, ty:int):Boolean{
            if (!(object is TBullet)){
                Sfx.turnwall();
                if (isCW)
                    return object.redirect(-ty, tx);
                else
                    return object.redirect(ty, -tx);
            }

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