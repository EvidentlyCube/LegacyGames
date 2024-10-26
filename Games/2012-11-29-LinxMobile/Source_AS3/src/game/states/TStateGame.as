package game.states{

    import flash.display.BitmapData;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.media.Sound;
    import flash.ui.Keyboard;
    import flash.utils.ByteArray;

    import game.data.TBase;
    import game.global.Game;
    import game.global.Level;
    import game.global.Minimap;
    import game.global.newTutorial.NewTutorial;
    import game.global.tutorial.TTutorial;
    import game.mobiles.rMobileState;
    import game.objects.TConnector;
    import game.objects.TGameObject;
    import game.objects.THud;
    import game.tiles.TTileFloor;
    import game.windows.TWinPause;

    import net.retrocade.camel.engines.tilegrid.rTileGrid;
    import net.retrocade.camel.global.rEvents;
    import net.retrocade.camel.global.rWindows;
    import net.retrocade.camel.global.rSfx;
    import net.retrocade.utils.Key;
    import net.retrocade.camel.effects.rEffVolumeFade;

    import starling.display.Image;

    public class TStateGame extends rMobileState{
        private static var _instance:TStateGame = new TStateGame();
        public static function get instance():TStateGame{
            return _instance;
        }





        override public function create():void{
            super.create();

            _defaultGroup = Game.gAll;

            Game.lMain.alpha = 0;

            Main.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);

            SmartTouch.hook();

            Minimap.instance.minimapScrolled();

            Game.lMinimap.alpha = 1;

            NewTutorial.init();
        }

        override protected function resized(e:Event):void{
            Minimap.instance.reset();

            //Game.lStarling.starlingSprite.scaleX = S().gameScale;
            //Game.lStarling.starlingSprite.scaleY = S().gameScale;

            if (Gfx.isSmall != S().useSmallTileset){
                var reset:Function = function():void{
                    if (this && this is TConnector)
                        TConnector(this).resetGfx();
                };

                Level.groupBases.callOnAll(reset);
                Level.groupPaths.callOnAll(reset);
            }

            Game.lStarling.starlingSprite.scaleX = 1;
            Game.lStarling.starlingSprite.scaleY = 1;

            Game.lStarling.starlingSprite.x = (S().gameWidth - S().hudThickness - Game.lStarling.starlingSprite.width) / 2 + S().hudThickness| 0;
            Game.lStarling.starlingSprite.y = (S().gameHeight - Game.lStarling.starlingSprite.height) / 2 | 0;

            for (var i:int = 0, l:int = Game.lStarling.numChildren(); i < l; i++){
                var child:TGameObject = Game.lStarling.getChildAt(i) as TGameObject;

                child.reposition();
            }

            redrawAll();
        }

        override public function destroy():void {
            _defaultGroup.clear();

            THud.instance.unhook();

            Game.lGame.clear();
            Game.lMain.clear();

            Main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);

            Level.clearLevel();

            Game.lMinimap.alpha = 0;

            super.destroy();
        }

        private var _musicID:uint = 1;

        override public function update():void {
            if (!rSfx.musicIsPlaying()){
                rSfx.playMusic(Game.getMusic(Game['_music_tune_' + _musicID + '_']), 100);
                new rEffVolumeFade(true, 250);
                _musicID = (_musicID) % 3 + 1;
            }

            NewTutorial.update();

            Game.gAll.update();

            THud.instance.update();
			TTutorial.update();
            rEvents.clear();
        }

        public function redrawAll():void{
            Game.lGame.clear();

            Level.groupBases.update();
            Level.groupPaths.update();
            Level.groupOtherTiles.update();
        }

        private function onKeyDown(e:KeyboardEvent):void{
            if (rWindows.pauseGame)
                return;

            e.preventDefault();
            e.stopImmediatePropagation();

            if (e.keyCode == Keyboard.BACK)
                TWinPause.instance.show();
        }
    }
}