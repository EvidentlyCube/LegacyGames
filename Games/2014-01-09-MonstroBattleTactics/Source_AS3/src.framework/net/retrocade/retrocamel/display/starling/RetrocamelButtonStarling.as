

package net.retrocade.retrocamel.display.starling {
    import flash.utils.clearTimeout;
    import flash.utils.setTimeout;

    import net.retrocade.retrocamel.core.retrocamel_int;

    import starling.display.DisplayObjectContainer;
    import starling.display.Sprite;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    use namespace retrocamel_int;

    public class RetrocamelButtonStarling extends Sprite {
        public var clickable:Boolean = true;
        public var touchPhase:String = TouchPhase.BEGAN;
        public var clickEffectDuration:uint = 250;
        public var clickCallback:Function;
        public var data:Object;
        public var rollOutCallback:Function;
        private var _clickEffectTimer:Number;

        public function RetrocamelButtonStarling(clickCallback:Function) {
            this.clickCallback = clickCallback;

            addEventListener(TouchEvent.TOUCH, onTouch);

            data = {};
        }

        override public function dispose():void {
            removeChildren();

            removeEventListener(TouchEvent.TOUCH, onTouch);
            clickCallback = null;

            data = null;

            if (_clickEffectTimer) {
                clearTimeout(_clickEffectTimer);
            }

			super.dispose();
        }

        protected function effectDisabled():void {
            alpha = 1;
        }

        protected function effectEnabled():void {
            alpha = 0.5;
        }

        protected function rollOverEffect():void {
            alpha = 0.8;
        }

        protected function rollOutEffect():void {
            alpha = 1;
        }

        protected function clickEffect():void {
            alpha = 0.7;
        }

        protected function unclickEffect():void {
            alpha = 1;
        }

        protected function onClicked():void {
            if (!canClick()) {
                return;
            }

            if (_clickEffectTimer) {
                clearTimeout(_clickEffectTimer);
            }

            if (clickCallback !== null) {
                if (clickCallback.length == 0) {
                    clickCallback();
                } else {
                    clickCallback(this);
                }
            }

            clickEffect();
            _clickEffectTimer = setTimeout(unclickEffect, clickEffectDuration);
        }

        final protected function canClick():Boolean {
            if (_enabled == false) {
                return false;
            }

            var crawl:DisplayObjectContainer = this;

            do {
                if (!crawl.touchable) {
                    return false;
                }
                crawl = crawl.parent;
            } while (crawl);

            return true;
        }

        protected function onTouch(e:TouchEvent):void {
            var touch:Touch = e.getTouch(this);

            if (!clickable) {
                return;
            }

            if (!touch) {
                if (rollOutCallback != null) {
                    rollOutCallback();
                }
                rollOutEffect();
            } else if (touch.phase == TouchPhase.HOVER) {
                rollOverEffect();
            } else if (touch.phase == touchPhase) {
                onClicked();
            }
        }

        override public function set x(value:Number):void {
            super.x = value | 0;
        }

        override public function set y(value:Number):void {
            super.y = value | 0;
        }

        protected var _enabled:Boolean = true;

        public function get enabled():Boolean {
            return _enabled;
        }

        public function set enabled(value:Boolean):void {
            if (_enabled == value) {
                return;
            }

            _enabled = value;

            if (value) {
                effectEnabled();
            } else {
                effectDisabled();
            }
        }
    }
}