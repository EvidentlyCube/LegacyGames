package game.interfaces {
    import flash.events.MouseEvent;
    import flash.filters.DropShadowFilter;
    import game.global.Sfx;
	import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
	
	/**
     * ...
     * @author Maurycy Zarzycki
     */
    public class TDrodButton extends Button {
        private static var buttonFilterUp  :Array = [ new DropShadowFilter(2, 45, 0, 0.4, 3, 3) ];
        private static var buttonFilterDown:Array = [ new DropShadowFilter(2, 45, 0, 0.2, 3, 3) ];

        public var textField:Text;

        private var _isDown:Boolean;

        public function get isDown():Boolean {
            return _isDown;
        }

        private var _bgUp  :Grid9;
        private var _bgDown:Grid9;

        public var muteSounds:Boolean = false;

        public var releaseOnRollOut:Boolean = true;

        public function TDrodButton(onClick:Function, text:String) {
            super(onClick);

            _bgUp   = Grid9.getGrid("button", true);
            _bgDown = Grid9.getGrid("buttonDown", true);

            textField = new Text(text, C.FONT_FAMILY, 18, 0);

            textField.x       = 12;
            _bgDown  .height  = _bgUp.height = 32;
            _bgDown  .width   = _bgUp.width = textField.textWidth + 30;
            _bgDown  .visible = false;

            ignoreHighlight = true;

            addChild(_bgUp);
            addChild(_bgDown);
            addChild(textField);

            filters = buttonFilterUp;
        }

        override public function set width(value:Number):void{
            _bgDown  .width = _bgUp.width = value;
            textField.x     = (width - 30 - textField.textWidth) / 2 + 12;
        }

        override public function set height(value:Number):void{
            _bgDown.height = _bgUp.height = value;
        }

        override protected function onRollOver(e:MouseEvent):void {
            super.onRollOver(e);

            if (_isDown){
                _bgUp  .visible = false;
                _bgDown.visible = true;
                filters         = buttonFilterDown;
            }
        }

        override protected function onRollOut(e:MouseEvent):void {
            super.onRollOut(e);

            if (_isDown && releaseOnRollOut){
                _bgUp  .visible = true;
                _bgDown.visible = false;
                filters         = buttonFilterUp;
            }
        }

        override protected function onClick(e:MouseEvent):void {
            super.onClick(e);

            if (!muteSounds)
                Sfx.buttonClick();

            filters = buttonFilterUp;
        }

        override protected function onMouseDown(e:MouseEvent):void {
            super.onMouseDown(e);

            _isDown         = true;
            _bgUp  .visible = false;
            _bgDown.visible = true;
            filters         = buttonFilterDown;
        }

        override protected function onMouseUp(e:MouseEvent):void {
            super.onMouseUp(e);

            _isDown         = false;
            _bgUp  .visible = true;
            _bgDown.visible = false;
            filters         = buttonFilterUp;
        }

        override protected function onStageMouseUp(e:MouseEvent):void {
            super.onStageMouseUp(e);

            _isDown = false;

            _bgUp  .visible = true;
            _bgDown.visible = false;
            filters         = buttonFilterUp;
        }
    }

}