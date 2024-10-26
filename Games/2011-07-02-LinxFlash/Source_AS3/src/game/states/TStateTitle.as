package game.states{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.events.TextEvent;

    import game.global.Game;
    import game.global.Level;
    import game.global.Make;
    import game.global.Pre;
    import game.global.Score;
    import game.global.Sfx;
    import game.global.TStateOutro;
    import game.objects.TBackground;
    import game.objects.TRibbon;
    import game.windows.TWinCredits;
    import game.windows.TWinOptions;

    import net.retrocade.camel.animations.rAnimGravitated;
    import net.retrocade.camel.animations.rAnimSprite;
    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rSave;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.core.rState;
    import net.retrocade.camel.core.rTooltip;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.effects.rEffQuake;
    import net.retrocade.camel.effects.rEffVolumeFade;
    import net.retrocade.camel.layers.rLayerSprite;
    import net.retrocade.camel.objects.rObject;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.UGraphic;
    import net.retrocade.utils.UNumber;

    public class TStateTitle extends rState{
        [Embed(source="/../assets/gfx/by_cage/ui/title.png")] private var __logo__:Class;

        private static var _instance:TStateTitle = new TStateTitle();
        public static function get instance():TStateTitle{
            return _instance;
        }




        private var _logo:Bitmap;
        private var _start:Button;
        private var _options:Button;
        private var _credits:Button;

        private var _bg:TBackground;

        private var _state:uint = 0;

        private var _ribbon1:TRibbon;

        public function TStateTitle() {
            _logo    = new __logo__;

            _logo.scaleX = 2;
            _logo.scaleY = 2;

            _logo.x  = (S().gameWidth - _logo.width) / 2;
            _logo.y  = 10;

            _start    = Make().button(onStart,    _("Start Game"));
            _options  = Make().button(onOptions,  _("Options"));
            _credits  = Make().button(onCredits,  _("Credits"));

            _start.y = 271;

            _credits.x = (S().gameWidth - _credits.width) / 2 | 0;
            _credits.y = 324;

            _options.x = (S().gameWidth - _options.width) / 2 | 0;
            _options.y = 377;

            _bg = new TBackground(rGfx.getBD(Pre._bg_), Game.lBG, 0, 0);

            _ribbon1 = new TRibbon(90, -0.5, Game.lBG);
            _ribbon1.addItem(rGfx.getBDExt(Pre._ribbon_, 0, 0, 16, 16), 1);
            _ribbon1.addItem(rGfx.getBDExt(Pre._ribbon_, 16, 0, 16, 16), 1);
            _ribbon1.addItem(rGfx.getBDExt(Pre._ribbon_, 32, 0, 16, 16), 1);
            _ribbon1.addItem(rGfx.getBDExt(Pre._ribbon_, 48, 0, 16, 16), 1);
            _ribbon1.addItem(rGfx.getBDExt(Pre._ribbon_, 64, 0, 16, 16), 1);
            _ribbon1.addItem(rGfx.getBDExt(Pre._ribbon_, 80, 0, 16, 16), 1);
            _ribbon1.addItem(rGfx.getBDExt(Pre._ribbon_, 96, 0, 16, 16), 1);
            _ribbon1.addItem(rGfx.getBDExt(Pre._ribbon_, 112, 0, 16, 16), 1);
            _ribbon1.addItem(rGfx.getBDExt(Pre._ribbon_, 128, 0, 16, 16), 1);

            _ribbon1.farthestEdge = 0;
            _ribbon1.swayPower = 20;
            _ribbon1.swaySpeed = -Math.PI / 384;
            _ribbon1.swayOffset = Math.PI / 24;
            _ribbon1.swayPosition = 20;
            _ribbon1.addMany(20);
            _ribbon1.moveAll(S().gameWidth / -2);
        }

        override public function update():void {
            super.update();

            Game.lGame.clear();
            Game.lBG.clear();

            _bg.xspeed = (rInput.mouseX - S().gameWidth / 2) / 100;
            _bg.yspeed = (rInput.mouseY - S().gameHeight / 2) / 100;

            _bg.update();

            _ribbon1.update();
        }

        override public function create():void{
            Game.lMain.clear();

            Game.lMain.add2(_logo);
            Game.lMain.add2(_start);
            Game.lMain.add2(_credits);
            Game.lMain.add2(_options);

            _start.x = (S().gameWidth - _start.width) / 2 | 0;

            _logo    .alpha = 1;
            _start   .alpha = 1;
            _credits .alpha = 1;
            _options .alpha = 1;

            Game.lMain.mouseChildren = true;

            Game.lBG.draw(rGfx.getBD(Pre._bg_), 0, 0);

            new rEffFadeScreen(0, 1, 0, 500);

            _logo   .alpha = 0;
            _start  .visible = false;
            _credits.visible = false;
            _options.visible = false;

            new rEffFade(_logo, 0, 1, 1000, onLogoAppeared);

            if (!rSound.musicIsPlaying()){
                rSound.playMusic(Game.getMusic(Game._music_title_));
                new rEffVolumeFade(true, 500);
            }
        }

        override public function destroy():void{
            rTooltip.unhook(_start);

            Game.lMain.clear();
            _defaultGroup.clear();
        }


        private function onLogoAppeared():void{
            _start.visible = true;
            _credits.visible = true;
            _options.visible = true;

            new rEffFade(_start, 0, 1, 200);
            new rEffFade(_credits, 0, 1, 200);
            new rEffFade(_options, 0, 1, 200);
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: On Start
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private function onStart():void{
            new rEffFadeScreen(1, 0, 0, 500, onStartFadeFinish);
            Sfx.sfxClickPlay();
        }

        private function onStartFadeFinish():void{
            TStateLevelSelect.instance.set();
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: On Options
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private function onOptions():void{
            var win:rWindow = new TWinOptions();
            win.show();

            Sfx.sfxClickPlay();
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: On Credits
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private function onCredits():void {
            TWinCredits.instance.show();

            Sfx.sfxClickPlay();
        }
    }
}