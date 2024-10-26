package net.retrocade.camel.objects{
    import flash.display.BlendMode;
    import flash.display.Sprite;
    import flash.geom.Rectangle;

    import net.retrocade.camel.global.retrocamel_int;
    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.camel.global.rWindows;

    use namespace retrocamel_int;

    /**
     * ...
     * @author Maurycy Zarzycki
     */
    public class rWindow extends Sprite{
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
         * HELPER: Value of mouseChildren before block
         */
        private var _lastMouseChildren:Boolean = true;

        /**
         * HELPER: Value of mouseEnabled before block
         */
        private var _lastMouseEnabled :Boolean = true;

        private var _isBlocked        :Boolean = false;

        retrocamel_int function isBlocked():Boolean {
            return _isBlocked;
        }



        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/
        public function rWindow(){
            super();

            blendMode = BlendMode.LAYER;
        }

        /**
         * Adds the window to display and show it
         */
        public function show():void{
            rWindows.addWindow(this);
        }

        /**
         * Remove the window from the display
         */
        public function close():void{
            rWindows.removeWindow(this);
        }

        /**
         * Called by windows manager when window above it blocks this one
         */
        public function block():void{
            if (_isBlocked)
                return;

            _isBlocked         = true;
            _lastMouseChildren = mouseChildren;
            _lastMouseEnabled  = mouseEnabled;

            mouseChildren = false;
            mouseEnabled  = false;
        }

        public function unblock():void{
            _isBlocked    = false;
            mouseChildren = _lastMouseChildren;
            mouseEnabled  = _lastMouseEnabled;
        }

        public function center():void{
            var bounds:Rectangle = getBounds(rDisplay.application);

            x = (rCore.settings.gameWidth  - width)  / 2 + (x - bounds.x) | 0;
            y = (rCore.settings.gameHeight - height) / 2 + (y - bounds.y) | 0;
        }

        public function update():void{}
    }
}