package net.retrocade.camel.effects {
    import flash.display.DisplayObject;
    import net.retrocade.camel.core.rGroup;
    /**
     * ...
     * @author 
     */
    public class rEffMove extends rEffect {
        private var _xFrom:Number;
        private var _yFrom:Number;
        
        private var _xTo  :Number;
        private var _yTo  :Number;
        
        private var _toMove:DisplayObject;
        
        public function rEffMove(toMove:DisplayObject, toX:Number, toY:Number, duration:uint = 200, 
                                 callback:Function = null, addTo:rGroup = null){
            super(duration, callback, addTo);
            
            _toMove = toMove;
            
            _xFrom  = toMove.x;
            _yFrom  = toMove.y;
            
            _xTo    = toX;
            _yTo    = toY;
        }        
        
        override public function update():void {
            if (_blocked) return blockUpdate();
            
            var int:Number = interval;
            
            _toMove.x = _xFrom + (_xTo - _xFrom) * interval | 0;
            _toMove.y = _yFrom + (_yTo - _yFrom) * interval | 0;
            
            super.update();
        }
    }
}