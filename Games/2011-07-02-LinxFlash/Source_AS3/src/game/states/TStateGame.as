package game.states{
    import flash.display.BitmapData;
    import flash.events.MouseEvent;
    import flash.media.Sound;
    import flash.utils.ByteArray;

    import game.data.TBase;
    import game.global.Game;
    import game.global.Level;
    import game.objects.THud;
    import game.windows.TWinFocusPause;
    import game.windows.TWinPause;

    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rGroup;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.core.rState;
    import net.retrocade.camel.effects.rEffVolumeFade;
    import net.retrocade.camel.engines.tilegrid.rTileGrid;
    import net.retrocade.utils.Key;

    public class TStateGame extends rState{
        private static var _instance:TStateGame = new TStateGame();
        public static function get instance():TStateGame{
            return _instance;
        }





        override public function create():void{
            _defaultGroup = Game.gAll;
        }

        override public function destroy():void {
            _defaultGroup.clear();

            THud.instance.unhook();

            Game.lBG  .clear();
            Game.lGame.clear();
            Game.lMain.clear();
        }

        private var _musicID:uint = 1;

        override public function update():void {
            // @TODO - Pause Menu on escape
            if (rInput.isKeyHit(Key.ESCAPE) || rInput.isKeyHit(Key.P)){
                TWinPause.instance.show();
                return;
            }

            if (!rSound.musicIsPlaying()){
                rSound.playMusic(Game.getMusic(Game['_music_tune_' + _musicID + '_']), 0, 0);
                new rEffVolumeFade(true, 250);
                _musicID = (_musicID) % 3 + 1;
            }



            Game.lGame.clear();

            Level.bases.update();
            Level.paths.update();

            Game.gAll.update();
        }
    }
}