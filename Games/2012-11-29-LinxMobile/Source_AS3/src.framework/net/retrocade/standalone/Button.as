package net.retrocade.standalone{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import net.retrocade.camel.objects.rSprite;

    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.camel.global.rSfx;
    import net.retrocade.camel.global.retrocamel_int;
    import net.retrocade.camel.rCollide;

    use namespace retrocamel_int;

    public class Button extends rSprite{
        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Enabled
        // ::::::::::::::::::::::::::::::::::::::::::::::

        protected var _enabled:Boolean = true;

        public function get enabled():Boolean{
            return _enabled;
        }

        public function set enabled(value:Boolean):void{
            if (value)
                enable();
            else
                disable();
        }

        protected var _clickDisabled:Boolean = false;

        public function set clickDisabled(disabled:Boolean):void{
            _clickDisabled = disabled;

            buttonMode = !disabled;

            colorizer.luminosity = disabled ? 0.6 : 1;
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Misc
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public var colorizer:Colorizer;

        public var mouseDownCallback:Function;
        public var mouseUpCallback  :Function
        public var clickCallback    :Function;
        public var rollOverCallback :Function;
        public var rollOutCallback  :Function;

        public var ignoreHighlight  :Boolean = false;

        public var data:*;

        protected var clickRegister:Boolean = false;




        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Constructor
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public function Button(clickCallback:Function, rollOverCallback:Function = null, rollOutCallback:Function = null, enabled:Boolean = true){
            colorizer = new Colorizer(this);

            this.clickCallback = clickCallback;

            this.rollOverCallback = rollOverCallback;
            this.rollOutCallback  = rollOutCallback;

            addEventListener(Event.ADDED_TO_STAGE,     addEventListeners);
            addEventListener(Event.REMOVED_FROM_STAGE, removeEventListeners);

            buttonMode = true;

            this.enabled = enabled;
        }

        protected function addEventListeners(e:*):void{
            addEventListener(MouseEvent.MOUSE_DOWN, onTouchBegin, false, 0, true);
            addEventListener(MouseEvent.MOUSE_UP,   onTouchEnd,   false, 0, true);
            addEventListener(MouseEvent.ROLL_OVER,  onRollOver,  false, 0, true);
            addEventListener(MouseEvent.ROLL_OUT,   onRollOut,   false, 0, true);

            rDisplay.stage.addEventListener(MouseEvent.MOUSE_UP, onStageTouchEnd, false, 0, true);
        }

        protected function removeEventListeners(e:*):void{
            removeEventListener(MouseEvent.MOUSE_DOWN, onTouchBegin);
            removeEventListener(MouseEvent.MOUSE_UP,   onTouchEnd);
            removeEventListener(MouseEvent.ROLL_OVER,  onRollOver);
            removeEventListener(MouseEvent.ROLL_OUT,   onRollOut);

            rDisplay.stage.removeEventListener(MouseEvent.MOUSE_UP, onStageTouchEnd);
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Enabling
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public function enable():void{
            _enabled = true;

            mouseChildren = true;
            mouseEnabled  = true;

            colorizer.saturation = 1;
            colorizer.luminosity = 1;
        }

        public function disable():void{
            mouseChildren = false;
            mouseEnabled  = false;

            colorizer.saturation = 0;
            colorizer.luminosity = 0.75;
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Roll Effect
        // ::::::::::::::::::::::::::::::::::::::::::::::

        protected function rollOverEffect():void {
            colorizer.brightness = 50;
        }

        protected function rollOutEffect():void {
            colorizer.brightness = 0;
        }



        /****************************************************************************************************************/
        /**                                                                                            EVENT LISTENERS  */
        /****************************************************************************************************************/

        protected function onRollOver(e:MouseEvent):void{
            if (!ignoreHighlight)
                rollOverEffect();

            if (rollOverCallback != null)
                if (rollOverCallback.length)
                    rollOverCallback(this);
                else
                    rollOverCallback();
        }

        protected function onRollOut(e:MouseEvent):void{
            if (!ignoreHighlight)
                rollOutEffect();

            if (rollOutCallback != null)
                if (rollOutCallback.length)
                    rollOutCallback(this);
                else
                    rollOutCallback();
        }

        protected function onClick(e:MouseEvent):void{
            clickRegister = false;

            if (_clickDisabled)
                return;

            if (clickCallback != null)
                if (clickCallback.length)
                    clickCallback(this);
                else
                    clickCallback();

            if (stage)
                stage.focus = stage;
        }

        protected function onTouchBegin(e:MouseEvent):void{
            clickRegister = true;

            if (_clickDisabled)
                return;

            if (mouseDownCallback != null)
                if (mouseDownCallback.length)
                    mouseDownCallback(this);
                else
                    mouseDownCallback();
        }

        protected function onTouchEnd(e:MouseEvent):void{
            if (_clickDisabled)
                return;

            if (mouseUpCallback != null)
                if (mouseUpCallback.length)
                    mouseUpCallback(this);
                else
                    mouseUpCallback();

            if (clickRegister)
                onClick(e);
        }

        protected function onStageTouchEnd(e:MouseEvent):void{
            clickRegister = false;
        }
    }
}