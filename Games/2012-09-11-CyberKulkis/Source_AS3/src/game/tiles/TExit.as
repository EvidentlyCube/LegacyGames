package game.tiles{
    import game.global.Game;
    import game.global.LevelManager;
    import game.global.Score;
    import game.global.Sfx;
    import game.objects.TGameObject;
    import game.objects.THelp;
    import game.objects.TPlayer;

    import net.retrocade.camel.core.rGfx;

    public class TExit extends TGameObject{
        public static var _frames:Array;

        public static function refreshGfx(): void {
            _frames = [];
            _frames[0] = rGfx.getBDExt(Game.generalGfxClass, 48,  72, 24, 24);
            _frames[1] = rGfx.getBDExt(Game.generalGfxClass, 72,  72, 24, 24);
            _frames[2] = rGfx.getBDExt(Game.generalGfxClass, 96,  72, 24, 24);

            _frames[3] = rGfx.getBDExt(Game.generalGfxClass, 120, 72, 24, 24);
            _frames[4] = rGfx.getBDExt(Game.generalGfxClass, 144, 72, 24, 24);
            _frames[5] = rGfx.getBDExt(Game.generalGfxClass, 168, 72, 24, 24);

            _frames[6] = rGfx.getBDExt(Game.generalGfxClass, 0,   72, 24, 24);
        }

        private var isOpened:Boolean = false;
        private var isUsed  :Boolean = false;
        private var frame   :Number  = 0;

        public function TExit(x:uint, y:uint, isAlternate:Boolean){
            this.isAlternate = isAlternate;

            _x = x;
            _y = y;

            addDefault();
            getAt(x, y).addObject(this);

            _gfx = _frames[0];
        }

        override public function draw():void{
            Game.lGame.draw(_gfx, x, y);
        }

        override public function update():void{
            if (isUsed)
                return;

            else if (isOpened){
                frame += Math.PI / 30;
                _gfx = _frames[Math.round(Math.sin(frame) + 4)];

            } else {
                frame += Math.PI / 30;
                _gfx = _frames[Math.round(Math.sin(frame) + 1)];

                if (Score.bonusLeft.get() == 0){
                    isOpened = true;
                    Sfx.exitOpened();
                    THelp.event(THelp._EXITOPEN);
                }
            }
        }

        override public function movedInto(object:TGameObject, tx:int, ty:int):void{
            if (object is TPlayer && isOpened){
                TPlayer(object).isIndestructible = true;

                object.stop();

                isUsed = true;

                _gfx = _frames[6];

                THelp.event(THelp._EXITENTER);
                LevelManager.levelCompleted();
            }
        }

        override public function toggle():void{
            isAlternate = !isAlternate;
        }
    }
}