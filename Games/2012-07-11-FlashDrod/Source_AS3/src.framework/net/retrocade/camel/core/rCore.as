package net.retrocade.camel.core{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.text.CSMSettings;
    import flash.text.FontStyle;
    import flash.text.TextColorType;
    import flash.text.TextRenderer;
    import flash.ui.Mouse;
    import flash.utils.Timer;
    import flash.utils.getTimer;
    import flash.utils.setInterval;
    import flash.utils.setTimeout;

    import net.retrocade.camel.rLang;
    import net.retrocade.utils.Rand;
    import net.retrocade.utils.UNumber;

    use namespace retrocamel_int;

    /**
     * ...
     * @author Maurycy Zarzycki
     */
    public class rCore{
        private static var __font__:Class;

        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Delta time
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Time spent since last step
         */
        private static var _deltaTime:Number = 0;

        /**
         * Time which passed since last step
         */
        public static function get deltaTime():Number{
            return _deltaTime;
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Global update groups
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Global updates group which is always updated before anything else
         */
        private static var _groupBefore:rGroup = new rGroup();

        /**
         * Retrieves global updates group which is always updated before everything else
         */
        public static function get groupBefore():rGroup{
            return _groupBefore;
        }

        /**
         * Global updates group which is always updated after anything else
         */
        private static var _groupAfter:rGroup = new rGroup();

        /**
         * Retrieves global updates group which is always updated after everything else
         */
        public static function get groupAfter():rGroup{
            return _groupAfter;
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Misc
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Time of last enter frame
         */
        private static var _lastTime:Number = 0;

        /**
         * The settings class
         */
        retrocamel_int static var _settings:*;


        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: State
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Currently displayed state
         */
        private static var _currentState:rState;

        /**
         * Retrieves current state
         */
        public static function get currentState():rState{
            return _currentState;
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: State
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Boolean indicating if the game is currently paused
         */
        private static var _paused:Boolean = false;

        /**
         * Accesses the flag indicating if game is paused or not
         */
        public static function get paused():Boolean{
            return _paused;
        }

        /**
         * @private
         */
        public static function set paused(value:Boolean):void{
            _paused = value;
        }

        public static var fpsSteadifier:Boolean = true;

        public static var errorCallback:Function;




        /****************************************************************************************************************/
        /**                                                                                           PUBLIC FUNCTIONS  */
        /****************************************************************************************************************/

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Initialization
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Initialzes the whole game
         */
        public static function init(stage:Stage, main:MovieClip, settingsClass:*):void {
            _settings = settingsClass;

            rLang     .initialize();
            rInput    .initialize(stage);
            rDisplay  .initialize(main, stage);

            stage.addEventListener(Event.ENTER_FRAME,      onEnterFrame);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);

            Rand.seed = Math.max((new Date).milliseconds, 1);
            Rand.om;
        }

        private static var t:Timer;


        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: State Manipulation
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Changes the current state
         * @param state State to be set
         */
        public static function setState(state:rState):void{
            if (_currentState)
                _currentState.destroy();

            _currentState = state;
            _currentState.create();
        }




        /****************************************************************************************************************/
        /**                                                                                          PRIVATE FUNCTIONS  */
        /****************************************************************************************************************/

        private static var fpsCounter:Number = 0;
        private static var fpsLagger :Number = 0;

        private static function onEnterFrame(e:Event = null):void{
            if (errorCallback != null) {
                try {
                    onEnterFrameSub();
                } catch (error:Error) {
                    errorCallback(error);
                }
            } else
                onEnterFrameSub();
        }

        private static function onEnterFrameSub():void {
            if (rDisplay._stage.focus && !rDisplay._stage.focus.stage)
                rDisplay._stage.focus = null;

            var repeats:uint = 1;

            if (fpsSteadifier && fpsCounter > 0 && getTimer() - fpsCounter > 25){
                fpsLagger += Math.min(34, getTimer() - fpsCounter - 17);
                while (fpsLagger >= 16){
                    repeats++;
                    fpsLagger -= 16;
                }
            }

            fpsCounter = getTimer();

            while(repeats--){
                rEvents.clear();

                rDisplay._tooltip.update();

                _deltaTime = getTimer() - _lastTime;
                _lastTime  = getTimer();

                rWindows.update();

                _groupBefore .update();
                if (_currentState && !_paused && !rWindows.pauseGame)
                    _currentState.update();
                _groupAfter .update();

                rInput.onEnterFrameUpdate();
            }

            if (getTimer() - fpsCounter > 14)
                fpsCounter = getTimer();
        }

        private static function onMouseMove(e:MouseEvent):void{
            if (rDisplay.cursor && !rDisplay.cursorHidden){
                var toCursorX:uint = rInput.mouseX - rDisplay._offsetX;
                var toCursorY:uint = rInput.mouseY - rDisplay._offsetY;

                toCursorX = (toCursorX / rDisplay.cursorScale | 0) * rDisplay.cursorScale;
                toCursorY = (toCursorY / rDisplay.cursorScale | 0) * rDisplay.cursorScale;

                rDisplay._cursor.x = toCursorX;
                rDisplay._cursor.y = toCursorY;

                Mouse.hide();
            } else {
                Mouse.show();
            }
        }
    }
}