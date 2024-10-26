package com.mauft.Editor{
    import flash.display.Sprite;
    import flash.filters.DropShadowFilter;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    
    public class WindowHelp extends Sprite{
        private static var _txt:TextField
        public function WindowHelp(){
            y=Editor.stage.stageHeight-100
            graphics.beginFill(0x333333)
            graphics.drawRect(0, 0, Editor.stage.stageWidth, 100)
            
            _txt=new TextField
            _txt.autoSize=TextFieldAutoSize.NONE
            _txt.width=Editor.stage.stageWidth
            _txt.height=100
            _txt.textColor=0xFFFFFF
            _txt.multiline=true
            _txt.wordWrap=true
            var f:Array=_txt.filters
            f.push(new DropShadowFilter(2, 45, 0, 1, 2, 2, 1))
            _txt.filters=f
            SetText("This is a help panel!\n\n" + 
                    "Whenever you hover over some editor element some information about that element will be displayed here. Please feel free to use this windows to get yourself familiar with the editor and its functions.")
                    
            addChild(_txt)
        }
        internal static function SetText(t:String):void{
            _txt.htmlText="<p align='center'><font face='verdana' size='12' color='#FFFFFF'>"+t+"</font></p>";
        }
    }
}