package game.windows{
    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.MouseEvent;

    import game.global.Make;

    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rDisplay;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.core.rWindows;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.UNumber;

    public class TWinFocusPause extends rWindow{
        private static var _instance:TWinFocusPause = new TWinFocusPause();

        public static function get instance():TWinFocusPause{
            return _instance;
        }



        private static var _initialVolume:Number = 0;

        // ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Hooking device
		// ::::::::::::::::::::::::::::::::::::::::::::::

        public static function hook():void{
            rDisplay.stage.addEventListener(Event.ACTIVATE, onActivate);
            rDisplay.stage.addEventListener(Event.DEACTIVATE, onDeactivate);
        }

        public static function unhook():void{
            rDisplay.stage.removeEventListener(Event.ACTIVATE, onActivate);
            rDisplay.stage.removeEventListener(Event.DEACTIVATE, onDeactivate);
        }

        private static function onDeactivate(e:Event):void{
            if (instance.parent)
                return;

            _initialVolume = rSound.musicTempVolume;

            instance.show();

            if (_initialVolume != 0)
                rSound.pauseMusic();
        }

        private static function onActivate(e:Event):void{
            if (instance.parent){
                instance.close();

                if (_initialVolume != 0)
                    rSound.resumeMusic()
            }
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Normal WIndow Stuff
		// ::::::::::::::::::::::::::::::::::::::::::::::

        private var _hue :Number = 0;
        private var _sat :Number = 0;
        private var _wave:Number = 0;

        private var _focusOff:Text;
        private var _focusInstruction:Text;

        public function TWinFocusPause(){
            this._blockUnder = true;
            this._pauseGame  = true;

            _focusOff         = new Text("Pause - Game lost focus", "font", 16, 0xFF0000);
            _focusInstruction = new Text("Click to continue", "font", 16, 0x00FF00);

            _focusOff        .y = S().gameHeight / 2 - _focusOff.height - 10;
            _focusInstruction.y = S().gameHeight / 2 + 10;

            addChild(_focusOff);
            addChild(_focusInstruction);

            graphics.beginFill(0, 0.4);
            graphics.drawRect(0, 0, S().gameWidth, S().gameHeight);
            graphics.beginFill(0, 0.8);
            graphics.drawRect(0, _focusOff.y - 15, S().gameWidth, _focusOff.height + _focusInstruction.height + 50);

            update();
        }

        override public function update():void{
            _focusOff        .color = UNumber.hsvToRGB(_hue, Math.cos(_sat++ * Math.PI / 30) * 0.5 + 0.5, 1);
            _focusInstruction.color = UNumber.hsvToRGB(_hue + 180, Math.cos(_sat * Math.PI / 30) * 0.5 + 0.5,  1);

            _focusOff        .x = Math.sin(_sat * Math.PI / 60) * 20 + (width - _focusOff.width) / 2;
            _focusInstruction.x = Math.sin(-_sat * Math.PI / 60) * 20 + (width - _focusInstruction.width) / 2;

            if (_sat % 60 == 30)
                _hue += 60;
        }
    }
}