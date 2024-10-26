package submuncher.core.display {
    import net.retrocade.retrocamel.core.RetrocamelDisplayManager;

    import starling.text.TextField;
    import starling.text.TextFieldAutoSize;
    import starling.utils.HAlign;
    import starling.utils.VAlign;

    public class SubmuncherTextField extends TextField{
        public function SubmuncherTextField(text:String = "", fontScale:Number = 1, color:uint = 0xFFFFFF, width:Number = NaN, height:Number = NaN, font:String = null) {
            super(
                isNaN(width) ? RetrocamelDisplayManager.starlingStage.stageWidth : width,
                isNaN(height) ? RetrocamelDisplayManager.starlingStage.stageHeight : height,
                text,
                font ? font : S.FONT_ORANGE,
                9 * fontScale,
                color,
                false
            );

            leading = 1;

            this.hAlign = HAlign.LEFT;
            this.vAlign = VAlign.TOP;
            if (isNaN(width) || isNaN(height)){
                this.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
                this.text = text;
            } else {
                this.width = width;
                this.height = height;
                this.autoSize = TextFieldAutoSize.NONE;
            }
        }

        public function disableAutoSize():void {
            this.autoSize = TextFieldAutoSize.NONE;
        }

        override public function clone():* {
            var clone:SubmuncherTextField = new SubmuncherTextField();
            cloneSetProperties(clone, false);

            return clone;
        }
    }
}
