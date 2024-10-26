package game.tiles{
    import game.global.Game;
    import game.global.Sfx;
    import game.objects.TGameObject;
    import game.objects.THelp;
    import game.objects.TPlayer;

    import net.retrocade.camel.core.rGfx;

    public class TBounce extends TGameObject{

        public static var TYPE_DIAG_TOPRIGHT:uint = 0;
        public static var TYPE_DIAG_TOPLEFT :uint = 1;
        public static var TYPE_VERT_LEFT    :uint = 2;
        public static var TYPE_VERT_RIGHT   :uint = 3;
        public static var TYPE_HORI_TOP     :uint = 4;
        public static var TYPE_HORI_BOTTOM  :uint = 5;

        private var type:uint;

        public function TBounce(x:uint, y:uint, type:uint, isAlternate:Boolean){
            this.isAlternate = isAlternate;
            this.type        = type;

            _x = x;
            _y = y;

            getAt(x, y).addObject(this);

            _gfx = rGfx.getBDExt(Game.generalGfxClass, type * 24, 48, 24, 24);
        }

        override public function draw():void{
            Game.lGame.draw(_gfx, x, y);
        }

        override public function leaves(object:TGameObject, tx:int, ty:int):Boolean{
            switch(tx * 2 + ty + 2){
                case(0): //left
                    if (type == TYPE_VERT_LEFT || (type < 2 && !object.isMoving))
                        bounce(object);
                    break;

                case(1): //up
                    if (type == TYPE_HORI_TOP || (type < 2 && !object.isMoving))
                        bounce(object);
                    break;

                case(3): //down
                    if (type == TYPE_HORI_BOTTOM || (type < 2 && !object.isMoving))
                        bounce(object);
                    break;

                case(4): //right
                    if (type == TYPE_VERT_RIGHT || (type < 2 && !object.isMoving))
                        bounce(object);
                    break;
            }

            return true;
        }

        override public function enters(object:TGameObject, tx:int, ty:int):Boolean{
            switch(tx * 2 + ty + 2){
                case(0): //left
                    if (type == TYPE_VERT_RIGHT)
                        bounce(object);
                    break;

                case(1): //up
                    if (type == TYPE_HORI_BOTTOM)
                        bounce(object);
                    break;

                case(3): //down
                    if (type == TYPE_HORI_TOP)
                        bounce(object);
                    break;

                case(4): //right
                    if (type == TYPE_VERT_LEFT)
                        bounce(object);
                    break;
            }

            return true;
        }

        override public function movedInto(object:TGameObject, tx:int, ty:int):void{
            if (type < 2)
                bounce(object);
        }

        private function bounce(object:TGameObject):void{
            var temp:int;

            Sfx.bounce();

            if (object is TPlayer)
                THelp.event(THelp._BOUNCED);

            if (type == TYPE_DIAG_TOPLEFT){
                temp = object.mx;
                object.mx = object.my;
                object.my = temp;

            } else if (type == TYPE_DIAG_TOPRIGHT){
                temp = object.mx;
                object.mx = -object.my;
                object.my = -temp;

            } else {
                object.mx *= -1;
                object.my *= -1;
            }
        }

        override public function toggle():void{
            isAlternate = !isAlternate;
        }
    }
}