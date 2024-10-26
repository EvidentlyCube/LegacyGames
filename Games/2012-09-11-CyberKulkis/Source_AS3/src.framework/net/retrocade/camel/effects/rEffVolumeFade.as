package net.retrocade.camel.effects{
    import net.retrocade.camel.core.rGroup;
    import net.retrocade.camel.core.rSound;
    
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
                rSound.musicTempVolume = interval * rSound.musicVolume;
            
            else
                rSound.musicTempVolume = (1 - interval) * rSound.musicVolume;
            
            super.update();
        }
        
        override protected function finish():void{
            if (fadeIn)
                rSound.musicVolumeResetTemp();
            
            else
                rSound.musicTempVolume = 0;
            
            _currentFader = null;
            
            super.finish();
        }
    }
}