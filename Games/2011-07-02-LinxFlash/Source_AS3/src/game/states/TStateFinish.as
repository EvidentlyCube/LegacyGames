package game.states{
    import flash.display.Sprite;
    import flash.filters.ColorMatrixFilter;
    import flash.media.Sound;
    import flash.media.SoundChannel;

    import game.global.Game;
    import game.global.Make;
    import game.global.Pre;
    import game.global.Score;
    import game.objects.TBackground;
    import game.objects.THud;
    import game.windows.TWinCompleted;

    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rDisplay;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.core.rState;
    import net.retrocade.camel.core.retrocamel_int;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.standalone.Bitext;
    import net.retrocade.utils.Key;
    import net.retrocade.utils.UDisplay;

    public class TStateFinish extends rState{

        [Embed(source="/../assets/gfx/by_cage/trophy2.png")] public static var _trophy_:Class;;

        private static var _instance:TStateFinish = new TStateFinish();
        public static function get instance():TStateFinish{
            return _instance;
        }

        private static var _colors:Array = [0xFF0000, 0xFFFF00, 0x00FF00, 0x0000FF, 0xFF00FF, 0x00FFFF, 0xFFFFFF];


        private var music  :Sound;
        private var trophy :Sprite;
        private var channel:SoundChannel;

        private var state:uint = 0;

        private var colorer:ColorMatrix;
        private var filter :ColorMatrixFilter;
        private var filterArray:Array;

        private var _bg:TBackground;

        private var _txt:Bitext;
        private var _txt2:Bitext;

        public function TStateFinish(){
            music  = new (Game._music_ending_);
            trophy = UDisplay.wrapInSprite(rGfx.getB(_trophy_));
            trophy.scaleX = trophy.scaleY = 2;

            colorer = new ColorMatrix();
            filter  = new ColorMatrixFilter(colorer);
            filterArray = [filter];

            _bg = new TBackground(rGfx.getBD(Pre._bg_), Game.lBG, 0, 0);

            _txt = Make().text(_("CONGRATULATIONS!"), 0xFFFFFF, 4);
            _txt.texture = Make().textTexture([0x66FF66, 0x66FFFF], [1,1], [0, 255], 40);
            _txt.addShadow();
            _txt.x = (S().gameWidth - _txt.width) / 2;
            _txt.y = S().gameHeight - _txt.height - 5;

            _txt2 = Make().text(_("Hit any key to continue!"), 0xFFFFFF, 2);
            _txt2.texture = Make().textTexture([0x66FF66, 0x66FFFF], [1,1], [0, 255], 40);
            _txt2.addShadow();
            _txt2.x = (S().gameWidth - _txt2.width) / 2;
            _txt2.y = S().gameHeight - _txt2.height;
        }

        override public function create():void{
            _defaultGroup = Game.gAll;
            rSound.stopMusic();

            rSound.playMusic(music, 0, 1000);

            state = 0;

            Game.lMain.add2(trophy);

            trophy.alpha = 0;

            colorer.adjustHue(0);
        }

        override public function destroy():void {
            _defaultGroup.clear();

            Game.lBG  .clear();
            Game.lGame.clear();
            Game.lMain.clear();
        }


        private var lolo:Number = 0;
        private var lolo2:uint = 0;
        override public function update():void{
            Game.lBG.clear();
            Game.lGame.clear();

            switch(state){
                case(0):
                    if (rSound.musicPosition >= 6780 || rInput.isKeyHit(Key.SPACE)){
                        state = 1;
                        new rEffFadeScreen(0, 1, 0, 500);
                        trophy.alpha = 1;
                        Game.lMain.add2(_txt);
                    }
                    break;

                case(1):
                    if (rSound.musicPosition > 10000){
                        state = 2;
                        Game.lMain.add2(_txt2);
                    }

                case(2):
                    if ((rInput.isAnyKeyDown() || rInput.isMouseDown) && rSound.musicPosition > 10000){
                        state = 3;
                        new TWinCompleted();
                    }
                    _txt2.visible = rSound.musicPosition % 555 < 555 / 2;

                case(3):
                    trophy.x = Math.sin(rSound.musicPosition * Math.PI / 573) * 70 + 80;
                    trophy.y = 90 - Math.abs(Math.cos(rSound.musicPosition * Math.PI / 835) * 80);

                    _txt.x = (S().gameWidth - _txt.width) / 2 - Math.cos((rSound.musicPosition * 2) * Math.PI / 835 + Math.PI / 2 ) * 20;
                    _txt.y = S().gameHeight - _txt.height - 12 - Math.abs(Math.cos((rSound.musicPosition * 2) * Math.PI / 835 + Math.PI) * 10);

                    colorer.adjustHue(rSound.musicPosition / 30000);
                    filter.matrix = colorer;
                    trophy.filters = filterArray;

                    colorer.adjustHue(rSound.musicPosition / 27143);
                    filter.matrix = colorer;
                    _txt.filters = filterArray;

                    _bg.xspeed = (rInput.mouseX - S().gameWidth / 2) / 100;
                    _bg.yspeed = (rInput.mouseY - S().gameHeight / 2) / 100;

                    _bg.xspeed = Math.cos(rSound.musicPosition / 1541) * 2;
                    _bg.yspeed = Math.sin(rSound.musicPosition / 1937) * 2;

                    _bg.update();

                    if (Math.random() < 0.05){
                        Game.partFireworks.explode(Math.random() * S().gameWidth / 2,
                            Math.random() * S().gameHeight / 2, _colors[Math.random() * 6]);
                    }

                    break;

            }

            //6780
        }
    }
}