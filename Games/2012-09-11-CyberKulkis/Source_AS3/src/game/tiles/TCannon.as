package game.tiles{
    import game.global.Game;
    import game.global.Sfx;
    import game.objects.TBullet;
    import game.objects.TExplosion;
    import game.objects.TGameObject;
    import game.objects.THelp;
    import game.objects.TPlayer;
    import game.windows.TWinPause;

    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.utils.UNumber;

    public class TCannon extends TGameObject{
        private var explosionTimer:uint = 0;
        private var dir           :int;

        public function TCannon(x:uint, y:uint, dir:uint, isAlternate:Boolean){
            this.isAlternate = isAlternate;

            _x = x;
            _y = y;

            this.dir = dir;

            mx = dir == 0 ? 1 : dir == 2 ? -1 : 0;
            my = dir == 1 ? 1 : dir == 3 ? -1 : 0;

            getAt(x, y).addObject(this);

            _gfx = rGfx.getBDExt(Game.generalGfxClass, dir * 24, 120, 24, 24);
        }

        override public function draw():void{
            Game.lGame.draw(_gfx, x, y);
        }

        override public function update():void{
            if (explosionTimer < 30)
                explosionTimer++;
            else if (explosionTimer == 30){
                new TExplosion(x, y, 1);
                var sx:uint = x + Game.lPart.scrollX;
                var sy:uint = y + Game.lPart.scrollY;
                for (var i:uint = 0; i < 24; i += 2) {
                    for (var j:uint = 0; j < 24; j += 2) {
                        Game.partPixel.add(x + i, y + j, gfx.getPixel32(i, j),
                            Math.min(UNumber.randomWaved(20, 11), UNumber.randomWaved(20, 11), UNumber.randomWaved(20, 11)),
                            UNumber.randomWaved(0, 400),UNumber.randomWaved(0, 400));
                    }
                }

                Sfx.explosion();

                _gfx = rGfx.getBDExt(Game.generalGfxClass, 96 + dir * 24, 120, 24, 24);

                explosionTimer++;
            } else if (explosionTimer < 50)
                explosionTimer++;
            else{
                nullifyDefault();
            }
        }

        override public function movedInto(object:TGameObject, tx:int, ty:int):void{
            if (object is TPlayer && explosionTimer == 0){
                explosionTimer = 1;
                addDefault();
                THelp.event(THelp._CANNONROLLOVER);
                Sfx.cannonAlarm();
            }
        }

        override public function touched(object:TGameObject):void{
            if (object is TPlayer && explosionTimer >= 30 && explosionTimer < 50){
                object.kill();

            } else if (object is TBullet && bitmapCollision(object) && explosionTimer < 30){
                if (explosionTimer == 0)
                    addDefault();

                object.kill();
                explosionTimer = 30;
            }
        }

        override public function toggle():void{
            isAlternate = !isAlternate;
        }

        public function fireBullet():void{
            if (explosionTimer < 30){
                new TBullet(x, y, mx, my, false);
                Sfx.cannon();
            }
        }
    }
}