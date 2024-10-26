package game.windows {
    import game.global.Core;
    import game.global.Make;
    import game.interfaces.TDrodButton;
    import net.retrocade.camel.core.rInput;
	import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Key;
	
	/**
     * ...
     * @author Maurycy Zarzycki
     */
    public class TWindowRedefineKeys extends rWindow {
        private static var _instance:TWindowRedefineKeys = new TWindowRedefineKeys();

        public static function show():void {
            _instance.show();
        }




        private var _bg:Grid9;

        private var _labelN      :Text;
        private var _labelS      :Text;
        private var _labelE      :Text;
        private var _labelW      :Text;
        private var _labelNW     :Text;
        private var _labelNE     :Text;
        private var _labelSW     :Text;
        private var _labelSE     :Text;
        private var _labelWait   :Text;
        private var _labelC      :Text;
        private var _labelCC     :Text;
        private var _labelUndo   :Text;
        private var _labelRestart:Text;
        private var _labelBattle :Text;
        private var _labelLock   :Text;
        private var _labelCount  :Text;

        private var _buttonN      :TDrodButton;
        private var _buttonS      :TDrodButton;
        private var _buttonE      :TDrodButton;
        private var _buttonW      :TDrodButton;
        private var _buttonNW     :TDrodButton;
        private var _buttonNE     :TDrodButton;
        private var _buttonSW     :TDrodButton;
        private var _buttonSE     :TDrodButton;
        private var _buttonWait   :TDrodButton;
        private var _buttonC      :TDrodButton;
        private var _buttonCC     :TDrodButton;
        private var _buttonUndo   :TDrodButton;
        private var _buttonRestart:TDrodButton;
        private var _buttonBattle :TDrodButton;
        private var _buttonLock   :TDrodButton;
        private var _buttonCount  :TDrodButton;

        private var _buttons:Array = [];
        private var _close:TDrodButton;

        public function TWindowRedefineKeys() {
            _bg      = Grid9.getGrid("window", true);

            addChild(_bg);

            _labelNW        = getLabel(_("keyUpLeft"), 0);
            _labelN         = getLabel(_("keyUp"), 1);
            _labelNE        = getLabel(_("keyUpRight"), 2);
            _labelW         = getLabel(_("keyLeft"), 3);
            _labelE         = getLabel(_("keyRight"), 4);
            _labelSW        = getLabel(_("keyDownLeft"), 5);
            _labelS         = getLabel(_("keyDown"), 6);
            _labelSE        = getLabel(_("keyDownRight"), 7);
            _labelWait      = getLabel(_("keyWait"), 8);
            _labelC         = getLabel(_("keyCW"), 9);
            _labelCC        = getLabel(_("keyCCW"), 10);
            _labelUndo      = getLabel(_("keyUndo"), 11);
            _labelRestart   = getLabel(_("keyRestart"), 12);
            _labelBattle    = getLabel(_("keyBattle"), 13);
            _labelLock      = getLabel(_("keyLock"), 14);

            _buttonNW       = getButton("keyUpLeft", 0);
            _buttonN        = getButton("keyUp", 1);
            _buttonNE       = getButton("keyUpRight", 2);
            _buttonW        = getButton("keyLeft", 3);
            _buttonE        = getButton("keyRight", 4);
            _buttonSW       = getButton("keyDownLeft", 5);
            _buttonS        = getButton("keyDown", 6);
            _buttonSE       = getButton("keyDownRight", 7);
            _buttonWait     = getButton("keyWait", 8);
            _buttonC        = getButton("keyCW", 9);
            _buttonCC       = getButton("keyCCW", 10);
            _buttonUndo     = getButton("keyUndo", 11);
            _buttonRestart  = getButton("keyRestart", 12);
            _buttonBattle   = getButton("keyBattle", 13);
            _buttonLock     = getButton("keyLock", 14);


            _close = new TDrodButton(onClose, "Close")
            addChild(_close);

            _bg.width = width + 10;
            _close.alignCenterParent();

            _close.y = _buttonLock.bottom + 10;
            _bg.height = height + 10;

            center();
			
			graphics.beginFill(0, 0.6);
			graphics.drawRect( -x, -y, S.SIZE_SWF_WIDTH, S.SIZE_SWF_HEIGHT);
        }

        private function getLabel(text:String, index:uint):Text {
            const V_SPACE:uint = 34;

            var label:Text = Make.text(18);

            label.x    = 5;
            label.y    = index * V_SPACE + 5;
            label.text = text;
            label.width = label.textWidth + 5;

            addChild(label);

            return label;
        }

        private function getButton(keyName:String, index:uint):TDrodButton {
            const H_OFFSET:uint = 350;
            const V_SPACE :uint = 34;

            var button:TDrodButton = new TDrodButton(onRedefineClick, _("key" + Core.getKey(keyName)));

            button.data = keyName;

            button.x = H_OFFSET;
            button.y = index * V_SPACE + 7;

            button.width  = 200;
            button.height = V_SPACE - 4;

            addChild(button);

            _buttons.push(button);

            return button;
        }

        override public function update():void {
            if (!mouseChildren && rInput.isKeyHit(Key.ESCAPE))
                onClose();
        }

        private function onRedefineClick(button:TDrodButton):void {
            TWindowRedefineWait.show(button.data, onRedefined);
        }

        private function onRedefined(keyName:String, newValue:uint):void {
            Core.setKey(keyName, newValue);

            for each(var i:TDrodButton in _buttons) {
                i.textField.text = _("key" + Core.getKey(i.data));
                i.width = i.width;
            }
        }

        private function onClose():void {
            mouseChildren = false;
            Core.saveKeys();
            new rEffFade(this, 1, 0, 500, onFadedOut);
        }

        override public function show():void {
            super.show();
            mouseChildren = false;

            new rEffFade(this, 0, 1, 500, onFadedIn);
        }

        public function onFadedIn():void {
            mouseChildren = true;
        }

        public function onFadedOut():void {
            close();
        }
    }
}