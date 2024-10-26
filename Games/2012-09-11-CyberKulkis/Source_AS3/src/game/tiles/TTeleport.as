package game.tiles{
    import game.global.Game;
    import game.global.Sfx;
    import game.objects.TGameObject;
    import game.objects.THelp;
    import game.objects.TPlayer;

    import net.retrocade.camel.core.rGfx;

    public class TTeleport extends TGameObject{
        private static var disableTeleports:Boolean = false;

        private var targetX:uint;
        private var targetY:uint;

        public function TTeleport(x:uint, y:uint, targetX:uint, targetY:uint, isAlternate:Boolean){
            this.isAlternate = isAlternate;

            _x = x;
            _y = y;

            this.targetX = targetX;
            this.targetY = targetY;

            getAt(x, y).addObject(this);

            _gfx = rGfx.getBDExt(Game.generalGfxClass, 0, 96, 24, 24);
        }

        override public function draw():void{
            Game.lGame.draw(_gfx, x, y);
        }

        override public function movedInto(object:TGameObject, tx:int, ty:int):void{
            if (disableTeleports)
                return;

            Sfx.teleport();

            object.setPosition(targetX, targetY);
            disableTeleports = true;
            getAt(targetX, targetY).movedInto(object, tx, ty);
            disableTeleports = false;
        }

        override public function toggle():void{
            isAlternate = !isAlternate;
        }

        override public function mouseOver():void{
            var i:TTile = getAt(targetX, targetY);

            Game.lGame.drawLine(x + 12, y + 12, i.x + 12, i.y + 12, 0xFF8888FF, 1, 2);

            Game.lGame.drawRect(i.x,     i.y,     24, 24, 0xFF8888FF);
            Game.lGame.drawRect(i.x + 2, i.y + 2, 20, 20, 0xFF000000);

            i.drawNoFloor();

            Game.lGame.drawRect(x,     y,     24, 24, 0xFF8888FF);
            Game.lGame.drawRect(x + 2, y + 2, 20, 20, 0xFF000000);

            draw();

            THelp.event(THelp._OVERTELEPORT);
        }
    }
}