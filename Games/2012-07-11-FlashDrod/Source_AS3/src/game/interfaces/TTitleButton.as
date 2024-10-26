package game.interfaces{
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.filters.DropShadowFilter;
    import flash.filters.GlowFilter;
    import flash.text.TextField;

    import game.global.Sfx;

    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Text;

    public class TTitleButton extends Button{

        private var textField:TextField;

        private var textNormal:String;
        private var textRollover:String;

        public function TTitleButton(clickCallback:Function, label:String, shortcutCharacter:String){
            textField = new TextField();
            textField.embedFonts = true;

            label = label.replace(new RegExp(shortcutCharacter, ""), "<font color='#FFFFFF'>$&</font>");

            textNormal   = "<font size='36' color='#B0B0FF' face='" + C.FONT_FAMILY + "'>" + label + "</font>";
            textRollover = "<font size='36' color='#FFFF60' face='" + C.FONT_FAMILY + "'>" + label + "</font>";

            textField.filters = [ new GlowFilter(0, 1, 3, 3, 200), new DropShadowFilter(4, 45, 0, 1, 2, 2, 0.5) ];

            addChild(textField);

            textField.htmlText     = textNormal;
            textField.width        = textField.textWidth  + 10;
            textField.height       = textField.textHeight;
            textField.selectable   = false;
            textField.mouseEnabled = false;

            super(clickCallback);

            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
        }

        override public function enable():void{
            super.enable();
            textField.alpha = 1;
        }

        override public function disable():void{
            super.disable();
            textField.alpha = 0.5;
        }

        protected function onAddedToStage(e:Event):void{
            textField.htmlText = textNormal;
        }

        override protected function onRollOver(e:MouseEvent):void{
            textField.htmlText = textRollover;
        }

        override protected function onRollOut(e:MouseEvent):void{
            textField.htmlText = textNormal;
        }
    }
}