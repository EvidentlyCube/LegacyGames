package src.Objects{
    import src.GFX;
    import src.IResetable;
    import src.PlatformerEngine.Geometry;
    import src.PlatformerEngine.Gfx;
    import src.PlatformerEngine.Level;
    import src.PlatformerEngine.ObjDisplay;
    import src.PlatformerEngine.Obs;
    import src.tiles.TPlatform;

    public class Bonus extends ObjDisplay implements IResetable{
        
        protected var _wiggle      :Number;
        protected var _wiggleSpeed :Number;
        protected var _wiggleHeight:Number;
        
        protected var _startX      :int;
        protected var _startY      :int;
        
        protected var _canUndo     :Boolean = true;
        
        protected var _width       :int;
        protected var _height      :int;
        
        public function Bonus(startX:Number, startY:Number, width:int, height:int){
            _wiggle       = Math.random() * 360;
            _wiggleSpeed  = (5 + Math.random() * 15) * (Math.random() < 0.5 ? 1 : -1);
            _wiggleHeight = 1 + Math.random() * 3;
            
            _startX = startX;
            _startY = startY;
            _width  = width;
            _height = height;
            
            Obs.objectAdd(this);
            
            Gfx.frontAdd(_gfx);
        }
        
        override public function update():void{
            if (_removed)
                return;
            
            y = _startY + Math.sin(_wiggle += _wiggleHeight) * _wiggleHeight;
            
            var player:TPlayer = Obs.player;
             
            if (Geometry.RectRect(_startX, _startY, _width, _height, player.x, player.y, player.width, player.height))
                collect();
        }
        
        public function stateCheckpoint():void{
            if (_removed)
                _canUndo = false;
        }
        
        public function stateDeath():void{
            if (!_canUndo)
                return;
            
            if (_removed)
                undo();
        }
        
        public function stateRestart():void{
            if (_removed)
                Gfx.frontAdd(_gfx);
            
            _removed = false;
            _canUndo = true;
        }
        
        public function collect():void{
            Gfx.frontRemove(_gfx);
            _removed = true;
        }
        
        public function undo():void{
            Gfx.frontAdd(_gfx);
            _removed = false;
        }
    }
}