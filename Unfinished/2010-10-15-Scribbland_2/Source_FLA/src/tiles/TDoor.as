package src.tiles{
    import flash.display.MovieClip;
    
    import src.IResetable;
    import src.IUpdatable;
    import src.PlatformerEngine.Gfx;
    import src.PlatformerEngine.Level;
    import src.PlatformerEngine.ObjInteractive;
    import src.PlatformerEngine.Obs;
    import src.PlatformerEngine.Tile;
    
    public class TDoor extends TWall implements IResetable, IUpdatable{
        
        protected var _width :int;
        protected var _height:int;
        
        protected var _removed:Boolean = false;
        protected var _canundo:Boolean = true;
        
        protected var _gfx:MovieClip
        
        public function TDoor(x:uint, y:uint, gfx:MovieClip, width:int, height:int){
            _gfx = gfx;
            
            _width  = width;
            _height = height;
            
            addDoor();
            
            Obs.objectAdd(this);
            
            Gfx.frontAdd(_gfx);
            
            super(x, y);
        }
        
        public function stateCheckpoint():void{
            if (!_canundo)
                return;
            
            trace("Door Checkpoint");
            
            if (_removed)
                _canundo = false;
            
        }
        
        public function stateDeath():void{
            if (!_canundo)
                return;
            
            if (_removed){
                _removed = false;
                Level.keys.add(1);
                addDoor();
            }
            
            visible = true;
        }
        
        public function stateRestart():void{
            if (_removed){
                visible = true;
                _removed = false;
                _canundo = true;
                addDoor();
            }
        }
        
        public function update():void{
            if (_removed && _gfx.alpha > 0)
                _gfx.alpha -= 0.05;
            
            else if (!_removed && _gfx.alpha < 1)
                _gfx.alpha += 0.05;
                
        }
        
        override public function pokedLeft(x:Number, y:Number, top:Boolean, o:ObjInteractive):Boolean{
            if (!_removed && !checkKey())
                return super.pokedLeft(x, y, top, o);
            
            return false;
        }
        
        override public function pokedRight(x:Number, y:Number, top:Boolean, o:ObjInteractive):Boolean{
            if (!_removed && !checkKey())
                return super.pokedRight(x, y, top, o);
            
            return false;
        }
        
        override public function headbutt(x:Number, y:Number, left:Boolean, o:ObjInteractive):Boolean{
            if (!_removed && !checkKey())
                return super.headbutt(x, y, left, o);
            
            return false;
        }
        
        override public function stomp(x:Number, y:Number, left:Boolean, o:ObjInteractive):Boolean{
            if (!_removed && !checkKey())
                return super.stomp(x, y, left, o);
            
            return false;
        }
        
        /**
         * @return True if the door becomes open 
         */
        protected function checkKey():Boolean{
            trace("Got keys: " + Level.keys.get());
            if (!Level.keys.get())
                return false;
            
            Level.keys.add(-1);
            removeDoor();
            _removed = true;
            return true;
        }
        
        protected function addDoor():void{
            var i:int;
            var j:int;
            
            for (i = 0; i < _width; i++)
                for (j = 0; j < _height; j++)
                    Level.tileColliderSet(_x / 30 + i, _y / 30 + j, this);
        }
        
        protected function removeDoor():void{
            var i:int;
            var j:int;
            
            for (i = 0; i < _width; i++)
                for (j = 0; j < _height; j++)
                    Level.tileColliderSet(_x / 30 + i, _y / 30 + j, null);
        }
    }
}