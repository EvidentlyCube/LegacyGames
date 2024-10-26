package game.tiles{
    import flash.display.BitmapData;

    import game.global.Game;
    import game.global.Level;
    import game.objects.TGameObject;

    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rGroup;
    import net.retrocade.camel.core.rInput;

    public class TTile extends TGameObject{
        public static var hoveredTile:TTile;

        private var _floor  :BitmapData;
        private var _objects:rGroup;

        public function TTile(x:uint, y:uint){
            this.x = x;
            this.y = y;

            _objects = new rGroup();
            _objects.gcAdvanced  = true;
            _objects.gcThreshold = 5;
        }

        override public function draw():void{
            if (_floor)
                Game.lGame.draw(_floor, x, y);

            if (_objects.length)
                for each(var i:TGameObject in _objects.getAllOriginal()){
                    if (i && !i.isAlternate)
                        i.draw();
                }

            if (((rInput.mouseX - Level.levelDrawOffsetX) / 24 | 0) * 24 == x &&
                ((rInput.mouseY - Level.levelDrawOffsetY) / 24 | 0) * 24 == y)
                hoveredTile = this;
        }

        public function drawNoFloor():void{
            if (_objects.length)
                for each(var i:TGameObject in _objects.getAllOriginal()){
                    if (i && !i.isAlternate)
                        i.draw();
            }
        }

        public function drawAlternate():void{
            if (_objects.length)
                for each(var i:TGameObject in _objects.getAllOriginal()){
                    if (i && i.isAlternate)
                        i.draw();
                }
        }

        public function setFloor(tx:uint, ty:uint):void{
            _floor = rGfx.getBDExt(Game.generalGfxClass, tx, ty, 24, 24);
        }

        public function setFloorBitmapData(bd:BitmapData):void{
            _floor = bd;
        }

        public function addObject(object:TGameObject):void{
            _objects.add(object);
        }

        public function removeObject(object:TGameObject):void{
            _objects.nullify(object);
        }

        override public function enters(object:TGameObject, tx:int, ty:int):Boolean{
            for each(var i:TGameObject in _objects.getAllOriginal()){
                if (i && i != object && !i.isAlternate && i.enters(object, tx, ty) == false)
                    return false;
            }

            return true;
        }

        override public function leaves(object:TGameObject, tx:int, ty:int):Boolean{
            for each(var i:TGameObject in _objects.getAllOriginal()){
                if (i && i != object && !i.isAlternate && i.leaves(object, tx, ty) == false)
                    return false;
            }

            return true;
        }

        override public function touched(object:TGameObject):void{
            for each(var i:TGameObject in _objects.getAllOriginal()){
                if (i && i != object && !i.isAlternate)
                    i.touched(object);
            }
        }

        override public function movedInto(object:TGameObject, tx:int, ty:int):void{
            for each(var i:TGameObject in _objects.getAllOriginal()){
                if (i && i != object && !i.isAlternate)
                    i.movedInto(object, tx, ty);
            }
        }

        override public function toggle():void{
            _objects.callOfAll("toggle");
        }

        public function fireBullet():void{
            _objects.callOfAll("fireBullet");
        }

        override public function mouseOver():void{
            _objects.callOfAll("mouseOver");
        }
    }
}