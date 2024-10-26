package net.retrocade.camel.effects{
    import flash.utils.getTimer;
    
    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.camel.global.rGroup;
    import net.retrocade.camel.global.retrocamel_int;
    import net.retrocade.camel.layers.rLayerSprite;
    import net.retrocade.camel.objects.rObject;

    use namespace retrocamel_int;

    public class rEffect extends rObject{
        /****************************************************************************************************************/
        /**                                                                                                     STATIC  */
        /****************************************************************************************************************/

        /**
         * Boolean indicating if the effects are blocked
         */
        protected static var _blocked:Boolean = false;

        /**
         * Time when the block started
         */
        protected static var _blockStarted:Number = NaN;

        /**
         * Blocks all effects playing
         */
        public static function block():void{
            if (!_blocked){
                _blocked = true;
                _blockStarted = getTimer();
            }
        }

        /**
         * Unblocks all effects
         */
        public static function unblock():void{
            _blocked = false;
        }


        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

        /**
         * Duration of the effect in milliseconds
         */
        private var _duration:uint;

        /**
         * Duration of the effect in milliseconds
         */
        public function get duration():uint {
            return _duration;
        }

        /**
         * Time when the effect started
         */
        private var _startTime:Number;

        /**
         * Function to be called after the effect finishes
         */
        private var _callback:Function;

        public function get callback():Function {
            return _callback;
        }

        /**
         * If the object was added to the default group and has to be removed automatically
         */
        private var _addTo:rGroup;

        /**
         * If this effect is blocked
         */
        private var _isBlocked:Boolean = false;

        /**
         * Easing function used by given effect, null by default
         */
        public var easing:Function = null;


        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        /**
         * Constructor
         * @param duration Duration of the effect in millisecs
         * @param callback Function to be called when the effect finishes
         * @param addTo rGroup to which this effect has to be added, if null adds to current state
         */
        public function rEffect(duration:int, callback:Function, addTo:rGroup = null){
            active = true;
            _duration = duration;
            _callback = callback;

            _startTime = getTimer();
            _addTo     = addTo;

            if (_addTo == null)
                _addTo = rCore.groupBefore;

            _addTo.add(this);
        }

        /**
         * Returns true if the effect is and should be finished
         */
        private function get isFinished():Boolean{
            return _isBlocked ? false : getTimer() >= _startTime + _duration;
        }

        /**
         * Update, should be overriden and then super-called. Checks if the
         * effect is finished
         */
        override public function update():void{
            if (isFinished)
                finish();
        }

        /**
         * Called when the effect has finished, calls the callback function
         */
        protected function finish():void{
            if (_callback != null)
                if (_callback.length)
                    _callback(this);
                else
                    _callback();

            _addTo.nullify(this);
        }

        /**
         * Returns the interval of the current animation state, as a value between 0 and 1
         */
        protected function get interval():Number {
            var timer:Number = getTimer();

            if (_isBlocked) {
                _startTime += getTimer() - _blockStarted;
                _isBlocked = false;
            }

            if (easing != null)
                return Math.max(0, Math.min(1, easing(timer - _startTime, _duration)));
            else
                return Math.max(0, Math.min(1, (timer - _startTime) / _duration));
        }
		
		/**
		 * Return the interval of the current animation state, as a number between passed values
		 */
		protected function getInterval(from:Number, to:Number):Number{
			return from + (to - from) * interval;
		}

        /**
         *  Called by update() when the animation playback is blocked
         */
        protected function blockUpdate():void {
            if (_blocked && !_isBlocked)
                _isBlocked = true;
        }

        protected function resetDuration(newDuration:uint):void {
            _startTime = getTimer();

            _duration = newDuration;
        }
    }
}