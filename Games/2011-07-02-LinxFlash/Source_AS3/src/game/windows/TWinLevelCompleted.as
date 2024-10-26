package game.windows{
    import game.global.Level;
    import game.global.Make;
    import game.global.Score;
    import game.states.TStateLevelSelect;

    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.easings.exponentialOut;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.effects.rEffMove;
    import net.retrocade.camel.effects.rEffVolumeFade;
    import net.retrocade.standalone.Bitext;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;

    public class TWinLevelCompleted extends rWindow{
        private static var _instance:TWinLevelCompleted = new TWinLevelCompleted();

        public static function get instance():TWinLevelCompleted{
            return _instance;
        }



        private var bg:Grid9;
        private var message      :Bitext;
        private var buttonNext   :Button;
        private var buttonRestart:Button;
        private var buttonReturn :Button;

        public function TWinLevelCompleted(){
            message = Make().text(_("Level completed!"), 0xFFFFFF, 3);

            buttonNext    = Make().button(onButtonNext,    _("playNext"));
            buttonRestart = Make().button(onButtonRestart, _("restart"));
            buttonReturn  = Make().button(onButtonReturn,  _("returnToSelection"));

            bg = Grid9.getGrid('windowBG');

            addChild(bg);
            addChild(message);
            addChild(buttonNext);
            addChild(buttonRestart);
            addChild(buttonReturn);

            buttonNext   .y = 60;
            buttonRestart.y = 110;
            buttonReturn .y = 160;

            bg.innerY      = 42;
            bg.innerWidth  = width;
            bg.height      = buttonReturn.y + buttonReturn.height + 15;

            message      .x = (width - message      .width) / 2 | 0;
            buttonNext   .x = (width - buttonNext   .width) / 2 | 0;
            buttonRestart.x = (width - buttonRestart.width) / 2 | 0;
            buttonReturn .x = (width - buttonReturn .width) / 2 | 0;

            center();
        }

        override public function show():void{
            super.show();

            center();

            y -= 150;

            (new rEffMove(this, x, y + 150, 500)).easing = exponentialOut;
            new rEffFade(this, 0, 1, 500);

            mouseEnabled = mouseChildren = true;
        }

        private function onButtonNext():void {
            mouseEnabled = mouseChildren = false;

            new rEffFade(this, 1, 0, 350);
            new rEffFadeScreen(1, 0, 0, 500, onFinishNext);
        }

        private function onButtonRestart():void{
            mouseEnabled = mouseChildren = false;

            new rEffFade(this, 1, 0, 500, onFinishRestart);
        }

        private function onButtonReturn():void{
            new rEffFade(this, 1, 0, 350);
            new rEffFadeScreen(1, 0, 0, 500, onFinishReturn);

            mouseEnabled = mouseChildren = false;

            new rEffVolumeFade(false, 400, function():void{rSound.stopMusic();});
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Effect Callbacks
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private function onFinishNext():void {
            close();
            Level.continueGame(Score.level.get());
        }

        private function onFinishRestart():void {
            close();
            Level.clearPaths();
            Level.levelLocked = false;
        }

        private function onFinishReturn():void{
            close();
            TStateLevelSelect.instance.set();
        }
    }
}