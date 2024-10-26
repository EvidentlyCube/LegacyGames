package com.mauft.Editor{
    import flash.display.Bitmap;
    import flash.display.Sprite;
    
    public class FieldItem extends Sprite{
        internal var guru:Item
        public function FieldItem(_guru:Item, _x:uint, _y:uint){
            guru=_guru
            x=_x
            y=_y
            addChild(new Bitmap(guru.gfx))
        }
    }
}