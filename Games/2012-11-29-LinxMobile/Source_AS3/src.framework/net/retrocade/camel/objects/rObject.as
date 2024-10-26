package net.retrocade.camel.objects{
    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.rGroup;
    import net.retrocade.camel.interfaces.rIUpdatable;

    public class rObject implements rIUpdatable{
        /**
         * If false object is not automatically updated 
         */
        public var active:Boolean = true;
        
        public function update():void{}
        
        
        
        
        /****************************************************************************************************************/
        /**                                                                                        ADDING AND REMOVING  */
        /****************************************************************************************************************/
        
        public function get defaultGroup():rGroup{
            return rCore.currentState.defaultGroup;
        }
        
        final public function addDefault():void{
            defaultGroup.add(this);
        }
        
        final public function addAtDefault(index:uint):void {
            defaultGroup.addAt(this, index);
        }
        
        final public function nullifyDefault():void{
            defaultGroup.nullify(this);
        }
        
        final public function removeDefault():void{
            defaultGroup.remove(this);
        }
    }
}