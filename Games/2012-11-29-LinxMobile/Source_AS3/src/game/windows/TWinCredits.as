package game.windows {
    import flash.display.DisplayObject;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;

    import game.global.Game;
    import game.global.Make;
    import game.global.Sfx;
    import game.mobiles.MobileButton;
    import game.mobiles.rMobileWindow;

    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.UDisplay;

    /**
     * ...
     * @author ...
     */
    public class TWinCredits extends rMobileWindow {
        /****************************************************************************************************************/
        /**                                                                                                     STATIC  */
        /****************************************************************************************************************/

        private static var _instance:TWinCredits = new TWinCredits();

        public static function get instance():TWinCredits {
            return _instance;
        }


        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        public function TWinCredits() {
            _blockUnder = true;
            _pauseGame  = false;

            var by:Text   = Make().text(_("Game by"),       0xFFFF00, 26);
            var by2:Text  = Make().text(_("Maurycy Zarzycki Mauft.com\nRetrocade.net"), 0x44FF44, 26);

            var prg:Text  = Make().text(_("Producer, Programming, Level Development"),    0xFFFF00);
            var prg2:Text = Make().text(_("Maurycy Zarzycki"),       0xFFFFFF);

            var gfx:Text  = Make().text(_("Graphics, Level Development"),       0xFFFF00);
            var gfx2:Text = Make().text(_("Aleksander Kowalczyk"),       0xFFFFFF);

            var mus:Text  = Make().text(_("Music"),       0xFFFF00);
            var mus2:Text = Make().text(_("Musics"),       0xFFFFFF);

            var sfx:Text  = Make().text(_("Special Thanks"),       0xFFFF00);
            var sfx2:Text = Make().text(_("Kamila Nalikowska, Matt Schikore,\nAdrienne E. Siskind"),       0xFFFFFF);

            var spc:Shape = new Shape();

            var closer:MobileButton = Make().button(onClose, _("Close"));

            var all:Array = [by, by2, prg, prg2, gfx, gfx2, sfx, sfx2, closer];
            all.push(mus, mus2);

            by2.textAlignCenter();

            by2.fitSize();
            prg2.fitSize();
            gfx2.fitSize();
            sfx2.fitSize();

            by2 .y = by.bottom;
            prg .y = by2.bottom + 15 * S().sizeScaler;
            prg2.y = prg.bottom;
            gfx .y = prg2.bottom + 15 * S().sizeScaler;
            gfx2.y = gfx.bottom;
            sfx .y = gfx2.bottom + 15 * S().sizeScaler;
            sfx2.y = sfx.bottom;

            mus .y = sfx2.bottom + 15;
            mus2.y = mus.bottom;

            mus2.textAlignCenter();

            var wid:Number = Math.max(by2.width, prg.width, prg2.width, gfx.width, gfx2.width, sfx.width, sfx2.width);
            wid = Math.max(wid, mus.width);
            wid += 40;

            by    .alignCenterParent(0, wid);
            by2   .alignCenterParent(0, wid);
            closer.alignCenterParent(0, wid);

            prg .alignCenterParent(0, wid);
            prg2.alignCenterParent(0, wid);
            gfx .alignCenterParent(0, wid);
            gfx2.alignCenterParent(0, wid);
            sfx .alignCenterParent(0, wid);
            sfx2.alignCenterParent(0, wid);

            mus .alignCenterParent(0, wid);
            mus2.alignCenterParent(0, wid);

            by.filters   = Game.FILTER_SHADOW;
            by2.filters  = Game.FILTER_SHADOW;
            prg.filters  = Game.FILTER_SHADOW;
            prg2.filters = Game.FILTER_SHADOW;
            gfx.filters  = Game.FILTER_SHADOW;
            gfx2.filters = Game.FILTER_SHADOW;
            sfx.filters  = Game.FILTER_SHADOW;
            sfx2.filters = Game.FILTER_SHADOW;

            mus.filters = Game.FILTER_SHADOW;
            mus2.filters = Game.FILTER_SHADOW;

            closer.y = sfx2.bottom + 15 | 0;
            closer.y = mus2.bottom + 15;

            UDisplay.addArray(this, all)

            var bg:Grid9 = Grid9.getGrid('windowBG');

            bg.width  = wid;
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

            center();
        }

        override protected function resized(e:Event):void{
            center();
        }

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Callbacks
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private function onClose():void {
            Sfx.sfxClick.play();

            new rEffFade(this, 1, 0, 250, onHideFinish);
        }

        private function onHideFinish():void {
            close();
        }
    }
}