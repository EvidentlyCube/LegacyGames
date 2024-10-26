package game.mobiles{
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.TouchEvent;
    import flash.utils.clearTimeout;
    import flash.utils.setTimeout;
    
    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.camel.global.retrocamel_int;
    import net.retrocade.camel.objects.rSprite;
    import net.retrocade.standalone.Colorizer;

    use namespace retrocamel_int;
    
    public class MobileButton extends rSprite{
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
			if (_enabled == value)
				return;
			
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
        
        
        override public function set x(value:Number):void{
            super.x = value | 0;
        }
        
        override public function set y(value:Number):void{
            super.y = value | 0;
        }
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Misc
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public var colorizer:Colorizer;

        public var mouseDownCallback:Function;
        public var mouseUpCallback  :Function
        public var clickCallback    :Function;
        
        public var ignoreHighlight  :Boolean = false;
        
        public var data:*;

        protected var clickRegister:Boolean = false;

        protected var unclickTimer:int = -1;

        
        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/
        
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Constructor
        // ::::::::::::::::::::::::::::::::::::::::::::::
        
        public function MobileButton(clickCallback:Function, enabled:Boolean = true){
            colorizer = new Colorizer(this);

            this.clickCallback = clickCallback;
            
            addEventListener(Event.ADDED_TO_STAGE,     addEventListeners);
            addEventListener(Event.REMOVED_FROM_STAGE, removeEventListeners);
            
            this.enabled = enabled;
            
            data = {};
        }
        
        protected function addEventListeners(e:*):void{
            addEventListener(MouseEvent.CLICK, onClicked, false, 0, true);
            addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin, false, 0, true);
            addEventListener(TouchEvent.TOUCH_END,   onTouchEnd,   false, 0, true);
            
            rDisplay.stage.addEventListener(TouchEvent.TOUCH_END, onStageTouchEnd, false, 0, true);
        }
        
        protected function removeEventListeners(e:*):void{
            removeEventListener(MouseEvent.CLICK, onClicked);
            removeEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
            removeEventListener(TouchEvent.TOUCH_END,   onTouchEnd);
            
            rDisplay.stage.removeEventListener(TouchEvent.TOUCH_END, onStageTouchEnd);
        }
        
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Enabling
        // ::::::::::::::::::::::::::::::::::::::::::::::
        
        public function enable():void{
            _enabled = true;
            
            colorizer.saturation = 1;
            colorizer.luminosity = 1;
            alpha = 1;
        }
        
        public function disable():void{
            _enabled = false;
            
            colorizer.saturation = 0;
            colorizer.luminosity = 0.75;
            alpha = 0.5;
        }
        
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Roll Effect
        // ::::::::::::::::::::::::::::::::::::::::::::::
        
        protected function rollOverEffect():void {
            return;
            colorizer.brightness = 50;
        }
        
        protected function rollOutEffect():void {
            return;
            if (unclickTimer == -1)
                colorizer.brightness = 0;
        }
        
        protected function onClicked(e:MouseEvent):void{
            if (mouseEnabled == false || mouseChildren == false)
                return;
            
            onClick(null);
        }
        
        protected function onClick(e:TouchEvent):void{
            clickRegister = false;
            
            if (_clickDisabled || !_enabled)
                return;
            
            if (unclickTimer != -1)
                clearTimeout(unclickTimer);
            
            if (data.lit)
                data.lit.visible = true;
            
            setTimeout(unhighlight, 200);
            
            if (clickCallback != null)
                if (clickCallback.length)
                    clickCallback(this);
                else
                    clickCallback();
            
            if (stage)
                stage.focus = stage;
        }
        
        protected function onTouchBegin(e:TouchEvent):void{
            if (mouseEnabled == false || mouseChildren == false)
                return;
            
            clickRegister = true;
            
            if (_clickDisabled || !_enabled)
                return;
            
            if (mouseDownCallback != null)
                if (mouseDownCallback.length)
                    mouseDownCallback(this);
                else
                    mouseDownCallback();
        }
        
        protected function onTouchEnd(e:TouchEvent):void{
            if (mouseEnabled == false || mouseChildren == false)
                return;
            
            if (_clickDisabled || !_enabled)
                return;
            
            if (mouseUpCallback != null)
                if (mouseUpCallback.length)
                    mouseUpCallback(this);
                else
                    mouseUpCallback();
            
            if (clickRegister)
                onClick(e);
        }
        
        protected function onStageTouchEnd(e:TouchEvent):void{
            if (mouseEnabled == false || mouseChildren == false)
                return;
            
            clickRegister = false;
        }
        
        protected function unhighlight():void{
            if (data.lit)
                data.lit.visible = false;
            
            unclickTimer = -1;
        }
    }
}