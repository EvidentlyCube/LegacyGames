package submuncher.core.save {
    public class Save {
        private var _progress:SaveGameProgress;
        private var _displayTimeAsFrames:Boolean;
        private var _musicVolume:Number;
        private var _soundVolume:Number;

        public function Save() {
            _progress = new SaveGameProgress();
            _displayTimeAsFrames = false;
            _musicVolume = 1;
            _soundVolume = 1;
        }

        public function toJson():Object {
            return {
                progress: _progress.toJson(),
                displayTimeAsFrames: _displayTimeAsFrames,
                musicVolume: musicVolume,
                soundVolume: soundVolume
            }
        }

        public function fromJson(value:Object):void {
            _progress.fromJson(value.progress);
            _displayTimeAsFrames = value.displayTimeAsFrames === true;
            musicVolume = parseFloat(value.musicVolume);
            soundVolume = parseFloat(value.soundVolume);
        }

        public function get progress():SaveGameProgress {
            return _progress;
        }

        public function get displayTimeAsFrames():Boolean {
            return _displayTimeAsFrames;
        }

        public function set displayTimeAsFrames(value:Boolean):void {
            _displayTimeAsFrames = value;
        }

        public function get musicVolume():Number {
            return _musicVolume;
        }

        public function set musicVolume(value:Number):void {
            _musicVolume = isNaN(value) ? 1 : value;
        }

        public function get soundVolume():Number {
            return _soundVolume;
        }

        public function set soundVolume(value:Number):void {
            _soundVolume = isNaN(value) ? 1 : value;
        }
    }
}
