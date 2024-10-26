package game.windows{
    import flash.display.Sprite;
    import flash.events.MouseEvent;

    import game.global.Make;
    import game.global.Options;
    import game.global.Sfx;
    import game.standalone.VolumeBar;

    import net.retrocade.camel.core.rTooltip;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffectSequence;
    import net.retrocade.standalone.Bitext;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.UGraphic;

    /**
     * ...
     * @author Maurycy Zarzycki
     */
    public class TWinOptions extends rWindow{
        protected var options:Options;

        protected var closer:Button;

        public function TWinOptions(){
            this._blockUnder = true;
            this._pauseGame  = false;

            var bg:Grid9 = Grid9.getGrid("windowBG");

            var txt:Bitext = Make().text(_("Options"), 0xFFFFFF, 3);

            options = new Options();
            closer  = Make().button(onClose, _('Close'));

            bg.innerWidth  = options.width;
            bg.innerHeight = options.height + closer.height + 15;
            bg.innerX = 0;
            bg.innerY = 40;

            addChild(bg);
            addChild(txt);
            addChild(options);
            addChild(closer);

            options.x = (width - options.width) / 2 | 0;
            options.y = 55;

            txt.x = (width - txt.width) / 2 | 0;

            closer.x = (width - closer.width) / 2 | 0;
            closer.y = height - closer.height - 10;

            center();

            new rEffFade(this, 0, 1, 250);
        }

        private function onClose():void {
            mouseEnabled  = false;
            mouseChildren = false;
            new rEffFade(this, 1, 0, 250, onHide);

            Sfx.sfxClickPlay();
        }

        private function onHide():void {
            close();
        }
    }
}