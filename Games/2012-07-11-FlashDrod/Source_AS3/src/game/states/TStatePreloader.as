package game.states{
    import flash.display.Bitmap;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.Stage;
    import flash.filters.DropShadowFilter;
    import flash.filters.GlowFilter;

    import game.windows.TWindowLanguage;

    import net.retrocade.camel.core.rDisplay;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rState;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Rand;

    public class TStatePreloader extends rState {

        CF::holdKdd1{
            [Embed(source = "/../assets/gfx/ui/preloader_kdd1.png")] private static var _bgClass:Class;
        }

        CF::holdKdd2{
            [Embed(source = "/../assets/gfx/ui/preloader_kdd2.png")] private static var _bgClass:Class;
        }

        CF::holdKdd3{
            [Embed(source = "/../assets/gfx/ui/preloader_kdd3.png")] private static var _bgClass:Class;
        }

        private var getStage:Function;
        private var weirdLoad  :Function;
        private var doStartGame:Function;

        private var selectLanguageTxt:Text;
        private var selectLanguage:Button;

        private var loadingText:Text;

        private var background:Bitmap;

        private var startGameTxt:Text;
        private var startGame:Button;

        private var fakePercent:Number = 0;

        public function TStatePreloader(getStageFunction:Function, getWeirdLoadFunction:Function, doStartGame:Function) {
            this.getStage    = getStageFunction;
            this.doStartGame = doStartGame;
            this.weirdLoad   = getWeirdLoadFunction;

            background  = rGfx.getB(_bgClass);
            loadingText = new Text("", C.FONT_FAMILY, 48, 0xFFFFFF)

            loadingText.color = 0xFFFFFF;
            loadingText.filters = [ new GlowFilter(0, 1, 3, 3, 4), new DropShadowFilter(4, 45, 0, 1, 2, 2, 0.5) ];

            loadingText.alignCenter();
            loadingText.alignMiddle();

            startGameTxt = new Text("", C.FONT_FAMILY, 48, 0xFFFFFF)
            startGameTxt.text = _("prlStartGame");
            startGameTxt.color = 0xFFFFFF;
            startGameTxt.filters = [ new GlowFilter(0, 1, 3, 3, 4), new DropShadowFilter(4, 45, 0, 1, 2, 2, 0.5) ];

            startGame = new Button(onGameStart);
            startGame.addChild(startGameTxt);
            startGame.visible = false;

            selectLanguageTxt = new Text("", C.FONT_FAMILY, 48, 0xFFFFFF)
            selectLanguageTxt.text = _("prlLanguage");
            selectLanguageTxt.color = 0xFFFFFF;
            selectLanguageTxt.filters = [ new GlowFilter(0, 1, 3, 3, 4), new DropShadowFilter(4, 45, 0, 1, 2, 2, 0.5) ];

            selectLanguage = new Button(onSelectLanguage);
            selectLanguage.addChild(selectLanguageTxt);
            selectLanguage.visible = false;
        }

        override public function update():void {
            //if (isNaN(getProgress()) || getProgress() < 0 || getProgress() > 1)
            //    return;

            var stage   :Stage  = getStage();
            var progress:Number = (stage.loaderInfo.bytesLoaded / stage.loaderInfo.bytesTotal) * 100;

            fakePercent = Math.min(fakePercent + Rand.om * 0.4 + 0.1, progress);

            if (fakePercent < 1 || weirdLoad()) {
                if (weirdLoad())
                    loadingText.text = _("prlLoading", ((stage.loaderInfo.bytesLoaded / S.FILE_SIZE)* 100).toFixed(0));
                else
                    loadingText.text = _("prlLoading", (fakePercent * 100).toFixed(0));

                loadingText.visible = true;
                startGame.visible = false;
                selectLanguage.visible = false;

                loadingText.alignCenter();
                loadingText.alignMiddle();

                loadingText.y -= 47;

            } else {
                startGameTxt.text = _("prlStartGame");
                selectLanguageTxt.text = _("prlLanguage");

                loadingText.visible = false;
                startGame.visible = true;
                selectLanguage.visible = true;

                startGame.alignCenter();
                startGame.alignMiddle();

                startGame.y -= 97;
                selectLanguage.alignCenter();
                selectLanguage.y = startGame.bottom - 5;
            }
        }

        override public function create():void{
            Preloader.loaderLayer.add2(background);
            Preloader.loaderLayer.add2(loadingText);
            Preloader.loaderLayer.add2(startGame);
            Preloader.loaderLayer.add2(selectLanguage);

            new rEffFadeScreen(0, 1, 0, 800);
        }

        override public function destroy():void{
            Preloader.loaderLayer.clear();
        }

        private function onGameStart():void {
            startGame.mouseChildren = startGame.mouseEnabled = false;

            new rEffFadeScreen(1, 0, 0, 600, function():void {
                doStartGame();
            })
        }

        private function onSelectLanguage():void {
            new TWindowLanguage();
        }
    }
}