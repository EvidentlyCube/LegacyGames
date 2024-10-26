package com.mauft.Display.Buttons{
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.ColorTransform;
    
    public class ButtonBrightness extends AbstractButton{
        private var cT:ColorTransform = transform.colorTransform;
        
        private var _brightTo   :Number = 0;
        private var _brightNow  :Number = 0;
        
        protected var _brightness :Number = 20;
        protected var _speed      :Number = 8;
        protected var _selectedAdd:Number = 40;
        public function ButtonBrightness(){
            _canInstantiate = true;
            super();
        }
        
        override protected function step(e:Event):void{
            if (_brightTo + _selectedAdd*_selected > _brightNow){
                _brightNow += _speed;
                
                if (_brightTo + _selectedAdd*_selected < _brightNow){
                    _brightNow = _brightTo + _selectedAdd*_selected;
                }
                
            } else if (_brightTo + _selectedAdd*_selected < _brightNow){
                _brightNow -= _speed;
                
                if (_brightTo + _selectedAdd*_selected > _brightNow){
                    _brightNow = _brightTo + _selectedAdd*_selected;
                }
                
            } else {
                return;
                
            }
            
            cT.blueOffset  = _brightNow;
            cT.redOffset   = _brightNow;
            cT.greenOffset = _brightNow;
            
            transform.colorTransform = cT;
        }
        override protected function rollOut(e:MouseEvent):void{
            _brightTo = 0;
        }
        override protected function rollOver(e:MouseEvent):void{
            _brightTo = _brightness;
        }
        override protected function click(e:MouseEvent):void{
            _selected = 1 - _selected;
        }
    }
}