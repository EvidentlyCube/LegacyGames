package net.retrocade.camel.global{
    import flash.events.EventDispatcher;

    public class rState extends EventDispatcher{
        protected var _defaultGroup:rGroup;
        
        public function get defaultGroup():rGroup{
            return _defaultGroup;
        }
        
        public function rState(){
            _defaultGroup = new rGroup
        }
        
        
        
        /****************************************************************************************************************/
        /**                                                                                                  OVERRIDES  */
        /****************************************************************************************************************/   
        
        /**
         * Called when state is set 
         */
        public function create():void{
            resize();
        }
        
        /**
         * Called when state is unset 
         */
        public function destroy():void{
            _defaultGroup.clear();
        }
        
        /**
         * State update 
         */
        public function update():void{
            _defaultGroup.update();
        }

        public function resize():void{

        }
        
        /**
         * Sets this state, useful when you are working with State Instance variable
         */
        final public function set():void{
            rCore.setState(this);
        }
    }
}