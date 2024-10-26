package net.retrocade.camel.global {
    import flash.display.DisplayObjectContainer;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.utils.getTimer;

    import net.retrocade.camel.interfaces.rISettings;
    import net.retrocade.utils.Rand;

    use namespace retrocamel_int;

    /**
     * ...
     * @author Maurycy Zarzycki
     */
    public class rCore {
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
        public static function get deltaTime():Number {
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
        public static function get groupBefore():rGroup {
            return _groupBefore;
        }

        /**
         * Global updates group which is always updated after anything else
         */
        private static var _groupAfter:rGroup = new rGroup();

        /**
         * Retrieves global updates group which is always updated after everything else
         */
        public static function get groupAfter():rGroup {
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
        retrocamel_int static var settings:rISettings;


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
        public static function get currentState():rState {
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
        public static function get paused():Boolean {
            return _paused;
        }

        /**
         * @private
         */
        public static function set paused(value:Boolean):void {
            _paused = value;
        }

        /**
         * A function to call if an error is found (only during enter frame execution).
         * The error will be passed as the first argument.
         * If not set, the error handling will work as default in flash.
         */
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
        public static function initFlash(stage:Stage, main:DisplayObjectContainer, settingsInstance:rISettings):void {
            settings = settingsInstance;

            rLang.initialize();
            rInput.initialize(stage);
            rDisplay.initializeFlash(main, stage);
            rEvents.initialize();

            stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);

            Rand.seed = Math.max((new Date).milliseconds, 1);
            Rand.om;
        }


        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: State Manipulation
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Changes the current state
         * @param state State to be set
         */
        public static function setState(state:rState):void {
            if (_currentState) {
                _currentState.destroy();
            }

            _currentState = state;
            _currentState.create();
        }


        /****************************************************************************************************************/
        /**                                                                                          PRIVATE FUNCTIONS  */
        /****************************************************************************************************************/

        private static function onEnterFrame(e:Event = null):void {
            if (errorCallback != null) {
                try {
                    onEnterFrameSub();
                } catch (error:Error) {
                    errorCallback(error);
                }
            } else {
                onEnterFrameSub();
            }
        }

        private static function onEnterFrameSub():void {
            if (rDisplay.flashStage.focus && !rDisplay.flashStage.focus.stage) {
                rDisplay.flashStage.focus = null;
            }

            if (rEvents.autoClear) {
                rEvents.clear();
            }

            _deltaTime = getTimer() - _lastTime;
            _lastTime = getTimer();

            rWindows.update();

            _groupBefore.update();
            if (_currentState && !_paused && !rWindows.pauseGame) {
                _currentState.update();
            }
            _groupAfter.update();

            rCursor.update();

            rInput.onEnterFrameUpdate();
        }

        retrocamel_int static function onStageResized():void {
            if (_currentState) {
                _currentState.resize();
            }
        }
    }
}