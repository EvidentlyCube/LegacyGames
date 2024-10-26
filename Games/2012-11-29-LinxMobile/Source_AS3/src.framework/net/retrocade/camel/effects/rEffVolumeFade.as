package net.retrocade.camel.effects{
    import net.retrocade.camel.global.rGroup;
    import net.retrocade.camel.global.rSfx;

    public class rEffVolumeFade extends rEffect{
        private static var _currentFader:rEffVolumeFade;

        private var fadeIn:Boolean;
        public function rEffVolumeFade(fadeIn:Boolean, duration:int, callback:Function = null, addTo:rGroup=null){
            super(duration, callback, addTo);

            this.fadeIn = fadeIn;

            if (_currentFader)
                _currentFader.finish();

            _currentFader = this;

            update();
        }

        override public function update():void {
            if (_blocked) return blockUpdate();

            if (fadeIn)
                rSfx.musicFadeVolume = interval * rSfx.musicVolume;

            else
                rSfx.musicFadeVolume = (1 - interval) * rSfx.musicVolume;

            super.update();
        }

        override protected function finish():void{
            if (fadeIn)
                rSfx.resetMusicFadeVolume();

            else
                rSfx.musicFadeVolume = 0;

            _currentFader = null;

            super.finish();
        }
    }
}