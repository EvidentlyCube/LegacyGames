package game.tiles{
    import flash.utils.getTimer;

    import game.global.Game;
    import game.global.Sfx;
    import game.objects.TGameObject;
    import game.objects.THelp;
    import game.objects.TPlayer;

    import net.retrocade.camel.core.rGfx;

    public class TSwitch extends TGameObject{
        private var toggleType:Boolean;
        private var tiles:Array;

        private var switchFlipped:Boolean = false;

        public function TSwitch(x:uint, y:uint, isToggle:Boolean, nodes:XMLList, isAlternate:Boolean){
            this.isAlternate = isAlternate;
            toggleType = isToggle;

            _x = x;
            _y = y;

            getAt(x, y).addObject(this);

            tiles = new Array();
            for each(var i:XML in nodes){
                tiles.push(getAt(i.@x, i.@y));
            }

            _gfx = rGfx.getBDExt(Game.generalGfxClass, 264, 48, 24, 24);
        }

        override public function draw():void{
            if (!isAlternate)
                Game.lGame.draw(_gfx, x, y);
        }

        override public function movedInto(object:TGameObject, tx:int, ty:int):void{
            if (isAlternate)
                return;

            if (object is TPlayer)
                doSwitch();
        }

        private function doSwitch():void{
            if (!switchFlipped)
                _gfx = rGfx.getBDExt(Game.generalGfxClass, 288, 48, 24, 24);
            else
                _gfx = rGfx.getBDExt(Game.generalGfxClass, 264, 48, 24, 24);

            Sfx.switchPush();

            if (toggleType)
                THelp.event(THelp._SWITCHTILE);
            else
                THelp.event(THelp._SWITCHFIRE);

            switchFlipped = !switchFlipped;

            for each(var i:TTile in tiles){
                if (toggleType)
                    i.toggle();
                else
                    i.fireBullet();
            }
        }

        override public function toggle():void{
            isAlternate = !isAlternate;
        }

        override public function mouseOver():void{
            var i:TTile;

            if (toggleType){
                for each(i in tiles){
                    Game.lGame.drawLine(x + 12, y + 12, i.x + 12, i.y + 12, 0xFFFFFF00, 1, 2);

                    Game.lGame.drawRect(i.x,     i.y,     24, 24, 0xFFFFFF00);
                    Game.lGame.drawRect(i.x + 2, i.y + 2, 20, 20, 0xFF000000);

                    i.drawAlternate();
                }

                Game.lGame.drawRect(x,     y,     24, 24, 0xFFFFFF00);
                Game.lGame.drawRect(x + 2, y + 2, 20, 20, 0xFF000000);
                draw();

            } else {
                for each(i in tiles){
                    Game.lGame.drawLine(x + 12, y + 12, i.x + 12, i.y + 12, 0xFFFF0000, 1, 2);

                    Game.lGame.drawRect(i.x,     i.y,     24, 24, 0xFFFF0000);
                    Game.lGame.drawRect(i.x + 2, i.y + 2, 20, 20, 0xFF000000);

                    i.drawNoFloor();
                }

                Game.lGame.drawRect(x,     y,     24, 24, 0xFFFF0000);
                Game.lGame.drawRect(x + 2, y + 2, 20, 20, 0xFF000000);

                draw();
            }

            THelp.event(THelp._OVERSWITCH);
        }
    }
}