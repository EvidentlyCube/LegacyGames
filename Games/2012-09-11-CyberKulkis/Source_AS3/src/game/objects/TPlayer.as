package game.objects{
    import game.global.Game;
    import game.global.Level;
    import game.global.LevelManager;
    import game.global.Sfx;
    import game.tiles.TTile;

    import net.retrocade.camel.core.rEvents;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.utils.Key;

    public class TPlayer extends TGameObject{
        public static var movedX:int = 0;
        public static var movedY:int = 0;

        public var isIndestructible:Boolean = false;

        private static var __GFX:Array;

        public static function refreshGfx(): void{
            __GFX = [];
            __GFX[2] = rGfx.getBDExt(Game.generalGfxClass, 264, 144, 24, 24);
            __GFX[3] = rGfx.getBDExt(Game.generalGfxClass, 288, 144, 24, 24);
            __GFX[0] = rGfx.getBDExt(Game.generalGfxClass, 312, 144, 24, 24);
            __GFX[1] = rGfx.getBDExt(Game.generalGfxClass, 336, 144, 24, 24);
        }

        public function TPlayer(x:uint, y:uint){
            this.x = x;
            this.y = y;

            getAt(x, y).addObject(this);

            addAtDefault(0);

            _gfx = __GFX[0];
        }

        override public function update():void{
            super.update();

            if (movementWait == 0){
                if (mx || my)
                    move(mx, my);
                else if (rInput.isKeyDown(Game.keyUp)){
                    if (LevelManager.canPlayerMove() && move(0, -1)){
                        movedX = mx;
                        movedY = my;
                        rEvents.add(C.E_MADE_MOVE);
                        THelp.event(THelp._MOVE);
                    }
                } else if (rInput.isKeyDown(Game.keyDown)){
                    if (LevelManager.canPlayerMove() && move(0, 1)){
                        movedX = mx;
                        movedY = my;
                        rEvents.add(C.E_MADE_MOVE);
                        THelp.event(THelp._MOVE);
                    }
                }else if (rInput.isKeyDown(Game.keyLeft)){
                    if (LevelManager.canPlayerMove() && move(-1, 0)){
                        movedX = mx;
                        movedY = my;
                        rEvents.add(C.E_MADE_MOVE);
                        THelp.event(THelp._MOVE);
                    }
                }else if (rInput.isKeyDown(Game.keyRight)){
                    if (LevelManager.canPlayerMove() &&  move(1, 0)){
                        movedX = mx;
                        movedY = my;
                        rEvents.add(C.E_MADE_MOVE);
                        THelp.event(THelp._MOVE);
                    }
                }
            }

            if (lastX != x || lastY != y)
                getAt(lastX, lastY).touched(this);
            getAt(x, y).touched(this);
        }

        override public function move(tx:int, ty:int, force:Boolean = false):Boolean{
            if (super.move(tx, ty, force) == false){
                mx = my = 0;
                Sfx.wall();
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
            } else if (object is TPlayer)
                return false;

            return true;
        }

        override public function kill():void{
            if (isIndestructible)
                return;

            super.kill();
            Sfx.killPlayer();

            LevelManager.restartLevel(500);
        }
    }
}