package game.objects{
    import flash.display.BitmapData;

    import game.effects.TEffectBlinkFade;
    import game.global.Game;
    import game.global.Sfx;

    import net.retrocade.camel.core.rGfx;

    public class TBullet extends TGameObject{
        public function TBullet(x:uint, y:uint, dx:int, dy:int, isAlternate:Boolean){
            this.isAlternate = isAlternate;

            _x = x;
            _y = y;

            mx = dx;
            my = dy;

            addDefault();
            getAt(x, y).addObject(this);

            _gfx = rGfx.getBDExt(Game.generalGfxClass, 216, 144, 24, 24);

            if (!movementWait && !move(mx, my, true))
                kill();

            movementWait = 3;
        }

        override public function update():void{
            super.update();

            if (!movementWait && !move(mx, my, true)){
                kill();
                Sfx.bullet();
            }

            getAt(x, y).touched(this);
        }

        override public function touched(object:TGameObject):void{
            if (bitmapCollision(object) && object is TPlayer){
                object.kill();
                new TEffectBlinkFade(object.gfx, object.preciseX, object.preciseY, object.mx, object.my, 4);
            }
        }

        override public function toggle():void{
            isAlternate = !isAlternate;
        }

        override public function stop():void{
            super.stop();
            kill();
            Sfx.bullet();
        }
    }
}