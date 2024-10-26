package{
    import game.data.TPath;
    import game.global.Level;
    
    import net.retrocade.camel.global.rSfx;
    
    public class UndoStep{
        private var _actions:Array = [];
        
        public function add(x:uint, y:uint):void{
            _actions.push(new UndoEntry(x, y, 0, false));
        }
        
        public function remove(x:uint, y:uint, tileColor:uint):void{
            _actions.push(new UndoEntry(x, y, tileColor, true));
        }
        
        public function undo():void{
            rSfx.suppressSounds = true;
            
            var entry:UndoEntry;
            var item:*;
            
            var i:int = _actions.length;
            
            while (i--){
                entry = _actions[i];
                if (!entry.remove){
                    item = Level.level.get(entry.x, entry.y);
                    
                    if (item is TPath){
                        TPath(item).removePath();
                    }
                } else {
                    new TPath(entry.x, entry.y, entry.tileColor);
                }
            }
            
            rSfx.suppressSounds = false;
        }
        
        public function countChanges():uint{
            return _actions.length;
        }
    }
}

class UndoEntry{
    public var x:uint;
    public var y:uint;
    public var tileColor:uint;
    public var remove:Boolean;
    
    public function UndoEntry(x:uint, y:uint, tileColor:uint, remove:Boolean){
        this.x = x;
        this.y = y;
        this.tileColor = tileColor;
        this.remove = remove;
    }
}