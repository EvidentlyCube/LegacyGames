package net.retrocade.camel.global{
    import flash.display.Sprite;

    import net.retrocade.camel.global.retrocamel_int;
    import net.retrocade.camel.objects.rWindow;

    use namespace retrocamel_int;

    public class rWindows extends Sprite{
        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /**********************************************************************e******************************************/

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Array of windows
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Array containing all currently displayed windows
         */
        private static var _windows  :Array = [];




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Windows pause game
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * True if there is a window which should pause the game
         */
        private static var _pauseGame:Boolean = false;

        /**
         * True if there is a window which should pause the game
         */
        public static function get pauseGame():Boolean{
            return _pauseGame;
        }




        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Internal windows adding/removing
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * @private
         * Adds given window to the display
         * @param window Window to be added
         */
        retrocamel_int static function addWindow(window:rWindow):void{
            if (_windows.indexOf(window) != -1)
                return;
            
            _windows.push(window);
            rDisplay._windows.addChild(window);
            validateWindowsNow();
        }

        /**
         * @private
         * Removes given window from the display
         * @param window Window to be removed
         */
        retrocamel_int static function removeWindow(window:rWindow):void{
            var index:uint = _windows.indexOf(window);
            if (index == -1)
                return;

            rDisplay._windows.removeChild(window);

            _windows.splice(index, 1);
            validateWindowsNow();
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Public windows removing
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Removes last added window
         */
        public static function removeLastWindow():void{
            var l:uint = _windows.length;
            if (l == 0)
                return;

            rWindow(_windows[l - 1]).close();
        }

        /**
         * Removes all windows
         */
        public static function clearWindows():void{
            while (_windows.length)
                removeLastWindow();
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Private stuff
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Updates windows related stuff to
         */
        private static function validateWindowsNow():void{
            var blockWindows:Boolean = false;
            var window      :rWindow;
            _pauseGame = false;

            for (var i:int = _windows.length - 1; i >= 0; --i){
                window = _windows[i];

                if (blockWindows){
                    window.block();

                } else {
                    window.unblock();
                }

                _pauseGame   = window.pauseGame  || _pauseGame;
                blockWindows = window.blockUnder || blockWindows;
            }

            if (blockWindows || _pauseGame)
                rDisplay.block();
            else
                rDisplay.unblock();
        }

        retrocamel_int static function update():void{
            if (!_windows.length)
                return;

            var window:rWindow;
            for (var i:int = _windows.length - 1; i >= 0; --i){
                window = _windows[i];

                if (!window.isBlocked())
                    window.update();
            }
        }

    }
}