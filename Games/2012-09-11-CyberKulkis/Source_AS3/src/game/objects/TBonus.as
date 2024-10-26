package game.objects{
    import flash.display.BitmapData;

    import game.global.Game;
    import game.global.Score;
    import game.global.Sfx;

    import net.retrocade.camel.core.rGfx;

    public class TBonus extends TGameObject{
        public function TBonus(x:uint, y:uint, tx:uint, ty:uint, isAlternate:Boolean){
            this.isAlternate = isAlternate;

            _x = x;
            _y = y;

            Score.bonusLeft.add(1);

            getAt(x, y).addObject(this);

            _gfx = rGfx.getBDExt(Game.generalGfxClass, tx, ty, 24, 24);
        }

        override public function draw():void{
            Game.lGame.draw(_gfx, x, y);
        }

        override public function movedInto(object:TGameObject, tx:int, ty:int):void{
            if (bitmapCollision(object) && object is TPlayer){
                kill();
                Score.bonusLeft.add(-1);
                Sfx.eat();

                THelp.event(THelp._BONUS);
            }
        }

        override public function toggle():void{
            isAlternate = !isAlternate;
        }
    }
}