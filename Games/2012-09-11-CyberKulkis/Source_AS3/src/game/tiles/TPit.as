package game.tiles{
    import game.effects.TEffectFade;
    import game.global.Game;
    import game.objects.TCrate;
    import game.objects.TGameObject;
    import game.objects.TPlayer;

    import net.retrocade.camel.core.rGfx;

    public class TPit extends TGameObject{
        public function TPit(x:uint, y:uint, isAlternate:Boolean){
            this.isAlternate = isAlternate;

            _x = x;
            _y = y;

            getAt(x, y).addObject(this);

            _gfx = rGfx.getBDExt(Game.generalGfxClass, 216, 48, 24, 24);
        }

        override public function draw():void{
            Game.lGame.draw(_gfx, x, y);
        }

        override public function movedInto(object:TGameObject, tx:int, ty:int):void{
            if (object is TPlayer){
                object.kill();
                new TEffectFade(object.gfx, object.x, object.y, 0, 0);

            } else if (object is TCrate){
                new TEffectFade(object.gfx, object.x, object.y, 0, 0);

                setFloor(object as TCrate);
                object.kill();
                kill();
            }
        }

        private function setFloor(crate:TCrate):void{
            getAt(x, y).setFloorBitmapData(crate.getFloorGraphic());
        }

        override public function toggle():void{
            isAlternate = !isAlternate;
        }
    }
}