package net.retrocade.camel.global {
    import flash.display.DisplayObject;
    import flash.display.Sprite;

    import net.retrocade.camel.interfaces.rIWindow;
    import net.retrocade.camel.layers.rLayerFlashSprite;
    import net.retrocade.camel.layers.rLayerStarling;

    import starling.display.DisplayObject;

    use namespace retrocamel_int;

    public class rWindows extends Sprite {
        /**
         * Array containing all currently displayed windows
         */
        private static var _windows:Vector.<rIWindow> = new Vector.<rIWindow>();
        private static var _starlingLayer:rLayerStarling;
        private static var _flashLayer:rLayerFlashSprite;
        /**
         * True if there is a window which should pause the game
         */
        private static var _pauseGame:Boolean = false;
        private static var _isBlocking:Boolean = false;

        public static function get numWindows():int {
            return _windows.length;
        }

        /**
         * True if there is a window which should pause the game
         */
        public static function get pauseGame():Boolean {
            return _pauseGame;
        }

        public static function get isBlocking():Boolean {
            return _isBlocking;
        }

        public static function hookStarlingLayer(layer:rLayerStarling):void {
            _starlingLayer = layer;
        }

        public static function hookFlashLayer(layer:rLayerFlashSprite):void {
            _flashLayer = layer;
        }

        /**
         * Removes last added window
         */
        public static function removeLastWindow():void {
            var l:uint = _windows.length;
            if (l == 0) {
                return;
            }

            _windows[l - 1].hide();
        }

        /**
         * Removes all windows
         */
        public static function clearWindows():void {
            while (_windows.length) {
                removeLastWindow();
            }
        }

        /**
         * Updates windows related stuff to
         */
        private static function validateWindowsNow():void {
            _isBlocking = false;
            var window:rIWindow;
            _pauseGame = false;

            for (var i:int = _windows.length - 1; i >= 0; --i) {
                window = _windows[i];
                if (_isBlocking) {
                    window.block();

                } else {
                    window.unblock();
                }

                _pauseGame = window.pauseGame || _pauseGame;
                _isBlocking = window.blockUnder || _isBlocking;
            }

            if (_isBlocking || _pauseGame) {
                rDisplay.block();
            } else {
                rDisplay.unblock();
            }

            if (_starlingLayer) {
                _starlingLayer.inputEnabled = true;
            }
            if (_flashLayer) {
                _flashLayer.inputEnabled = true;
            }
        }

        /**
         * @private
         * Adds given window to the display
         * @param window Window to be added
         */
        retrocamel_int static function addWindow(window:rIWindow):void {
            if (_windows.indexOf(window) != -1) {
                return;
            }

            if (window is flash.display.DisplayObject) {
                _flashLayer.add(window as flash.display.DisplayObject);
            } else if (window is starling.display.DisplayObject) {
                _starlingLayer.add(window as starling.display.DisplayObject);
            }

            _windows.push(window);
            validateWindowsNow();
        }

        /**
         * @private
         * Removes given window from the display
         * @param window Window to be removed
         */
        retrocamel_int static function removeWindow(window:rIWindow):void {
            var index:uint = _windows.indexOf(window);

            if (index == -1) {
                return;
            }

            if (window is flash.display.DisplayObject) {
                _flashLayer.remove(window as flash.display.DisplayObject);
            } else if (window is starling.display.DisplayObject) {
                _starlingLayer.remove(window as starling.display.DisplayObject);
            }

            _windows.splice(index, 1);
            validateWindowsNow();
        }

        retrocamel_int static function pushLayersToFront():void {
            if (_flashLayer) {
                rDisplay.pullLayerToFront(_flashLayer);
            }

            if (_starlingLayer) {
                rDisplay.pullLayerToFront(_starlingLayer);
            }
        }

        retrocamel_int static function update():void {
            if (!_windows.length) {
                return;
            }

            var window:rIWindow;
            for (var i:int = _windows.length - 1; i >= 0; --i) {
                window = _windows[i];

                if (!window.isBlocked()) {
                    window.update();
                }
            }
        }

        retrocamel_int static function onStageResize():void {
            for each(var window:rIWindow in _windows) {
                if (window) {
                    window.resize();
                }
            }
        }
    }
}