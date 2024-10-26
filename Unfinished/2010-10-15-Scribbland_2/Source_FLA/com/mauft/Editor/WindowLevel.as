package com.mauft.Editor{
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    
    public class WindowLevel extends Sprite{
        internal static var brushLayer:Sprite
        
        private var _layers:Sprite
        private var _horiBar:Sprite
        private var _vertBar:Sprite
        private var _dispW:Number
        private var _dispH:Number
        
        private var _barScroll:uint=0
        private var _barScrollX:uint=0
        private var _barScrollY:uint=0
        
        private var draw:Boolean=false
        public function WindowLevel(){
            x=284
            y=184
            
            _dispW=Editor.stage.stageWidth-300
            _dispH=Editor.stage.stageHeight-300

            graphics.beginFill(0x444444)
            graphics.drawRect(_dispW, 0, 16, _dispH)
            graphics.drawRect(0, _dispH, _dispW, 16)

            var s:Shape=new Shape()
            s.graphics.beginFill(0);
            s.graphics.drawRect(0, 0, _dispW, _dispH);
            s.graphics.endFill();
            
            _layers=new Sprite
            _layers.graphics.beginFill(0xFFFFFF)
            _layers.graphics.drawRect(0, 0, Editor.tileW*Editor.levelW, Editor.tileH*Editor.levelH)
            _layers.mask=s
            addChild(s)
            
            s=new Shape()
            s.graphics.beginFill(0);
            s.graphics.drawRect(0, 0, _dispW, _dispH);
            s.graphics.endFill();
            addChild(s)
            
            brushLayer=new Sprite
            brushLayer.mask=s
            brushLayer.mouseEnabled=false
            brushLayer.mouseChildren=false
            
            _horiBar=new Sprite
            _vertBar=new Sprite
            _horiBar.graphics.beginFill(0xAAAAAA)
            _horiBar.graphics.drawRect(0, _dispH, _dispW*_dispW/(Editor.levelW*Editor.tileW), 16)
            _vertBar.graphics.beginFill(0xAAAAAA)
            _vertBar.graphics.drawRect(_dispW, 0, 16, _dispH*_dispH/(Editor.levelH*Editor.tileH))
            
            _horiBar.alpha=0.8
            _vertBar.alpha=0.8
            _horiBar.addEventListener(MouseEvent.ROLL_OVER, HoriBarRollOver)
            _horiBar.addEventListener(MouseEvent.ROLL_OUT, HoriBarRollOut)
            _horiBar.addEventListener(MouseEvent.MOUSE_DOWN, HoriBarDown)
            _vertBar.addEventListener(MouseEvent.ROLL_OVER, VertBarRollOver)
            _vertBar.addEventListener(MouseEvent.ROLL_OUT, VertBarRollOut)
            _vertBar.addEventListener(MouseEvent.MOUSE_DOWN, VertBarDown)
            _horiBar.buttonMode=true
            _vertBar.buttonMode=true
            
            addChild(_horiBar)
            addChild(_vertBar)
            
            addChild(_layers)
            addChild(brushLayer)
            
            _layers.mouseChildren=false
            _layers.mouseEnabled=true
            _layers.addEventListener(MouseEvent.MOUSE_DOWN, function():void{WindowOptions.pen.MouseDown()})
            _layers.addEventListener(MouseEvent.MOUSE_UP, function():void{WindowOptions.pen.MouseUp()})
        }
        internal function Step():void{
            if ((Pen.brush && Pen.brush.forceGrid) || (WindowOptions.currentLayer && WindowOptions.currentLayer.gridForced)){
                var tX:uint=Math.floor(_layers.mouseX/WindowOptions.currentLayer.gridWidth)*WindowOptions.currentLayer.gridWidth
                var tY:uint=Math.floor(_layers.mouseY/WindowOptions.currentLayer.gridHeight)*WindowOptions.currentLayer.gridHeight
                WindowOptions.pen.Step(tX, tY)
            } else {
                WindowOptions.pen.Step(_layers.mouseX, _layers.mouseY)
            }
            switch(_barScroll){
                case(1):
                    _horiBar.x+=_horiBar.mouseX-_barScrollX
                    _layers.x=-(_horiBar.x*(Editor.levelW*Editor.tileW-_dispW))/(_dispW-_horiBar.width)
                    scroll(0,0)
                    break;
                case(2):
                    _vertBar.y+=_vertBar.mouseY-_barScrollY
                    _layers.y=-(_vertBar.y*(Editor.levelH*Editor.tileH-_dispH))/(_dispH-_vertBar.height)
                    scroll(0,0)
                    break;
            }
        }
        internal function Start():void{
            Editor.stage.addEventListener(MouseEvent.MOUSE_UP, MouseUp)
        }
        internal function End():void{
            Editor.stage.removeEventListener(MouseEvent.MOUSE_UP, MouseUp)    
        }
        
        
        internal function newLayer(lay:Layer):void{
            _layers.addChild(lay.display)
        }
        internal function scroll(_x:int, _y:int):void{
            _layers.x-=_x
            _layers.y-=_y
            if (_layers.x>0){_layers.x=0}
            if (_layers.x<-Editor.levelW*Editor.tileW+_dispW){_layers.x=-Editor.levelW*Editor.tileW+_dispW}
            if (_layers.y>0){_layers.y=0}
            if (_layers.y<-Editor.levelH*Editor.tileH+_dispH){_layers.y=-Editor.levelH*Editor.tileH+_dispH}
            //brushLayer.mask.x=_layers.mask.x=-_layers.x
            //brushLayer.mask.y=_layers.mask.y=-_layers.y
            brushLayer.x=_layers.x
            brushLayer.y=_layers.y
            _horiBar.x=(_dispW-_horiBar.width)*(-_layers.x/(Editor.levelW*Editor.tileW-_dispW))
            _vertBar.y=(_dispH-_vertBar.height)*(-_layers.y/(Editor.levelH*Editor.tileH-_dispH))
        }
        
        
        private function MouseUp(e:MouseEvent):void{
            _barScroll=0
            WindowItems._barScroll=0
        }
        private function HoriBarDown(e:MouseEvent):void{
            _barScroll=1
            _barScrollX=_horiBar.mouseX
            
        }
        private function VertBarDown(e:MouseEvent):void{
            _barScroll=2
            _barScrollY=_vertBar.mouseY
            
        }
        private function HoriBarRollOver(e:MouseEvent):void{_horiBar.alpha=1}
        private function HoriBarRollOut(e:MouseEvent):void{_horiBar.alpha=0.8}
        private function VertBarRollOver(e:MouseEvent):void{_vertBar.alpha=1}
        private function VertBarRollOut(e:MouseEvent):void{_vertBar.alpha=0.8}
    }
}