package game.windows{
    import flash.net.URLRequest;
    import flash.net.navigateToURL;

    import game.global.Make;
    import game.mobiles.MobileButton;
    import game.states.TStateLevelSelect;

    import net.retrocade.camel.global.rSave;
    import net.retrocade.camel.global.rSfx;
    import net.retrocade.camel.global.rTooltip;
    import net.retrocade.camel.global.rWindow;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.effects.rEffVolumeFade;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;

    public class TWinCompleted extends rWindow{

        private var _bg:Grid9;
        private var _text:Text;
        private var _title:Text;

        private var _playLinx:MobileButton;
        private var _playLinx2:MobileButton;
        private var _backToMenu:MobileButton;

        public function TWinCompleted(){
            _bg = Grid9.getGrid("windowBG");

            _text = Make().text("\n\n" + _("finishMessage"));
            _text.textAlignCenter();

            _title = Make().text(_("Congratulations!"));

            _playLinx = Make().button(onPlay, _("Play easy levelset"));
            _playLinx2 = Make().button(onPlay2, _("Play harder levelset"));
            _backToMenu = Make().button(onReturn, _("Return to Menu"));

            rTooltip.hook(_playLinx, _("setEasy"));
            rTooltip.hook(_playLinx2, _("setHard"));

            addChild(_bg);
            addChild(_text);
            addChild(_playLinx);
            addChild(_playLinx2);
            addChild(_backToMenu);
            addChild(_title);

            _bg.width = _text.width + 10;

            _text.x = _text.y = 5;
            _title.x = (_bg.width - _title.width) / 2;
            _title.y = 5;

            _playLinx  .x = (_bg.width - _playLinx  .width) / 2;
            _playLinx2 .x = (_bg.width - _playLinx2 .width) / 2;
            _backToMenu.x = (_bg.width - _backToMenu.width) / 2;

            _playLinx  .y = _text.y + _text.height + 5;
            _playLinx2 .y = _playLinx.y + _playLinx.height + 5;
            _backToMenu.y = _playLinx2.y + _playLinx2.height + 5;

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
                rSfx.stopMusic();
                close();
                TStateLevelSelect.instance.set();
            });
        }
    }
}