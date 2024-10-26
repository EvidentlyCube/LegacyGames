package net.retrocade.camel.objects{
    import flash.geom.Rectangle;
    
    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.camel.global.rWindows;
    import net.retrocade.camel.global.retrocamel_int;
    import net.retrocade.camel.interfaces.rIWindow;
    import net.retrocade.starling.rStarling;
    
    import starling.display.Sprite;

    use namespace retrocamel_int;

    /**
     * ...
     * @author Maurycy Zarzycki
     */
    public class rWindowStarling extends Sprite implements rIWindow{
        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

        /**
         * Should this window block input to all underlying windows?
         */
        protected var _blockUnder:Boolean = true;

        public function get blockUnder():Boolean{
            return _blockUnder;
        }

        /**
         * Should the game be paused when this window is displayed?
         */
        protected var _pauseGame :Boolean = true;

        public function get pauseGame():Boolean{
            return _pauseGame;
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Helpers
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * HELPER: Value of touchab;e before block
         */
        private var _lastTouchable:Boolean = true;

        private var _isBlocked        :Boolean = false;

        public function isBlocked():Boolean {
            return _isBlocked;
        }



        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        /**
         * Adds the window to display and show it
         */
        public function show():void{
            rWindows.addWindow(this);
        }

        /**
         * Remove the window from the display
         */
        public function hide():void{
            rWindows.removeWindow(this);
        }

        public function resize():void{}

        /**
         * Called by windows manager when window above it blocks this one
         */
        public function block():void{
            if (_isBlocked)
                return;

            _isBlocked = true;
            _lastTouchable = touchable;
            
            touchable = false;
        }

        public function unblock():void{
            _isBlocked = false;
            touchable = _lastTouchable
        }

        public function update():void{}
    }
}