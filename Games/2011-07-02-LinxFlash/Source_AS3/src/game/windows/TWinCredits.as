package game.windows {
    import flash.display.DisplayObject;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;

    import game.global.Make;

    import net.retrocade.camel.core.rTooltip;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.standalone.Bitext;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.UDisplay;

    /**
     * ...
     * @author ...
     */
    public class TWinCredits extends rWindow {
        /****************************************************************************************************************/
        /**                                                                                                     STATIC  */
        /****************************************************************************************************************/

        private static var _instance:TWinCredits = new TWinCredits();

        public static function get instance():TWinCredits {
            return _instance;
        }


        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/


        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        public function TWinCredits() {
            _blockUnder = true;
            _pauseGame  = false;

            var by:Bitext   = Make().text(_("Game by"),       0xFFFF00, 2);
            var by2:Bitext  = Make().text(_("RETROCADE.net"), 0x44FF44, 2);

            var prg:Bitext  = Make().text(_("Programming"),       0xFFFF00);
            var prg2:Bitext = Make().text(_("Maurycy Zarzycki"),       0xFFFFFF);

            var gfx:Bitext  = Make().text(_("Graphics"),       0xFFFF00);
            var gfx2:Bitext = Make().text(_("Aleksander Kowalczyk"),       0xFFFFFF);

            var mus:Bitext  = Make().text(_("Music"),       0xFFFF00);
            var mus2:Bitext = Make().text(_("Musics"),       0xFFFFFF);

            var sfx:Bitext  = Make().text(_("Sound Effects"),       0xFFFF00);
            var sfx2:Bitext = Make().text(_("Various Resources"),       0xFFFFFF);

            var trn:Bitext  = Make().text(_("Translations"),           0xFFFF00);
            var trn2:Sprite = UDisplay.wrapInSprite(Make().text(_("EN - Chris Allcock"),     0xFFFFFF));
            var trn3:Sprite = UDisplay.wrapInSprite(Make().text(_("PL - Maurycy Zarzycki"),  0xFFFFFF));

            var spc:Shape = new Shape();

            var closer:Button = Make().button(onClose, _("Close"));

            var all:Array = [by, by2, prg, prg2, gfx, gfx2, mus, mus2, sfx, sfx2,
                             trn, trn2, trn3, closer];

            rTooltip.hook(trn2, "http://zolyx.co.uk");
            rTooltip.hook(trn3, "http://mauft.com");

            trn2.buttonMode = true;
            trn3.buttonMode = true;

            trn2.addEventListener(MouseEvent.MOUSE_DOWN, function():void{navigateToURL(new URLRequest("http://zolyx.co.uk"), "_blank");});
            trn3.addEventListener(MouseEvent.MOUSE_DOWN, function():void{navigateToURL(new URLRequest("http://mauft.com"), "_blank");});

            by2 .y = 22;
            prg .y = 65;
            prg2.y = 80;
            gfx .y = 100;
            gfx2.y = 115;
            mus .y = 135;
            mus2.y = 150;
            sfx .y = 185;
            sfx2.y = 200;

            mus2.align = Bitext.ALIGN_MIDDLE;

            trn .y = 65;
            trn2.y = 80;
            trn3.y = 95;

            var wid:Number = Math.max(prg.width, prg2.width, gfx.width, gfx2.width, mus.width, mus2.width, sfx.width,
                                      sfx2.width, trn.width, trn2.width, trn3.width);

            by    .x = (wid * 2 + 40 - by    .width) / 2;
            by2   .x = (wid * 2 + 40 - by2   .width) / 2;
            closer.x = (wid * 2 + 40 - closer.width) / 2;

            prg .x = (wid + 20 - prg .width) / 2;
            prg2.x = (wid + 20 - prg2.width) / 2;
            gfx .x = (wid + 20 - gfx .width) / 2;
            gfx2.x = (wid + 20 - gfx2.width) / 2;
            mus .x = (wid + 20 - mus .width) / 2;
            mus2.x = (wid + 20 - mus2.width) / 2;
            sfx .x = (wid + 20 - sfx .width) / 2;
            sfx2.x = (wid + 20 - sfx2.width) / 2;

            trn .x = wid + 20 + (wid + 20 - trn .width) / 2;
            trn2.x = wid + 20 + (wid + 20 - trn2.width) / 2;
            trn3.x = wid + 20 + (wid + 20 - trn3.width) / 2;

            closer.y = Math.max(sfx2.y + sfx2.height, trn3.y + trn3.height) + 15;

            UDisplay.addArray(this, all)

            var bg:Grid9 = Grid9.getGrid('windowBG');

            bg.innerY = 42;
            bg.width  = wid * 2 + 40;
            bg.height = height + 10;

            addChildAt(bg, 0);

            center();
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Overrides
        // ::::::::::::::::::::::::::::::::::::::::::::::

        override public function show():void{
            super.show();

            new rEffFade(this, 0, 1, 250);
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Callbacks
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private function onClose():void {
            new rEffFade(this, 1, 0, 250, onHideFinish);
        }

        private function onHideFinish():void {
            close();
        }
    }
}