package com.mauft.Editor{
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    
    public class WindowItems extends Sprite{
        public var items:Sprite
        private var _dispH:Number
        
        private var _vertBar:Sprite
        
        internal static var _barScroll:uint=0
        private var _barScrollY:uint=0
        public function WindowItems(){
            y=184
            graphics.beginFill(0x555555)
            _dispH=Editor.stage.stageHeight-284
            graphics.drawRect(0,0,268, _dispH)
            graphics.beginFill(0x444444)
            graphics.drawRect(268, 0, 16, _dispH)

            var s:Shape=new Shape
            s.graphics.beginFill(0)
            s.graphics.drawRect(14,14,240, _dispH-28)
            
            _vertBar=new Sprite
            _vertBar.graphics.beginFill(0xAAAAAA)
            _vertBar.graphics.drawRect(268, 0, 16, 16)
            _vertBar.visible=false
            
            _vertBar.alpha=0.8
            _vertBar.addEventListener(MouseEvent.ROLL_OVER, VertBarRollOver)
            _vertBar.addEventListener(MouseEvent.ROLL_OUT, VertBarRollOut)
            _vertBar.addEventListener(MouseEvent.MOUSE_DOWN, VertBarDown)
            _vertBar.buttonMode=true
            
            items=new Sprite
            items.x=14
            items.y=14
            items.mask=s
            
            addChild(_vertBar)
            addChild(items)
            addChild(s)
        }
        internal function Step():void{
            if (_barScroll==2){
                _vertBar.y+=_vertBar.mouseY-_barScrollY
                if (_vertBar.y<0){_vertBar.y=0}
                if (_vertBar.y>=_dispH-_vertBar.height){_vertBar.y=_dispH-_vertBar.height}
                items.y=Math.floor(14-(_vertBar.y/(_dispH-_vertBar.height))*(items.height/2))
            }
        }
        internal function selectLayer(lay:Layer):void{
            clear()
            var a:Array=WindowOptions.items
            var it:Item
            for (var i:int=a.length-1; i>=0; i--){
                it=a[i] as Item
                if (it.availableToLayer==lay.id){
                    addItem(it)
                }
            }
            WindowOptions.currentLayer=lay
            updateBar()
        }
        private function updateBar():void{
            if (items.height<=_dispH-28){
                _vertBar.visible=false
            } else {
                _vertBar.visible=true
                _vertBar.graphics.clear()
                _vertBar.graphics.beginFill(0xAAAAAA)
                _vertBar.graphics.drawRect(268, 0, 16, _dispH*_dispH/items.height)
            }
        }
        private function addItem(i:Item):void{
            items.addChild(i)
            trace(items.numChildren)
        }
        private function clear():void{
            while (items.numChildren>0){
                items.removeChildAt(0)
            }
        }
        private function VertBarDown(e:MouseEvent):void{
            _barScroll=2
            _barScrollY=_vertBar.mouseY
            
        }
        private function VertBarRollOver(e:MouseEvent):void{_vertBar.alpha=1}
        private function VertBarRollOut(e:MouseEvent):void{_vertBar.alpha=0.8}
    }
}