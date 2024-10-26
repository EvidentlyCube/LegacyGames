package game.data{
    import flash.display.BitmapData;
    import flash.media.Sound;

    import game.global.Game;
    import game.global.Level;
    import game.global.Pre;
    import game.global.Score;
    import game.global.Sfx;
    import game.objects.TConnector;

    import net.retrocade.camel.core.rGfx;

    public class TPath extends TConnector{
        private var _gfxCompleted:BitmapData;

        public function TPath(x:uint, y:uint, color:uint){
            _x     = x;
            _y     = y;
            _color = color;

            Level.paths.add(this);
            Level.level.set(_x, _y, this);

            TConnectorData.make(this);

            Score.pathsPlaced.add(1);

            Sfx.sfxPlacePathPlay();

            resetGfx();

            resetNeighbors();
        }

        public function resetNeighbors():void{
            var n:* = Level.level.get(_x, _y - 16);
            if (n is TConnector) n.resetGfx();

            n = Level.level.get(_x, _y + 16);
            if (n is TConnector) n.resetGfx();

            n = Level.level.get(_x - 16, _y);
            if (n is TConnector) n.resetGfx();

            n = Level.level.get(_x + 16, _y);
            if (n is TConnector) n.resetGfx();
        }

        override public function resetGfx():void{
            var n:*;

            n = Level.level.get(_x, _y - 16)
            var nN:String = n is TConnector && n.color == color ? "1" : "0";

            n = Level.level.get(_x, _y + 16)
            var nS:String = n is TConnector && n.color == color ? "1" : "0";

            n = Level.level.get(_x - 16, _y)
            var nW:String = n is TConnector && n.color == color ? "1" : "0";

            n = Level.level.get(_x + 16, _y)
            var nE:String = n is TConnector && n.color == color ? "1" : "0";

            var gfx:Class = Game['_gfx_' + (Pre.colorBlind ? "cb" : "") + color];

            switch(nN + nE + nS + nW){
                case("0000"):
                    _gfx          = rGfx.getBDExt(gfx, 1,  1, 16, 16);
                    _gfxCompleted = rGfx.getBDExt(gfx, 69, 0, 16, 16);
                    break;
                case("0001"):
                    _gfx          = rGfx.getBDExt(gfx, 52, 18, 16, 16);
                    _gfxCompleted = rGfx.getBDExt(gfx, 120, 18, 16, 16);
                    break;
                case("0010"):
                    _gfx          = rGfx.getBDExt(gfx, 18, 1, 16, 16);
                    _gfxCompleted = rGfx.getBDExt(gfx, 86, 1, 16, 16);
                    break;
                case("0011"):
                    _gfx          = rGfx.getBDExt(gfx, 35, 35, 16, 16);
                    _gfxCompleted = rGfx.getBDExt(gfx, 103, 35, 16, 16);
                    break;
                case("0100"):
                    _gfx          = rGfx.getBDExt(gfx, 1, 18, 16, 16);
                    _gfxCompleted = rGfx.getBDExt(gfx, 69, 18, 16, 16);
                    break;
                case("0101"):
                    _gfx          = rGfx.getBDExt(gfx, 35, 18, 16, 16);
                    _gfxCompleted = rGfx.getBDExt(gfx, 103, 18, 16, 16);
                    break;
                case("0110"):
                    _gfx          = rGfx.getBDExt(gfx, 52, 35, 16, 16);
                    _gfxCompleted = rGfx.getBDExt(gfx, 120, 35, 16, 16);
                    break;
                case("0111"):
                    _gfx          = rGfx.getBDExt(gfx, 1, 35, 16, 16);
                    _gfxCompleted = rGfx.getBDExt(gfx, 69, 35, 16, 16);
                    break;
                case("1000"):
                    _gfx          = rGfx.getBDExt(gfx, 18, 52, 16, 16);
                    _gfxCompleted = rGfx.getBDExt(gfx, 86, 52, 16, 16);
                    break;
                case("1001"):
                    _gfx          = rGfx.getBDExt(gfx, 35, 52, 16, 16);
                    _gfxCompleted = rGfx.getBDExt(gfx, 103, 52, 16, 16);
                    break;
                case("1010"):
                    _gfx          = rGfx.getBDExt(gfx, 18, 35, 16, 16);
                    _gfxCompleted = rGfx.getBDExt(gfx, 86, 35, 16, 16);
                    break;
                case("1011"):
                    _gfx          = rGfx.getBDExt(gfx, 52, 1, 16, 16);
                    _gfxCompleted = rGfx.getBDExt(gfx, 120, 1, 16, 16);
                    break;
                case("1100"):
                    _gfx          = rGfx.getBDExt(gfx, 52, 52, 16, 16);
                    _gfxCompleted = rGfx.getBDExt(gfx, 120, 52, 16, 16);
                    break;
                case("1101"):
                    _gfx          = rGfx.getBDExt(gfx, 1, 52, 16, 16);
                    _gfxCompleted = rGfx.getBDExt(gfx, 69, 52, 16, 16);
                    break;
                case("1110"):
                    _gfx          = rGfx.getBDExt(gfx, 35, 1, 16, 16);
                    _gfxCompleted = rGfx.getBDExt(gfx, 103, 1, 16, 16);
                    break;
                case("1111"):
                    _gfx          = rGfx.getBDExt(gfx, 18, 18, 16, 16);
                    _gfxCompleted = rGfx.getBDExt(gfx, 86, 18, 16, 16);
                    break;
            }

        }

        override public function update():void{
            if (this.allConnected)
                Game.lGame.draw(_gfxCompleted, x + S().playfieldOffsetX, y + S().playfieldOffsetY);
            else
                Game.lGame.draw(_gfx, x + S().playfieldOffsetX, y + S().playfieldOffsetY);
        }

        public function clear():void{
            Level.level.set(_x, _y, null);
            Level.paths.nullify(this);

            TConnectorData.make(this);
            Score.pathsPlaced.add(-1);

            resetNeighbors();
        }
    }
}