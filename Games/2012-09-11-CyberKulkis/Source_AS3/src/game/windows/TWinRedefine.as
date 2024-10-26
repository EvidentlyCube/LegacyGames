package game.windows{
    import flash.net.URLRequest;
    import flash.net.navigateToURL;

    import game.global.Level;
    import game.global.Make;
    import game.global.Options;
    import game.global.Sfx;
    import game.states.TStateTitle;

    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.core.rTooltip;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.effects.rEffVolumeFade;
    import net.retrocade.camel.rCollide;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.UGraphic;

    public class TWinRedefine extends rWindow{
        [Embed(source="/../assets/gfx/toggleMusic.png")] private static var _gfxMusic:Class;
        [Embed(source="/../assets/gfx/toggleSound.png")] private static var _gfxSound:Class;


        private static var _instance:TWinRedefine = new TWinRedefine();

        public static function get instance():TWinRedefine{
            return _instance;
        }

        protected var options:Options;
        protected var closer :Button;

        protected var bg     :Grid9;

        public function TWinRedefine() {
            this._blockUnder = true;
            this._pauseGame  = true;

            var txt:Text = new Text(_("Redefine"), "font", 22);
            txt.setShadow();

            bg       = Grid9.getGrid("window");
            closer   = Make().button(onClose,    _('Close'));
            options  = new Options();

            addChild(bg);
            addChild(txt);
            addChild(closer);
            addChild(options);

            txt     .y = 0;
            options .y = 65;
            closer  .y = options.y + options.height + 15;


            bg.width = options.width + 40;
            bg.height = closer.y + closer.height + 10;

            txt     .x = (width - txt     .width) / 2 | 0;
            closer  .x = (width - closer  .width) / 2 | 0;
            options .x = (width - options .width) / 2 | 0;

            center();

            //UGraphic.clear(this).beginFill(0, 0.5).drawRect(-x, -y, S().gameWidth, S().gameHeight)
            //    .beginFill(0).drawRect(0, 0, options.width + 10, help.y + help.height + 10);

        }

        override public function show():void{
            super.show();
            new rEffFade(this, 0, 1, 250);
            mouseEnabled  = true;
            mouseChildren = true;
        }

        override public function update():void{
            super.update();
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Button Callbacks
		// ::::::::::::::::::::::::::::::::::::::::::::::

        private function onClose():void {
            mouseEnabled  = false;
            mouseChildren = false;
            new rEffFade(this, 1, 0, 250, efFinClose);
            Sfx.click();
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Effect Callbacks
		// ::::::::::::::::::::::::::::::::::::::::::::::

        private function efFinClose():void {
            close();
        }
    }
}