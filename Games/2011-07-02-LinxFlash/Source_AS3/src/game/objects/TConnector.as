package game.objects{
    public class TConnector extends TGameObject{
        protected var _color:uint = 0;
        
        public var allConnected:Boolean = false;
            
        
        public function get color():uint{
            return _color;
        }
        
        public function resetGfx():void{}
        
    }
}