package game.windows{
    import flash.net.URLRequest;
    import flash.net.navigateToURL;

    import game.global.Make;
    import game.states.TStateLevelSelect;

    import net.retrocade.camel.core.rSave;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.core.rTooltip;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.effects.rEffVolumeFade;
    import net.retrocade.standalone.Bitext;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;

    public class TWinCompleted extends rWindow{

        private var _bg:Grid9;
        private var _text:Bitext;
        private var _title:Bitext;

        private var _backToMenu:Button;

        public function TWinCompleted(){
            _bg = Grid9.getGrid("windowBG");

            _text = new Bitext("\n\n" + _("finishMessage"));
            _text.align = Bitext.ALIGN_MIDDLE;
            _text.setScale(2);

            _title = new Bitext(_("Congratulations!"));
            _title.setScale(4);

            _backToMenu = Make().button(onReturn, _("Return to Menu"));

            addChild(_bg);
            addChild(_text);
            addChild(_backToMenu);
            addChild(_title);

            _bg.width = _text.width + 10;

            _text.x = _text.y = 5;
            _title.x = (_bg.width - _title.width) / 2;
            _title.y = 5;

            _backToMenu.x = (_bg.width - _backToMenu.width) / 2;
            _backToMenu.y = _text.y + _text.height + 35;

            _bg.height = _backToMenu.y + _backToMenu.height + 10;

            center();
            show();

            rSave.write("outroSeen", true);
        }

        override public function show():void{
            super.show();

            new rEffFade(this, 0, 1, 500);
        }

        private function onPlay():void{
            navigateToURL(new URLRequest("http://retrocade.net/play/19/linx-easy-set"), "_blank");
        }

        private function onPlay2():void{
            navigateToURL(new URLRequest("http://retrocade.net/play/20/linx-hard-set"), "_blank");
        }

        private function onReturn():void{
            mouseChildren = false;
            mouseEnabled = false;

            new rEffVolumeFade(false, 1000);
            new rEffFade(this, 1, 0, 500);
            new rEffFadeScreen(1, 0, 0, 1500, function():void{
                rSound.stopMusic();
                close();
                TStateLevelSelect.instance.set();
            });
        }
    }
}