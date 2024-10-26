package game.windows {
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;

    import game.global.Make;
    import game.global.Sfx;
    import game.states.TStateOutro;

    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rTooltip;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.easings.exponentialIn;
    import net.retrocade.camel.easings.exponentialOut;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffMove;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Key;
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

            var bg:Grid9 = Grid9.getGrid("window");
            var title:Text = new Text(_("Credits"), "font", 22, 0xFFFFFF);

            var by:Text   = new Text(_("Game by"), "font", 24, 0xFFFF00);
            var by2:Text  = new Text(_("RETROCADE.net"), "font", 24,0x44FF44);

            var prg:Text  = new Text(_("Programming"),       "font", 14,0xFFFF00);
            var prg2:Text = new Text(_("Maurycy Zarzycki"),       "font", 14,0xFFFFFF);

            var gfx:Text  = new Text(_("Graphics"),       "font", 14,0xFFFF00);
            var gfx2:Text = new Text(_("Aleksander Kowalczyk"),       "font", 14,0xFFFFFF);

            var mus:Text  = new Text(_("Music"),       "font", 14,0xFFFF00);
            var mus2:Text = new Text(_("Various Resources"),       "font", 14,0xFFFFFF);

            var sfx:Text  = new Text(_("Sound Effects"),      "font", 14,0xFFFF00);
            var sfx2:Text = new Text(_("Various Resources"),       "font", 14,0xFFFFFF);

            var spc:Shape = new Shape();

            var closer:Button = Make().button(onClose, _("Close"));

            var all:Array = [by, by2, prg, prg2, gfx, gfx2, mus, mus2, sfx, sfx2, closer];

            const SPC_SM:uint = 15;
            const SPC_BG:uint = 30;

            by  .y = 42;
            by2 .y = 65;

            prg .y = by2 .y + SPC_BG + 10;
            prg2.y = prg .y + SPC_SM;
            gfx .y = prg2.y + SPC_BG;
            gfx2.y = gfx .y + SPC_SM;
            mus .y = gfx2.y + SPC_BG;
            mus2.y = mus .y + SPC_SM;
            sfx .y = mus2.y + SPC_BG;
            sfx2.y = sfx .y + SPC_SM;

            var wid:Number = Math.max(
                by.width,
                by2.width,
                title.width,
                prg.width,
                prg2.width,
                gfx.width,
                gfx2.width,
                mus.width,
                mus2.width,
                sfx.width,
                sfx2.width);

            by    .x = (wid + 40 - by    .width) / 2;
            by2   .x = (wid + 40 - by2   .width) / 2;
            closer.x = (wid + 40 - closer.width) / 2;
            title .x = (wid + 40 - title .width) / 2;

            prg .x = (wid + 40 - prg .width) / 2;
            prg2.x = (wid + 40 - prg2.width) / 2;
            gfx .x = (wid + 40 - gfx .width) / 2;
            gfx2.x = (wid + 40 - gfx2.width) / 2;
            mus .x = (wid + 40 - mus .width) / 2;
            mus2.x = (wid + 40 - mus2.width) / 2;
            sfx .x = (wid + 40 - sfx .width) / 2;
            sfx2.x = (wid + 40 - sfx2.width) / 2;

            closer.y = sfx2.y + sfx2.height + 15;

            addChild(bg);
            UDisplay.addArray(this, all);
            addChild(title);

            bg.width = wid + 40;
            bg.height = height + 10;

            for each(var txt:* in all){
                if (!txt)
                    continue;

                if (txt is Text)
                    Text(txt).setShadow();
                else if (txt is Sprite && txt.getChildAt(0) is Text)
                    Text(DisplayObjectContainer(txt).getChildAt(0)).setShadow();
            }
            title.setShadow();

            center();
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Overrides
		// ::::::::::::::::::::::::::::::::::::::::::::::

        override public function update():void{
            super.update();

            if ((rInput.isKeyHit(Key.ESCAPE) || rInput.isKeyHit(Key.P)) && mouseEnabled)
                onClose();
        }

        override public function show():void{
            super.show();

            mouseEnabled  = false;
            mouseChildren = false;

            center();
            x -= 100;

            (new rEffMove(this, x + 100, y, 400)).easing = exponentialOut;
            new rEffFade(this, 0, 1, 400, function():void{
                mouseEnabled  = true;
                mouseChildren = true;
            });
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Callbacks
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private function onClose():void {
            new rEffFade(this, 1, 0, 400, onHideFinish);
            (new rEffMove(this, x + 100, y, 400)).easing = exponentialIn;
            Sfx.click();
        }

        private function onHideFinish():void {
            close();
        }
    }
}