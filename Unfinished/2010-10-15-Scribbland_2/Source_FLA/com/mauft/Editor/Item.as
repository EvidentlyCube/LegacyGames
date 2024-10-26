package com.mauft.Editor{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.ColorTransform;
    
    public class Item extends Sprite{
        private var GFX:Bitmap
        private var CT:ColorTransform
        internal var gfx:BitmapData
        
        internal var w:uint
        internal var h:uint
        
        internal var gfxModX:uint
        internal var gfxModY:uint
        
        internal var availableToLayer:uint
        
        internal var desc:String
        
        internal var forceGrid:Boolean
        internal var solid:Boolean
        public function Item(_gfx:BitmapData, _w:uint, _h:uint, _gfxX:uint, _gfxY:uint, _av:uint, _desc:String, _x:uint, _y:uint, _force:Boolean, _solid:Boolean){
            x                = _x * 35;
            y                = _y * 35;
            gfx              = _gfx
            w                = _w
            h                = _h
            gfxModX          = _gfxX
            gfxModY          = _gfxY
            availableToLayer = _av
            desc=_desc
            forceGrid=_force
            solid=_solid
            
            GFX=new Bitmap(gfx)
            addChild(GFX)
            
            graphics.beginFill(0xFFFFFF)
            graphics.drawRect(0, 0, width, height)
            
            CT=transform.colorTransform
            
            addEventListener(MouseEvent.ROLL_OVER, rOver)
            addEventListener(MouseEvent.ROLL_OUT, rOut)
            addEventListener(MouseEvent.CLICK, click)
            
            buttonMode=true
            
            Editor.newItem(this)
        }
        private function rOver(e:MouseEvent):void{
            CT.blueMultiplier=2
            CT.redMultiplier=2
            CT.greenMultiplier=2
            transform.colorTransform=CT
        }
        private function rOut(e:MouseEvent):void{
            CT.blueMultiplier=1
            CT.redMultiplier=1
            CT.greenMultiplier=1
            transform.colorTransform=CT
        }
        private function click(e:MouseEvent):void{
            WindowOptions.pen.setBrush(this)
        }
    }
}