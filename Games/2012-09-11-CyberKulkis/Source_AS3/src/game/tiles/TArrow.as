package game.tiles{
    import game.global.Game;
    import game.objects.TBullet;
    import game.objects.TGameObject;
    import game.objects.TPlayer;

    import net.retrocade.camel.core.rGfx;

    public class TArrow extends TGameObject{
        public static var BLOCKS:Array = [ [0], [1], [4], [3], [1, 0], [1, 4], [4, 3], [3, 0], [0, 4], [1, 3] ];

        private var type:uint;

        public function TArrow(x:uint, y:uint, type:uint, isAlternate:Boolean){
            this.isAlternate = isAlternate;
            this.type        = type;

            _x = x;
            _y = y;

            getAt(x, y).addObject(this);

            _gfx = rGfx.getBDExt(Game.generalGfxClass, type * 24, 0, 24, 24);
        }

        override public function draw():void{
            if (!isAlternate)
                Game.lGame.draw(_gfx, x, y);
        }

        override public function enters(object:TGameObject, tx:int, ty:int):Boolean{
            if ((BLOCKS[type] as Array).indexOf(tx * 2 + ty + 2) != -1 && !(object is TBullet)){
                object.stop();
                return false;
            }

            return true;
        }

        override public function toggle():void{
            isAlternate = !isAlternate;
        }
    }
}