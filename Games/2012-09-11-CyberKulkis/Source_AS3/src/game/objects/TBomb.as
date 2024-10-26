package game.objects{
    import flash.display.BitmapData;

    import game.effects.TEffectBlinkFade;
    import game.effects.TEffectFade;
    import game.global.Game;
    import game.global.Sfx;

    import net.retrocade.camel.core.rGfx;

    public class TBomb extends TGameObject{
        private var gfxCore:BitmapData

        private var rotation:Number = 0;
        private var rotationDelta:Number = 0;

        public function TBomb(x:uint, y:uint, isAlternate:Boolean){
            this.isAlternate = isAlternate;

            _x = x;
            _y = y;

            getAt(x, y).addObject(this);

            _gfx = rGfx.getBDExt(Game.generalGfxClass, 312, 120, 24, 24);
            gfxCore = rGfx.getBDExt(Game.generalGfxClass, 288, 120, 24, 24);

            rotation = Math.random() * 360;
            rotationDelta = Math.random() * 8;
        }

        override public function draw():void{
            Game.lGame.drawAdvanced(_gfx, x, y, rotation += rotationDelta);
            Game.lGame.draw(gfxCore, x, y);
        }

        override public function touched(object:TGameObject):void{
            if (bitmapCollision(object)){
                if (object is TPlayer)
                    new TEffectBlinkFade(object.gfx, object.preciseX, object.preciseY, object.mx, object.my, 6);

                object.kill();
                kill();
                Sfx.explosion();

                new TExplosion(x, y, 0);
            }
        }

        override public function toggle():void{
            isAlternate = !isAlternate;
        }
    }
}