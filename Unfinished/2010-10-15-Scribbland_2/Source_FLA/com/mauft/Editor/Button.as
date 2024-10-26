package com.mauft.Editor{
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.filters.GlowFilter;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    
    public class Button extends Sprite{
        private var t:TextField
        private var filter:GlowFilter
        private var dsc:String
        public var tempNumber:Number
        public var tempString:String
        public var tempObject:*
        public function Button(txt:String, desc:String=""){
            t=new TextField
            t.mouseEnabled=false
            t.autoSize=TextFieldAutoSize.LEFT
            t.htmlText="<p align='center'><font face='verdana' size='11' color='#FFFFFF'>"+txt+"</font></p>"
            
            dsc=desc
            
            graphics.beginFill(0,0)
            graphics.drawRect(0,0,t.width,t.height)
            
            filter=new GlowFilter(0xFFFFFF, 1, 3, 3, 1)
            
            addChild(t)
            addEventListener(MouseEvent.ROLL_OVER, rOver, false, 0, true)
            addEventListener(MouseEvent.ROLL_OUT, rOut, false, 0, true)
            buttonMode=true
        }
        private function rOver(e:MouseEvent):void{
            var f:Array=filters
            f.push(filter)
            filters=f
            if (dsc){
                WindowHelp.SetText(dsc)
            }
        }
        private function rOut(e:MouseEvent):void{
            var f:Array=filters
            f.pop()
            filters=f
        }
    }
}