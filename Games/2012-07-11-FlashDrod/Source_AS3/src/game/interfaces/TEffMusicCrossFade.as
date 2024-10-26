package game.interfaces {
    import flash.media.SoundChannel;
    import flash.media.SoundTransform;
	import net.retrocade.camel.effects.rEffect;
	
	/**
     * ...
     * @author Maurycy Zarzycki
     */
    public class TEffMusicCrossFade extends rEffect {

        private var _channel  :SoundChannel;
        private var _transform:SoundTransform;
        private var _volume   :Number;
        private var _fadeIn   :Boolean;

        private var _volumeOnInvert:Number = 1;

        public function TEffMusicCrossFade(channel:SoundChannel, fadeIn:Boolean, volume:Number = 1,
                                           duration:int = 500, callback:Function = null) {
            super(duration, callback);

            _channel = channel;
            _fadeIn  = fadeIn;

            _volume = volume;
            _transform = new SoundTransform(_volume);

            update();
        }

        override public function update():void {
            if (_fadeIn)
                _transform.volume = interval * _volume * _volumeOnInvert;
            else
                _transform.volume = _volume * _volumeOnInvert - interval * _volume * _volumeOnInvert;

            _channel.soundTransform = _transform;

            super.update();
        }

        override protected function finish():void {
            if (!_fadeIn)
                _channel.stop();

            super.finish();
        }

        public function invertOrStop():TEffMusicCrossFade {
            if (_fadeIn) {
                return invert();

            } else {
                finish();
            }

            return null;
        }

        public function invert():TEffMusicCrossFade {
            if (!_fadeIn)
                return null;

            _volumeOnInvert = interval;
            var effect:TEffMusicCrossFade = new TEffMusicCrossFade(_channel, false, _volume,
                                                                   duration, callback);

            effect._volumeOnInvert = _volumeOnInvert;
            finish();

            return effect;
        }

        public function stop():void {
            if (_fadeIn)
                _channel.stop();

            finish();
        }

    }

}