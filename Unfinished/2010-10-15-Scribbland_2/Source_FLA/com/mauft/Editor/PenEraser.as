package com.mauft.Editor{
    import flash.display.Bitmap;
    
    public class PenEraser extends Pen{
        private var drawing:Boolean=false
        public function PenEraser(){}
        override internal function Step(mX:Number, mY:Number):void{
            if (!brush || mX<0 || mY<0 || mX>Editor.tileW*Editor.levelW-brush.w || mY>Editor.tileH*Editor.levelH-brush.h){
                return;
            }
            
            if (drawing){
                WindowOptions.currentLayer.clearItem(mX, mY)
            }
        }
        override internal function MouseDown():void{
            drawing=true
        }
        override internal function MouseUp():void{
            drawing=false
        }
    }
}