package game.objects{
    import net.retrocade.starling.rStarlingSprite;

    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    public class TStarlingButton extends rStarlingSprite{

        public var onClick:Function;
        public var data:Object = {};
        protected var _enabled:Boolean = true;

        public function TStarlingButton(onClick:Function){
            super();

            this.onClick = onClick;

            addEventListener(TouchEvent.TOUCH, onTouch);
        }

        private function onTouch(e:TouchEvent):void{
            e.stopPropagation();
            var touch:Touch = e.getTouch(this);

            if (touch && touch.phase == TouchPhase.BEGAN && _enabled && onClick != null){
                if (onClick.length == 0)
                    onClick();
                else
                    onClick(this);
            }
        }

        public function set enabled(value:Boolean):void{
            _enabled = value;

            alpha = value ? 1 : 0.5;
        }
    }
}