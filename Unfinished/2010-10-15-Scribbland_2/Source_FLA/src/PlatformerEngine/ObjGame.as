package src.PlatformerEngine{
    import src.IResetable;
    import src.IUpdatable;

    public class ObjGame implements IUpdatable{
        protected var _removed:Boolean = false;
        
        public    function update():void{}
        protected function add()   :void{}
        protected function remove():void{
            if (_removed){ return; }
            
            _removed = true;
            
            Obs.objectRemove(this);
        }
    }
}