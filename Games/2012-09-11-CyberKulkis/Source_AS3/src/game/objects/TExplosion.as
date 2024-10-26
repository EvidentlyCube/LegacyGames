package game.objects{
    import flash.display.BlendMode;

    import game.global.Game;
    import game.global.Level;

    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.objects.rObjectDisplay;

    public class TExplosion extends rObjectDisplay{
        [Embed(source="/../assets/gfx/explosions.png")] public static var _gfx_:Class;
        private static var __gfx:Array;

        {
            __gfx = [[], []];
            __gfx[0][0]  = rGfx.getBDExt(_gfx_, 0,   0,  48, 48);
            __gfx[0][1]  = rGfx.getBDExt(_gfx_, 48,  0,  48, 48);
            __gfx[0][2]  = rGfx.getBDExt(_gfx_, 96,  0,  48, 48);
            __gfx[0][3]  = rGfx.getBDExt(_gfx_, 144, 0,  48, 48);
            __gfx[0][4]  = rGfx.getBDExt(_gfx_, 192, 0,  48, 48);
            __gfx[0][5]  = rGfx.getBDExt(_gfx_, 240, 0,  48, 48);
            __gfx[0][6]  = rGfx.getBDExt(_gfx_, 288, 0,  48, 48);
            __gfx[0][7]  = rGfx.getBDExt(_gfx_, 336, 0,  48, 48);
            __gfx[0][8]  = rGfx.getBDExt(_gfx_, 384, 0,  48, 48);
            __gfx[0][9]  = rGfx.getBDExt(_gfx_, 432, 0,  48, 48);
            __gfx[0][10] = rGfx.getBDExt(_gfx_, 480, 0,  48, 48);

            __gfx[1][0]  = rGfx.getBDExt(_gfx_, 0,   48, 48, 48);
            __gfx[1][1]  = rGfx.getBDExt(_gfx_, 48,  48, 48, 48);
            __gfx[1][2]  = rGfx.getBDExt(_gfx_, 96,  48, 48, 48);
            __gfx[1][3]  = rGfx.getBDExt(_gfx_, 144, 48, 48, 48);
            __gfx[1][4]  = rGfx.getBDExt(_gfx_, 192, 48, 48, 48);
            __gfx[1][5]  = rGfx.getBDExt(_gfx_, 240, 48, 48, 48);
            __gfx[1][6]  = rGfx.getBDExt(_gfx_, 288, 48, 48, 48);
            __gfx[1][7]  = rGfx.getBDExt(_gfx_, 336, 48, 48, 48);
            __gfx[1][8]  = rGfx.getBDExt(_gfx_, 384, 48, 48, 48);
            __gfx[1][9]  = rGfx.getBDExt(_gfx_, 432, 48, 48, 48);
            __gfx[1][10] = rGfx.getBDExt(_gfx_, 480, 48, 48, 48);
        }

        private var type:uint;
        private var frame:uint = 0;
        public function TExplosion(x:uint, y:uint, type:uint){
            this.x = x - 12;
            this.y = y - 12;

            this.type = type;

            Level.effects.add(this);
        }

        override public function update():void{
            frame++;
            if (frame >= __gfx[type].length * 3){
                Level.effects.nullify(this);
                return;
            }

            _gfx = __gfx[type][frame / 3 | 0];

            Game.lGame.drawAdvanced(_gfx, x, y, 0, 1, 1, BlendMode.ADD, false, 1);
        }
    }
}