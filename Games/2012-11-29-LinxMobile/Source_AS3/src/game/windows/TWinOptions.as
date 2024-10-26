package game.windows{
    import flash.events.Event;

    import game.global.Game;
    import game.global.Make;
    import game.global.Sfx;
    import game.mobiles.MobileButton;
    import game.mobiles.rMobileWindow;
    import game.objects.TDragButton;
    import game.standalone.LinxButton;

    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.global.rGfx;
    import net.retrocade.camel.global.rSave;
    import net.retrocade.camel.global.rSfx;
    import net.retrocade.camel.objects.rBitmap;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;

    /**
     * /assets.
     * @author Maurycy Zarzycki
     */
    public class TWinOptions extends rMobileWindow{
        [Embed(source="/../assets/gfx/by_cage/ui/icon_5a.png")] public static var _icon_sfx  :Class;
        [Embed(source="/../assets/gfx/by_cage/ui/icon_5b.png")] public static var _icon_music:Class;

        private static var _instance:TWinOptions = new TWinOptions();

        public static function set():void{
            _instance.show();
        }




        protected var dragMusic:TDragButton;
        protected var dragSound:TDragButton;
        protected var iconSfx  :rBitmap;
        protected var iconMusic:rBitmap;

        protected var txt:Text;
        protected var bg:Grid9;

        protected var closer:LinxButton;

        public function TWinOptions(){
            iconSfx   = rGfx.getB(_icon_sfx);
            iconMusic = rGfx.getB(_icon_music);
            dragMusic = new TDragButton();
            dragSound = new TDragButton();
            closer  = new LinxButton(onClose, _("Close"));
            bg = Grid9.getGrid("windowBG");
            txt = Make().textCaps(_("Options"), 0xFFFFFF, 42, 8);

            iconSfx.smoothing = true;
            iconMusic.smoothing = true

            txt.filters       = Game.FILTER_SHADOW;
            iconSfx.filters   = Game.FILTER_SHADOW;
            iconMusic.filters = Game.FILTER_SHADOW;

            addChild(bg);
            addChild(txt);
            addChild(iconSfx);
            addChild(iconMusic);
            addChild(dragMusic);
            addChild(dragSound);
            addChild(closer);

            dragMusic.addEventListener(Event.CHANGE, onSliderChanged);
            dragSound.addEventListener(Event.CHANGE, onSliderChanged);
            dragSound.addEventListener(Event.SELECT, function():void{
                Sfx.sfxClick.play();
            });
        }

        override protected function resized(e:Event):void{
            dragMusic.resize();
            dragSound.resize();
            closer.resize();

            txt.setTextCaps(txt.text, 42 * S().sizeScaler, 34 * S().sizeScaler);

            iconSfx.width = iconSfx.height = 60 * S().sizeScaler;
            iconMusic.width = iconMusic.height = 60;

            iconSfx  .y = txt.bottom + 20 * S().sizeScaler | 0;

            dragMusic.x = 10;

            iconMusic.y = txt.bottom + 20 * S().sizeScaler | 0;
            dragMusic.y = iconMusic.bottom | 0;

            iconSfx  .y = dragMusic.bottom + 20 * S().sizeScaler | 0;

            dragSound.x = 10;
            dragSound.y = iconSfx.bottom | 0;

            iconMusic.alignCenterParent();

            iconSfx.x = 0;
            txt.x = 0;
            closer.x = 0;

            bg.width = 1;
            bg.width = width + 10;

            iconSfx .alignCenterParent();
            txt     .alignCenterParent();
            closer  .alignCenterParent();
            closer.y = dragSound.bottom + 30 * S().sizeScaler | 0;

            bg.height = closer.bottom + 10;

            center();
        }

        override public function show():void{
            this._blockUnder = true;
            this._pauseGame  = false;

            dragMusic.value = rSfx.musicVolume;
            dragSound.value = rSfx.soundVolume;

            super.show();

            new rEffFade(this, 0, 1, 250);
        }

        private function onSliderChanged(e:Event):void{
            if (e.target == dragMusic)
                rSfx.musicVolume = dragMusic.value;

            if (e.target == dragSound)
                rSfx.soundVolume = dragSound.value;
        }

        private function onClose():void {
            rSave.write("musicVolume", rSfx.musicVolume);
            rSave.write("soundVolume", rSfx.soundVolume);
            rSave.flush(1024 * 32);

            mouseEnabled  = false;
            mouseChildren = false;
            new rEffFade(this, 1, 0, 250, onHide);

            Sfx.sfxClick.play();
        }

        private function onHide():void {
            close();
        }
    }
}