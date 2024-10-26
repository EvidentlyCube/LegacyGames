package com.mauft.Editor{
    import flash.display.Bitmap;
    
    public class PenLiner extends Pen{
        private var drawing:Boolean=false
        private var lighter:Bitmap
        public function PenLiner(){}
        override internal function Step(mX:Number, mY:Number):void{
            if (!brush || mX<0 || mY<0 || mX>Editor.tileW*Editor.levelW-brush.w || mY>Editor.tileH*Editor.levelH-brush.h){
                return;
            }
            lighter.x=mX
            lighter.y=mY
            if (drawing){
                WindowOptions.currentLayer.drawItem(brush, mX, mY)
            }
        }
        override internal function MouseDown():void{
            trace("dum")
            drawing=true
        }
        override internal function MouseUp():void{
            trace("badum")
            drawing=false
        }
        override internal function setBrush(i:Item):void{
            if (!i){return}
            super.setBrush(i)
            if (lighter){
                WindowLevel.brushLayer.removeChild(lighter)
            }
            lighter=new Bitmap(brush.gfx)
            lighter.alpha=0.6
            WindowLevel.brushLayer.addChild(lighter)
        }
        override internal function add():void{
            setBrush(brush)
        }
        override internal function remove():void{
            if (lighter){
                WindowLevel.brushLayer.removeChild(lighter)
            }
        }
    }
}