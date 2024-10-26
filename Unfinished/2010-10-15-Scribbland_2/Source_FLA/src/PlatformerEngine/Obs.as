package src.PlatformerEngine{
    import src.IResetable;
    import src.IUpdatable;
    import src.Objects.Crate;
    import src.Objects.TPlayer;
    
    public class Obs{
        private static var _player       :TPlayer;
        
        private static var _objects      :Array = new Array;
        private static var _blockObjects :Array = new Array;
        private static var _crates       :Array = new Array;
        private static var _effects      :Array = new Array;
        
        public static function updateAll():void{
            var o:ObjGame;
            var i:int;
            
            for (i = _objects.length - 1; i >= 0; i--){
                IUpdatable(_objects[i]).update();
            }
            
            for (i = _blockObjects.length - 1; i >= 0; i--){
                IUpdatable(_blockObjects[i]).update();
            }  
            
            for (i = _crates.length - 1; i >= 0; i--){
                ObjGame(_crates[i]).update();
            }
            
            for (i = _effects.length - 1; i >= 0; i--){
                ObjGame(_effects[i]).update();
            }
        }
        
        public static function get player():TPlayer{
            return _player;
        }
        
        public static function set player(p:TPlayer):void{
            _player = p;
        }
        
        public static function objectAdd(obj:IUpdatable):void{
            _objects.push(obj);
        }
        
        public static function objectRemove(obj:IUpdatable):void{
            _objects.splice(_objects.indexOf(obj), 1);
        }
        
        public static function blockObjectAdd(obj:IUpdatable):void{
            _blockObjects.push(obj);
        }
        
        public static function blockObjectRemove(obj:IUpdatable):void{
            _blockObjects.splice(_blockObjects.indexOf(obj), 1);
        }
        
        public static function crateAdd(obj:Crate):void{
            _crates.push(obj);
        }
        
        public static function crateRemove(obj:Crate):void{
            _crates.splice(_crates.indexOf(obj), 1);
        }
        
        public static function effectAdd(obj:ObjDisplay):void{
            _effects.push(obj);
        }
        
        public static function effectRemove(obj:ObjDisplay):void{
            _effects.splice(_effects.indexOf(obj), 1);
        }
        
        public static function stateCheckpoint():void{
            var o:*;
            var i:int;
            
            for (i = _objects.length - 1; i >= 0; i--){
                o = _objects[i];
                if (o as IResetable){
                    IResetable(o).stateCheckpoint();
                }
            }
            
            for (i = _blockObjects.length - 1; i >= 0; i--){
                o = _blockObjects[i];
                if (o as IResetable){
                    IResetable(o).stateCheckpoint();
                }
            }  
            
            for (i = _crates.length - 1; i >= 0; i--){
                o = _crates[i];
                if (o as IResetable){
                    IResetable(o).stateCheckpoint();
                }
            }
        }
        
        public static function stateDeath():void{
            var o:*;
            var i:int;
            
            for (i = _objects.length - 1; i >= 0; i--){
                o = _objects[i];
                if (o as IResetable){
                    IResetable(o).stateDeath();
                }
            }
            
            for (i = _blockObjects.length - 1; i >= 0; i--){
                o = _blockObjects[i];
                if (o as IResetable){
                    IResetable(o).stateDeath();
                }
            }  
            
            for (i = _crates.length - 1; i >= 0; i--){
                o = _crates[i];
                if (o as IResetable){
                    IResetable(o).stateDeath();
                }
            }
        }
        
        public static function stateRestart():void{
            var o:*;
            var i:int;
            
            for (i = _objects.length - 1; i >= 0; i--){
                o = _objects[i];
                if (o as IResetable){
                    IResetable(o).stateRestart();
                }
            }
            
            for (i = _blockObjects.length - 1; i >= 0; i--){
                o = _blockObjects[i];
                if (o as IResetable){
                    IResetable(o).stateRestart();
                }
            }  
            
            for (i = _crates.length - 1; i >= 0; i--){
                o = _crates[i];
                if (o as IResetable){
                    IResetable(o).stateRestart();
                }
            }
        }
        
        public static function get crates()      :Array{ return _crates;       }
        public static function get blockObjects():Array{ return _blockObjects; }
    }
}