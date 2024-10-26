package game.windows{
    import flash.events.Event;
    
    import game.global.Game;
    import game.global.Level;
    import game.global.Make;
    import game.global.Score;
    import game.global.Sfx;
    import game.mobiles.MobileButton;
    import game.mobiles.rMobileWindow;
    import game.objects.TCursor;
    import game.states.TStateLevelSelect;
    
    import net.retrocade.camel.easings.exponentialOut;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.effects.rEffMove;
    import net.retrocade.camel.effects.rEffMusicFade;
    import net.retrocade.camel.global.rSfx;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    
    public class TWinLevelCompleted extends rMobileWindow{
        private static var _instance:TWinLevelCompleted = new TWinLevelCompleted();
        
        public static function get instance():TWinLevelCompleted{
            return _instance;
        }
        
        
        
        private var bg:Grid9;
        private var message      :Text;
        private var buttonNextUncompleted   :MobileButton;
        private var buttonNextAll   :MobileButton;
        private var buttonRestart:MobileButton;
        private var buttonReturn :MobileButton;
        
        private var disableButtons:Boolean = false;
        
        public function TWinLevelCompleted(){
            this._pauseGame = true;
            
            message = Make().textCaps(_("Level completed!"), 0xFFFFFF, 48, 8);
            message.filters = Game.FILTER_SHADOW;
            
            buttonNextUncompleted = Make().button(onButtonNextUncompleted,    "Play next uncompleted level");
            buttonNextAll         = Make().button(onButtonNextAny,    "Play next level");
            buttonRestart         = Make().button(onButtonRestart, _("restart"));
            buttonReturn          = Make().button(onButtonReturn,  _("returnToSelection"));
            
            bg = Grid9.getGrid('windowBG');
            
            addChild(bg);
            addChild(message);
            
            addChild(buttonNextUncompleted);
            
            addChild(buttonNextAll);
            addChild(buttonRestart);
            addChild(buttonReturn);
            
            buttonNextUncompleted.y = message.bottom + 15 | 0;
            buttonNextAll        .y = buttonNextUncompleted.bottom + 5 | 0;
            
            buttonRestart        .y = buttonNextAll   .bottom + 5  | 0;
            buttonReturn         .y = buttonRestart.bottom + 5  | 0;
            
            bg.width  = width + 20;
            
            center();
        }
        
        override public function show():void{
            disableButtons = true;
            
            super.show();
            
            if (Score.countCompleted() < S().totalLevels){
                buttonNextUncompleted.visible = true;
                buttonNextUncompleted.y = message.bottom + 15 | 0;
                buttonNextAll        .y = buttonNextUncompleted.bottom + 5 | 0;
            } else {
                buttonNextUncompleted.visible = false;
                buttonNextAll        .y = message.bottom + 15 | 0;
            }
            
            buttonRestart        .y = buttonNextAll   .bottom + 5  | 0;
            buttonReturn         .y = buttonRestart.bottom + 5  | 0;
            
            message      .alignCenterParent();
            buttonNextUncompleted   .alignCenterParent();
            buttonNextAll   .alignCenterParent();
            buttonRestart.alignCenterParent();
            buttonReturn .alignCenterParent();
            
            bg.height = buttonReturn.bottom + 10;
            
            center();
            
            
            new rEffFade(this, 0, 1, 500, function():void{disableButtons = false;});
            
            mouseEnabled = mouseChildren = true;
        }
        
        override protected function resized(e:Event):void{
            center();
        }

        private function onButtonNextUncompleted():void {
            if (disableButtons)
                return;
            
            Sfx.sfxClick.play();
            
            disableButtons = true;
            
            Score.level.set(Score.getNextUncompletedLevel(Score.level.get() - 1) + 1);
            
            mouseEnabled = mouseChildren = false;
            
            new rEffFade(this, 1, 0, 400);
            new rEffFade(Game.lGame.displayObject, 1, 0, 400);
            new rEffFade(Game.lMain.displayObject, 1, 0, 400, onFinishNextUncompleted);
        }
        
        private function onButtonNextAny():void {
            if (disableButtons)
                return;
            
            Sfx.sfxClick.play();
            
            disableButtons = true;
            
            Score.level.set(Score.level.get() % S().totalLevels + 1);
            
            mouseEnabled = mouseChildren = false;
            
            new rEffFade(this, 1, 0, 400);
            new rEffFade(Game.lGame.displayObject, 1, 0, 400);
            new rEffFade(Game.lMain.displayObject, 1, 0, 400, onFinishNextAny);
        }
        
        private function onButtonRestart():void{
            if (disableButtons)
                return;
            
            Sfx.sfxClick.play();
            
            disableButtons = true;
            
            mouseEnabled = mouseChildren = false;
            
            new rEffFade(this, 1, 0, 500, onFinishRestart);
        }
        
        private function onButtonReturn():void{
            if (disableButtons)
                return;
            
            Sfx.sfxClick.play();
            
            disableButtons = true;
            
            new rEffFade(this, 1, 0, 400);
            new rEffFade(Game.lGame.displayObject, 1, 0, 400);
            new rEffFade(Game.lMain.displayObject, 1, 0, 400, onFinishReturn);
            
            mouseEnabled = mouseChildren = false;
            
            new rEffMusicFade(0, 400, NaN, function():void{rSfx.stopMusic();});
        }
        
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Effect Callbacks
        // ::::::::::::::::::::::::::::::::::::::::::::::
        
        private function onFinishNextUncompleted():void {
            close();
            Level.continueGame(Score.level.get());
        }
        
        private function onFinishNextAny():void {
            close();
            Level.continueGame(Score.level.get());
        }
        
        private function onFinishRestart():void {
            close();
            Level.clearPaths();
            Level.levelLocked = false;
            TCursor._undoHistory.length = 0;
        }
        
        private function onFinishReturn():void{
            close();
            TStateLevelSelect.instance.set();
        }
    }
}