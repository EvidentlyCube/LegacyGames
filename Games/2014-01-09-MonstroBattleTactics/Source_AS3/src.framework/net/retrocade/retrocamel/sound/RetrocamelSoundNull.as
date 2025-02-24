


package net.retrocade.retrocamel.sound {

    import flash.utils.clearTimeout;
    import flash.utils.getTimer;
    import flash.utils.setTimeout;

    import net.retrocade.retrocamel.interfaces.IRetrocamelSound;

    public class RetrocamelSoundNull implements IRetrocamelSound {
        private var _duration:Number;
        private var _timeoutId:uint;
        private var _timerStart:Number = 0;
        private var _loops:uint;
        private var _isRunning:Boolean = false;
        private var _isPaused:Boolean = false;
        private var _volume:Number = 1;
        private var _pan:Number = 1;
        private var _timeLeftForCurrentRepetition:Number = 0;

        public function RetrocamelSoundNull(duration:Number) {
            _duration = duration;
        }

        public function play(loops:uint = 0, volumeModifier:Number = 1, pan:Number = 0):void {
            _volume = volumeModifier;
            _pan = pan;

            subPlay(loops, _duration);
        }

        public function pause():void {
            if (_isRunning) {
                var timeDelta:Number = getTimer() - _timerStart;

                clearTimeout(_timeoutId);
                _timeoutId = 0;

                _timeLeftForCurrentRepetition = _timeLeftForCurrentRepetition - timeDelta;
                _isRunning = false;
                _isPaused = true;
            }
        }

        public function stop():void {
            pause();

            _timeLeftForCurrentRepetition = 0;
            _loops = 0;
            _isPaused = false;
        }

        public function resume():void {
            if (_isPaused) {
                subPlay(_loops, _timeLeftForCurrentRepetition);
            }
        }

        public function dispose():void {
            stop();
        }

        private function subPlay(loops:uint, durationToPlay:Number):void {
            stop();

            _loops = loops;
            _isRunning = true;
            _timeoutId = setTimeout(onTimerFinished, durationToPlay);
            _timerStart = getTimer();
            _timeLeftForCurrentRepetition = durationToPlay;
        }

        private function onTimerFinished():void {
            if (_loops) {
                play(_loops - 1, _volume, _pan);
            } else {
                stop();
            }
        }

        public function get pauseTime():Number {
            return _isPaused ? _duration - _timeLeftForCurrentRepetition : 0;
        }

        public function get loops():uint {
            return _loops;
        }

        public function set loops(value:uint):void {
            _loops = value;
        }

        public function get length():Number {
            return _duration;
        }

        public function get volume():Number {
            return _volume;
        }

        public function set volume(value:Number):void {
            _volume = value;
        }

        public function get pan():Number {
            return _pan;
        }

        public function set pan(value:Number):void {
            _pan = value;
        }

        public function get isPlaying():Boolean {
            return _isRunning;
        }

        public function get position():Number {
            return _duration - _timeLeftForCurrentRepetition + (getTimer() - _timerStart);
        }
    }
}
