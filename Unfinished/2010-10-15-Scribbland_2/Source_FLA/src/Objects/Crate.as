package src.Objects{
    
    import flash.display.MovieClip;
    
    import src.IResetable;
    import src.IUpdatable;
    import src.PlatformerEngine.Geometry;
    import src.PlatformerEngine.Gfx;
    import src.PlatformerEngine.ObjInteractive;
    import src.PlatformerEngine.Obs;
    import src.PlatformerEngine.Settings;

    public class Crate extends ObjInteractive implements IUpdatable, IResetable{
        public static function __pokeLeft(_x:Number, _y:Number, _top:Boolean, _o:ObjInteractive):Boolean{
            for each (var i:Crate in Obs.crates){
                if (i != _o && Geometry.RectRect(i.x, i.y, i.width, i.height, _x, _y, 1, 1)){
                    i.movedRight(_o);
                    return true;
                }
            }
            return false;
        }
        
        public static function __pokeRight(_x:Number, _y:Number, _top:Boolean, _o:ObjInteractive):Boolean{
            for each (var i:Crate in Obs.crates){
                if (i != _o && Geometry.RectRect(i.x, i.y, i.width, i.height, _x, _y, 1, 1)){
                    i.movedLeft(_o);
                    return true;
                }
            }
            return false;
        }
        
        public static function __stomp(_x:Number, _y:Number, _top:Boolean, _o:ObjInteractive):Boolean{
            for each (var i:Crate in Obs.crates){
                if (i != _o && Geometry.RectRect(i.x, i.y, i.width, i.height, _x, _y, 1, 1)){
                    i.movedDown(_o);
                    return true;
                }
            }
            return false;
        }
        
        public static function __headbutt(_x:Number, _y:Number, _top:Boolean, _o:ObjInteractive):Boolean{
            for each (var i:Crate in Obs.crates){
                if (i != _o && Geometry.RectRect(i.x, i.y, i.width, i.height, _x, _y, 1, 1)){
                    i.movedUp(_o);
                    return true;
                }
            }
            return false;
        }
        
        /**
         * Starting X position 
         */
        private var _stateStartX       :int;
        
        /**
         * Starting Y position 
         */
        private var _stateStartY       :int;
        
        /**
         * X position in last checkpoint
         */
        private var _stateLastX        :int;
        
        /**
         * Y position in last checkpoint
         */
        private var _stateLastY        :int;
        
        /**
         * Horizontal Speed in last checkpoint
         */
        private var _stateLastSpeedH   :int;
        
        /**
         * Vertical Speed in last checkpoint
         */
        private var _stateLastSpeedV   :int;
        
        public function Crate(x:Number, y:Number, gfx:MovieClip, width:int, height:int){
            this.x       = x;
            this.y       = y;
            this._width  = width;
            this._height = height;
            this._gfx    = gfx;
            
            _stateStartX = x;
            _stateStartY = y;
            
            Gfx.frontAdd(_gfx);
            Obs.crateAdd(this);
        }
        
        override public function update():void{
            _speedv += Settings.GRAVITY;
            
            push();
            
            _gfx.x   = x;
            _gfx.y   = y;
        }
        
        private function movedRight(o:ObjInteractive):void{
            o.pushesCrate();
            
            var canPush:Boolean = true;
            for each(var i:ObjInteractive in Obs.blockObjects){
                if (i != o && Geometry.RectRect(i.x + 1, i.y, i.width, i.height, x, y, width, height)){
                    canPush = false;
                    break;
                }
            }
            
            if (o.isOnFloor && canPush){
                _speedh  = 1;
                push();
                _speedh  = 0;
                
                o.modifySpeedH(1, 0);
                
            } else {
                o.modifySpeedH(0, 0);
            }     
            
            o.xRight = x - 1;

        }
        
        private function movedLeft(o:ObjInteractive):void{
            o.pushesCrate();
            
            var canPush:Boolean = true;
            for each(var i:ObjInteractive in Obs.blockObjects){
                if (i != o && Geometry.RectRect(i.x - 1, i.y, i.width, i.height, x, y, width, height)){
                    canPush = false;
                    break;
                }
            }
            
            if (o.isOnFloor && canPush){
                _speedh  = -1;
                push();
                _speedh  = 0;
                
                o.modifySpeedH(-1, 0);
                
            } else {
                o.modifySpeedH(0, 0);
            }
            
            o.x = xRight + 1;
        }
        
        private function movedDown(o:ObjInteractive):void{
            o.yRight = y - 1;
            o.stomp();
            
            if (o is TGraphicCollider)
                TGraphicCollider(o).forceHigher = true;
        }
        
        private function movedUp(o:ObjInteractive):void{
            _speedv += o.speedv/3;
            o.y      = yRight + 1;
            
            o.headButt();
            o.modifySpeedV(0, 0);
            
        }
        
        override protected function movedV():void{
            for each(var i:ObjInteractive in Obs.blockObjects){
                while (Geometry.RectRect(i.x, i.y, i.width, i.height, x, y, width, height)){
                    y--;
                    _speedv = 0;
                }
            }
        }
        
        override public function stomp():void{
            _speedv   = 0;
            _speedh   = 0;
            _standing = true;
        }
        
        public function stateCheckpoint():void{
            _stateLastX = x;
            _stateLastY = y;
            _stateLastSpeedH = _speedh;
            _stateLastSpeedV = _speedv;
        }
        
        public function stateDeath():void{
            x = _stateLastX;
            y = _stateLastY;
            _speedh = _stateLastSpeedH;
            _speedv = _stateLastSpeedV;
            
            _gfx.x = x;
            _gfx.y = y;
        }
        
        public function stateRestart():void{
            x = _stateStartX;
            y = _stateStartY;
            
            _gfx.x = x;
            _gfx.y = y;
            _speedh = 0;
            _speedv = 0;
        }
    }
}