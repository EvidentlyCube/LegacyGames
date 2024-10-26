package game.states{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.events.TextEvent;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;

    import game.global.Game;
    import game.global.Level;
    import game.global.LevelManager;
    import game.global.Make;
    import game.global.Score;
    import game.global.Sfx;
    import game.tiles.TTile;
    import game.windows.TWinBlocker;
    import game.windows.TWinCredits;
    import game.windows.TWinLevelSelect;
    import game.windows.TWinOptions;

    import net.retrocade.camel.animations.rAnimGravitated;
    import net.retrocade.camel.animations.rAnimSprite;
    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rDisplay;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rSave;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.core.rState;
    import net.retrocade.camel.core.rTooltip;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.core.retrocamel_int;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.effects.rEffQuake;
    import net.retrocade.camel.effects.rEffVolumeFade;
    import net.retrocade.camel.layers.rLayerSprite;
    import net.retrocade.camel.objects.rObject;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.UGraphic;
    import net.retrocade.utils.UNumber;
    import net.retrocade.utils.UString;

    public class TStateTitle extends rState{
        [Embed(source="/../assets/gfx/cyberix_logo_blob.png")] public static var __logo_blob__:Class;
        [Embed(source="/../assets/gfx/cyberix_logo_casual.png")] public static var __logo_casual__:Class;
        [Embed(source="/../assets/gfx/cyberix_logo_cpu.png")] public static var __logo_cpu__:Class;
        [Embed(source="/../assets/gfx/cyberix_logo_inca.png")] public static var __logo_inka__:Class;
        [Embed(source="/../assets/gfx/cyberix_logo_medieval.png")] public static var __logo_medieval__:Class;
        [Embed(source="/../assets/gfx/cyberix_logo_moon.png")] public static var __logo_moon__:Class;


        private static var _instance:TStateTitle;
        public static function get instance():TStateTitle{
            if (!_instance) {
                _instance = new TStateTitle();
            }
            return _instance;
        }

        private var bg   :Bitmap;
        private var logo :Bitmap;
        private var start:Button;
        private var select:Button;
        private var credits:Button;
        private var options:Button;
        private var changeLevelset:Button;


        public function TStateTitle() {
            rAnimGravitated.blitLayer = Game.lGame;

            logo    = new (TStateTitle['__logo_' + Game.gameMode + '__']);
            bg      = rGfx.getB(TStatePreload._border_);
            start   = Make().button(onStart,   "Start", 310);
            select  = Make().button(onSelect,  "Select Level", 310);
            credits = Make().button(onCredits, 'Credits', 150);
            options = Make().button(onOptions, 'Options', 150);
            changeLevelset = Make().button(onChangeLevelset, 'Change Levelset', 310);

            logo.x = (S().gameWidth - logo.width) / 2;
            logo.y = logo.x;

            start .alignCenter();
            select.alignCenter();
            credits.x = S().gameWidth / 2 - credits.width - 5;
            options.x = S().gameWidth / 2 + 5;
            changeLevelset.alignCenter();

            start  .y = logo.y + logo.height + 65;
            select .y = start.bottom + 5
            options.y = select.bottom + 20;
            credits.y = options.y;
            changeLevelset.y = options.bottom + 5;
        }

        override public function create():void{
            Game.lMain.add2(bg);
            Game.lMain.add2(logo);
            Game.lMain.add2(start);
            Game.lMain.add2(select);

            Game.lMain.add2(options);
            Game.lMain.add2(credits);
            Game.lMain.add2(changeLevelset);

            rSound.playMusic(Game.musicTitle, 0, 1000);
        }

        override public function destroy():void{
            Game.lMain.clear();
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: On Start
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private function onStart():void{
            new rEffVolumeFade(false, 500);
            new rEffFadeScreen(1, 0, 0, 500, onStartFadeFinish);
            Sfx.click();
        }

        private function onStartFadeFinish():void{
            new rEffVolumeFade(true, 500);
            //TStateIntro.instance.set();
            TStateGame.instance.set();
            LevelManager.startGame();
            rSound.playMusic(Game.music, 0, 1000);
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: On Select
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private function onSelect():void{
            TWinLevelSelect.show();
            Sfx.click();
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: On Continue
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private function onAltClicked(data:Button):void{
            Sfx.click();
            navigateToURL(new URLRequest(data.data.url), "_blank");
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: On Options
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private function onOptions():void{
            var win:rWindow = new TWinOptions();
            win.show();

            Sfx.click();
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: On Credits
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private function onCredits():void {
            TWinCredits.instance.show();

            Sfx.click();
        }

        private function onChangeLevelset(): void {
            switch(Game.gameMode) {
                case 'blob': Game.gameMode = 'casual'; break;
                case 'casual': Game.gameMode = 'cpu'; break;
                case 'cpu': Game.gameMode = 'inka'; break;
                case 'inka': Game.gameMode = 'medieval'; break;
                case 'medieval': Game.gameMode = 'moon'; break;
                case 'moon': Game.gameMode = 'blob'; break;
                default: Game.gameMode = 'casual'; break;
            }

            var logoParent:* = logo.parent;
            if (logoParent) {
                logoParent.removeChild(logo);
            }

            logo    = new (TStateTitle['__logo_' + Game.gameMode + '__']);
            logo.x = (S().gameWidth - logo.width) / 2;
            logo.y = logo.x;
            if (logoParent) {
                logoParent.addChild(logo);
            }
        }
    }
}