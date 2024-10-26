package com.mauft.Editor{
    import flash.display.Bitmap;
    
    public class PenRectangle extends Pen{
        private var pressed:Boolean=false
        private var released:Boolean=false
        private var holding:Boolean=false
        private var lighter:Bitmap
        private var topX:Number
        private var topY:Number
        private var endX:Number
        private var endY:Number
        public function PenRectangle(){}
        override internal function Step(mX:Number, mY:Number):void{
            if (!brush || mX<0 || mY<0 || mX>Editor.tileW*Editor.levelW-brush.w || mY>Editor.tileH*Editor.levelH-brush.h){
                return;
            }
            lighter.x=mX
            lighter.y=mY
            if(pressed){
                topX=Math.floor(mX/Editor.tileW)*Editor.tileW
                topY=Math.floor(mY/Editor.tileH)*Editor.tileH
                pressed=false
                holding=true
            }
            if (holding){
                endX=Math.floor(mX/Editor.tileW)*Editor.tileW+Editor.tileW
                endY=Math.floor(mY/Editor.tileH)*Editor.tileH+Editor.tileH
                
                var aX:Number, aY:Number, bX:Number, bY:Number;
                aX=Math.min(topX, endX)
                bX=Math.max(topX, endX)
                aY=Math.min(topY, endY)
                bY=Math.max(topY, endY)
                if (topX>=endX){aX-=Editor.tileW; bX+=Editor.tileW}
                if (topY>=endY){aY-=Editor.tileH; bY+=Editor.tileH}
                WindowLevel.brushLayer.graphics.clear()
                WindowLevel.brushLayer.graphics.beginFill(0x888888, 0.4)
                WindowLevel.brushLayer.graphics.drawRect(aX, aY, bX-aX, bY-aY) 
            }
            if (released){
                released=false
                holding=false
                topX/=Editor.tileW
                topY/=Editor.tileH
                endX/=Editor.tileW
                endY/=Editor.tileH
                //if (topX>=endX){aX-=Editor.tileW; bX+=Editor.tileW}
                //if (topY>=endY){aY-=Editor.tileH; bY+=Editor.tileH}
                var temp:Number=0
                if (topX>=endX){temp=endX; endX=topX+1; topX=temp-1;}
                if (topY>=endY){temp=endY; endY=topY+1; topY=temp-1;}
                for (var i:uint=topX; i<endX; i++){
                    for (var j:uint=topY; j<endY; j++){
                        WindowOptions.currentLayer.drawItem(brush, i*Editor.tileW, j*Editor.tileH)
                    }
                }
                WindowLevel.brushLayer.graphics.clear()
            }
        }
        override internal function MouseDown():void{
            pressed=true
        }
        override internal function MouseUp():void{
            released=true
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