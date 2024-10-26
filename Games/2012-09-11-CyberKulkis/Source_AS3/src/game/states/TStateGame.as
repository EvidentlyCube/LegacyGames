package game.states{
    import flash.display.BitmapData;
    import flash.system.System;
    import flash.utils.ByteArray;
    import flash.utils.getTimer;

    import game.global.Game;
    import game.global.Level;
    import game.global.LevelManager;
    import game.global.Score;
    import game.objects.TGameObject;
    import game.objects.TPlayer;
    import game.tiles.TTile;
    import game.windows.TWinFocusPause;
    import game.windows.TWinPause;

    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rEvents;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rGroup;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rState;
    import net.retrocade.camel.engines.tilegrid.rTileGrid;
    import net.retrocade.camel.objects.rScroller;
    import net.retrocade.utils.Key;
    import net.retrocade.utils.UNumber;

    public class TStateGame extends rState{
        private static var _instance:TStateGame = new TStateGame();
        public static function get instance():TStateGame{
            return _instance;
        }


        private var scrollX:Number = Math.random() * 600;
        private var scrollY:Number = Math.random() * 600;

        public var scrollXspeed:Number;
        public var scrollYspeed:Number;

        override public function create():void{
            _defaultGroup = Game.gAll;

            scrollXspeed = Math.random() - Math.random();
            scrollYspeed = Math.random() - Math.random();
        }

        public function resetBackgroundAnimation():void{
            scrollX = Math.random() * 600;
            scrollY = Math.random() * 600;

            scrollXspeed = Math.random() * 0.2 - Math.random() * 0.2;
            scrollYspeed = Math.random() * 0.2 - Math.random() * 0.2;
        }

        override public function destroy():void {
            _defaultGroup.clear();
            Game.lGame.clear();
            Game.lBG  .clear();
            Game.lMain.clear();
        }

        override public function update():void{
            if (rInput.isKeyHit(Key.ESCAPE) || rInput.isKeyHit(Key.P)){
                TWinPause.instance.show();
                return;
            }

            if (rInput.isKeyHit(Key.R)){
                LevelManager.restartLevel();
                return;
            }

            TTile  .hoveredTile = null;
            TPlayer.movedX      = 0;
            TPlayer.movedY      = 0;

            Game.lGame.clear();
            Game.lBG  .clear();

            scrollX += UNumber.modulo(scrollXspeed, 600);
            scrollY += UNumber.modulo(scrollYspeed, 600);

            var scrX:int = scrollX % 600;
            var scrY:int = scrollY % 600;

            var bd:BitmapData = rGfx.getBD(Level._bg_);

            Game.lGame.drawImageRect(bd, scrX, scrY, 0,          0,          600 - scrX, 600 - scrY);
            Game.lGame.drawImageRect(bd, 0,    scrY, 600 - scrX, 0,          scrX,       600 - scrY);
            Game.lGame.drawImageRect(bd, scrX, 0,    0,          600 - scrY, 600 - scrX, scrY);
            Game.lGame.drawImageRect(bd, 0,    0,    600 - scrX, 600 - scrY, scrX,       scrY);

            Level.active .update();

            for each(var i:TGameObject in Level.level.getArray()){
                if (i)
                    i.draw();
            }

            if (TTile.hoveredTile)
                TTile.hoveredTile.mouseOver();

            Level.effects.update();

            if (rEvents.occured(C.E_MADE_MOVE)){
                Score.movesMade.add(1);
            }
        }
    }
}