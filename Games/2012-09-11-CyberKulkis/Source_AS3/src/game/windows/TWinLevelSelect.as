package game.windows{
    import game.global.LevelManager;
    import game.global.Make;
    import game.global.Score;
    import game.global.Sfx;
    import game.states.TStateGame;

    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rTooltip;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.easings.exponentialIn;
    import net.retrocade.camel.easings.exponentialOut;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.effects.rEffMove;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Key;
    import net.retrocade.utils.UString;

    public class TWinLevelSelect extends rWindow{
        private static var _instance:TWinLevelSelect = new TWinLevelSelect();

        public static function show():void{
            _instance.show();
        }



        private var bg   :Grid9;
        private var title:Text;
        private var help1:Text;
        private var help2:Text;
        private var help3:Text;

        private var levels:Array = [];

        private var closer:Button;

        private var levelStartTemp:uint = 0;

        public function TWinLevelSelect(){
            bg = Grid9.getGrid("window");
            title = new Text("Please select a level:", "font", 22);
            help1 = new Text(_("legendRED"), "font", 18);
            help2 = new Text(_("legendGREEN"), "font", 18);

            closer = Make().button(onClose, _("Close"));

            addChild(bg);
            addChild(title);
            addChild(help1);
            addChild(help2);
            addChild(closer);

            help1.y = 50;
            help2.y = help1.y + help1.height + 5;

            for(var i:uint = 0; i < 20; i++){
                var level:Button = Make().button(onLevelClick, (i + 1).toString(), 50);
                level.data.txt.x -= 0;

                level.data.id = i;

                level.x = (i % 5) * 60 + 60;
                level.y = (i / 5 | 0) * 50 + help2.y + help2.height + 10;

                addChild(level);
                levels.push(level);
            }

            closer.y = level.y + level.height + 10;

            bg.width = 400;
            bg.height = closer.y + closer.height + 10;

            title .x = (width - title .width) / 2 | 0;
            help1 .x = (width - help1 .width) / 2 | 0;
            help2 .x = (width - help2 .width) / 2 | 0;
            closer.x = (width - closer.width) / 2 | 0;

            help1.color = 0xFF4444;
            help2.color = 0x00FF00;

            help1.setShadow();
            help2.setShadow();
            title.setShadow();

            center();

            updateLevels();
        }

        private function updateLevels():void{
            for each(var i:Button in levels){
                var id:uint = i.data.id;

                if (Score.isCompleted(id)){
                    i.data.txt.color = 0x00FF00;
                    i.refresh()

                    rTooltip.hook(i,
                        "Steps: " + Score.getLevelSteps(id)+"\n" +
                        "Time: " + UString.styleTime(Score.getLevelTime(id), true, true, true, false)) + "\n";

                } else {
                    rTooltip.unhook(i);
                    i.data.txt.color = 0xFF4444;
                }
            }
        }

        private function onLevelClick(data:Button):void{
            levelStartTemp = data.data.id;

            mouseEnabled  = false;
            mouseChildren = false;

            new rEffFade(this, 1, 0, 500);
            new rEffFadeScreen(1, 0, 0, 500, onLevelStart);
        }

        override public function show():void{
            super.show();

            mouseEnabled  = false;
            mouseChildren = false;

            updateLevels();
            center();
            y += 100;

            (new rEffMove(this, x, y - 100, 400)).easing = exponentialOut;
            new rEffFade(this, 0, 1, 400, function():void{
                mouseEnabled  = true;
                mouseChildren = true;
            });
        }

        override public function update():void{
            super.update();

            if ((rInput.isKeyHit(Key.ESCAPE) || rInput.isKeyHit(Key.P)) && mouseEnabled)
                onClose();
        }

        private function onClose():void{
            mouseEnabled  = false;
            mouseChildren = false;

            (new rEffMove(this, x, y - 100, 400)).easing = exponentialIn;
            new rEffFade(this, alpha, 0, 400, close);
            Sfx.click();

            for each(var i:Button in levels){
                rTooltip.unhook(i);
            }
        }

        private function onLevelStart():void{
            close();

            TStateGame.instance.set();
            LevelManager.continueGame(levelStartTemp);
        }
    }
}