package net.retrocade.standalone{
    import flash.utils.clearTimeout;
    import flash.utils.setTimeout;

    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.camel.global.retrocamel_int;

    import starling.display.DisplayObjectContainer;

    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    use namespace retrocamel_int;

    public class MobileButton extends Sprite{
        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

            public var clickable:Boolean = true;

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Enabled
        // ::::::::::::::::::::::::::::::::::::::::::::::

        protected var _enabled:Boolean = true;

        public function get enabled():Boolean{
            return _enabled;
        }

        public function set enabled(value:Boolean):void{
            if (_enabled == value){
                return;
            }

            _enabled = value;

            if (value){
                effectEnabled();
            } else {
                effectDisabled();
            }
        }

        public var clickEffectDuration:uint = 250;

        override public function set x(value:Number):void{
            super.x = value | 0;
        }

        override public function set y(value:Number):void{
            super.y = value | 0;
        }

        private var _clickEffectTimer:Number;



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Misc
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public var clickCallback    :Function;

        public var data:Object;


        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

            // ::::::::::::::::::::::::::::::::::::::::::::::
            // :: Constructor
            // ::::::::::::::::::::::::::::::::::::::::::::::

        public function MobileButton(clickCallback:Function){
            this.clickCallback = clickCallback;

            addEventListener(TouchEvent.TOUCH, onTouch);

            data = {};
        }

        public function destroy():void{
            removeChildren();

            removeEventListener(TouchEvent.TOUCH, onTouch);
            clickCallback = null;

            data = null;

            if (_clickEffectTimer){
                clearTimeout(_clickEffectTimer);
            }
        }

        protected function effectDisabled():void{
            alpha = 1;
        }

        protected function effectEnabled():void{
            alpha = 0.5;
        }

        protected function rollOverEffect():void{
            alpha = 0.8;
        }

        protected function rollOutEffect():void{
            alpha = 1;
        }

        protected function clickEffect():void{
            alpha = 0.7;
        }

        protected function unclickEffect():void{
            alpha = 1;
        }

        protected function onTouch(e:TouchEvent):void{
            var touch:Touch = e.getTouch(this);

            if (!clickable){
                return;
            }

            if (!touch){
                rollOutEffect();
            } else if (touch.phase == TouchPhase.HOVER){
                rollOverEffect();
            } else if (touch.phase == TouchPhase.ENDED){
                onClicked();
            }
        }

        protected function onClicked():void{
            if (!canClick()){
                return;
            }

            if (_clickEffectTimer){
                clearTimeout(_clickEffectTimer);
            }

            clickEffect();
            _clickEffectTimer = setTimeout(unclickEffect, clickEffectDuration);

            if (clickCallback !== null){
                if (clickCallback.length == 0){
                    clickCallback();
                } else {
                    clickCallback(this);
                }
            }
        }

        final protected function canClick():Boolean{
            if (_enabled == false){
                return false;
            }

            var crawl:DisplayObjectContainer = this;

            do{
                if (!crawl.touchable){
                    return false;
                }
                crawl = crawl.parent;
            } while (crawl);

            return true;
        }
    }
}