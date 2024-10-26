package game.tiles{
    import flash.display.BitmapData;

    import game.global.Game;
    import game.global.Level;
    import game.objects.TGameObject;

    import net.retrocade.camel.core.rGfx;

    public class TTilePit extends TGameObject{
        [Embed(source="/../assets/gfx/by_cage/tiles/pit.png")] public static var _pit:Class;

        private var _bmp:BitmapData;

        private var frame:int = -1;


        public function TTilePit(x:uint, y:uint){
            this._x = x;
            this._y = y;

            Level.level.set(x, y, this);

            addDefault();
        }

        override public function update():void{
            if (frame == -1){
                setFrame();
                _bmp = rGfx.getBDExt(_pit, frame * 16, 0, 16, 16);
            }

            Game.lBG.draw(_bmp, _x + S().playfieldOffsetX, _y + S().playfieldOffsetY);
        }

        private function setFrame():void{
            var p1:Boolean = !(Level.level.get(_x - 16, _y + 16) is TTilePit || x == 0 || y == 208);
            var p2:Boolean = !(Level.level.get(_x     , _y + 16) is TTilePit || y == 208);
            var p3:Boolean = !(Level.level.get(_x + 16, _y + 16) is TTilePit || x == 176 || y == 208);
            var p4:Boolean = !(Level.level.get(_x - 16, _y     ) is TTilePit || x == 0);
            var p6:Boolean = !(Level.level.get(_x + 16, _y     ) is TTilePit || x == 176);
            var p7:Boolean = !(Level.level.get(_x - 16, _y - 16) is TTilePit || x == 0 || y == 0);
            var p8:Boolean = !(Level.level.get(_x     , _y - 16) is TTilePit || y == 0);
            var p9:Boolean = !(Level.level.get(_x + 16, _y - 16) is TTilePit || x == 176 || y == 0);

            if      (        p2 &&         p4 &&  p6 &&         p8       )  frame = 0;

            else if (        p2 &&         p4 && !p6 &&         p8       )  frame = 1;
            else if (       !p2 &&         p4 &&  p6 &&         p8       )  frame = 2;
            else if (        p2 &&        !p4 &&  p6 &&         p8       )  frame = 3;
            else if (        p2 &&         p4 &&  p6 &&        !p8       )  frame = 4;

            else if (        p2 &&        !p4 && !p6 &&         p8       )  frame = 5;
            else if (       !p2 &&         p4 &&  p6 &&        !p8       )  frame = 6;

            else if (       !p2 &&  p3 &&  p4 && !p6 &&         p8       )  frame = 7;
            else if ( p1 && !p2 &&        !p4 &&  p6 &&         p8       )  frame = 8;
            else if (        p2 &&        !p4 &&  p6 &&  p7 && !p8       )  frame = 9;
            else if (        p2 &&         p4 && !p6 &&        !p8 &&  p9)  frame = 10;

            else if ( p1 && !p2 &&  p3 && !p4 && !p6 &&         p8       )  frame = 11;
            else if ( p1 && !p2 &&        !p4 &&  p6 &&  p7 && !p8       )  frame = 12;
            else if (        p2 &&        !p4 && !p6 &&  p7 && !p8 &&  p9)  frame = 13;
            else if (       !p2 &&  p3 &&  p4 && !p6 &&        !p8 &&  p9)  frame = 14;

            else if ( p1 && !p2 &&  p3 && !p4 && !p6 &&  p7 && !p8 &&  p9)  frame = 15;

            else if (       !p2 && !p3 &&  p4 && !p6 &&         p8       )  frame = 16;
            else if (!p1 && !p2        && !p4 &&  p6 &&         p8       )  frame = 17;
            else if (        p2 &&        !p4 &&  p6 && !p7 && !p8       )  frame = 18;
            else if (        p2 &&         p4 && !p6 &&        !p8 && !p9)  frame = 19;

            else if (!p1 && !p2 &&        !p4 &&  p6 &&  p7 && !p8       )  frame = 20;
            else if ( p1 && !p2 &&        !p4 &&  p6 && !p7 && !p8       )  frame = 21;
            else if (!p1 && !p2 &&        !p4 &&  p6 && !p7 && !p8       )  frame = 22;

            else if (        p2 &&        !p4 && !p6 && !p7 && !p8 &&  p9)  frame = 23;
            else if (        p2 &&        !p4 && !p6 &&  p7 && !p8 && !p9)  frame = 24;
            else if (        p2 &&        !p4 && !p6 && !p7 && !p8 && !p9)  frame = 25;

            else if (       !p2 &&  p3 &&  p4 && !p6 &&        !p8 && !p9)  frame = 26;
            else if (       !p2 && !p3 &&  p4 && !p6 &&        !p8 &&  p9)  frame = 27;
            else if (       !p2 && !p3 &&  p4 && !p6 &&        !p8 && !p9)  frame = 28;

            else if ( p1 && !p2 && !p3 && !p4 && !p6 &&         p8       )  frame = 29;
            else if (!p1 && !p2 &&  p3 && !p4 && !p6 &&         p8       )  frame = 30;
            else if (!p1 && !p2 && !p3 && !p4 && !p6 &&         p8       )  frame = 31;

            else if (!p1 && !p2 && !p3 && !p4 && !p6 &&  p7 && !p8 && !p9)  frame = 32;
            else if (!p1 && !p2 && !p3 && !p4 && !p6 && !p7 && !p8 &&  p9)  frame = 33;
            else if ( p1 && !p2 && !p3 && !p4 && !p6 && !p7 && !p8 && !p9)  frame = 34;
            else if (!p1 && !p2 &&  p3 && !p4 && !p6 && !p7 && !p8 && !p9)  frame = 35;

            else if (!p1 && !p2 && !p3 && !p4 && !p6 &&  p7 && !p8 &&  p9)  frame = 36;
            else if ( p1 && !p2 && !p3 && !p4 && !p6 &&  p7 && !p8 && !p9)  frame = 37;
            else if (!p1 && !p2 &&  p3 && !p4 && !p6 &&  p7 && !p8 && !p9)  frame = 38;
            else if ( p1 && !p2 && !p3 && !p4 && !p6 && !p7 && !p8 &&  p9)  frame = 39;
            else if (!p1 && !p2 &&  p3 && !p4 && !p6 && !p7 && !p8 &&  p9)  frame = 40;
            else if ( p1 && !p2 &&  p3 && !p4 && !p6 && !p7 && !p8 && !p9)  frame = 41;

            else if ( p1 && !p2 && !p3 && !p4 && !p6 &&  p7 && !p8 &&  p9)  frame = 42;
            else if (!p1 && !p2 &&  p3 && !p4 && !p6 &&  p7 && !p8 &&  p9)  frame = 43;
            else if ( p1 && !p2 &&  p3 && !p4 && !p6 &&  p7 && !p8 && !p9)  frame = 44;
            else if ( p1 && !p2 &&  p3 && !p4 && !p6 && !p7 && !p8 &&  p9)  frame = 45;
            else if (!p1 && !p2 && !p3 && !p4 && !p6 && !p7 && !p8 && !p9)  frame = 46;
        }
    }
}