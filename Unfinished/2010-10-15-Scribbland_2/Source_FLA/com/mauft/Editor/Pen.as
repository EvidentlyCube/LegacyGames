package com.mauft.Editor{
    public class Pen{
        internal static var brush:Item
        public function Pen(){}
        internal function setBrush(i:Item):void{brush=i}
        internal function Step(mX:Number, mY:Number):void{}
        internal function MouseDown():void{}
        internal function MouseUp():void{}
        internal function add():void{}
        internal function remove():void{}
    }
}