package game.objects{
    import flash.display.BitmapData;
    import flash.utils.getTimer;

    import game.global.Game;
    import game.global.Score;

    import net.retrocade.camel.core.rGfx;

    public class TCrate extends TGameObject{
        private var breakable:Boolean;
        private var slides   :Boolean;
        public function TCrate(x:uint, y:uint, tx:uint, ty:uint, breakable:Boolean, slides:Boolean){
            _x = x;
            _y = y;

            this.breakable = breakable;
            this.slides    = slides;

            Score.bonusLeft.add(1);

            addDefault();
            getAt(x, y).addObject(this);

            _gfx = rGfx.getBDExt(Game.generalGfxClass, tx, ty, 24, 24);
        }

        override public function update():void{
            super.update();
            if (slides && (mx != 0 || my != 0) && !movementWait)
                move(mx, my);
        }

        override public function enters(object:TGameObject, tx:int, ty:int):Boolean{
            if (object is TBullet)
                return false;

            if (object is TCrate && mx == -tx && my == -ty){
                stop();
                return false;
            }

            move(tx, ty);

            return false;
        }

        override public function touched(object:TGameObject):void{
            if (bitmapCollision(object))
                object.stop();
        }

        public function getFloorGraphic():BitmapData{
            return rGfx.getBDExt(Game.generalGfxClass, 168 + (!breakable ? 24 : 0) + (slides ? 48 : 0), 264, 24, 24);
        }
    }
}