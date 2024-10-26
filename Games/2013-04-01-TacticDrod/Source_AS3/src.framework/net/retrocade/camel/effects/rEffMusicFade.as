package net.retrocade.camel.effects{
    import net.retrocade.camel.global.rGroup;
    import net.retrocade.camel.global.rSfx;
    import net.retrocade.camel.global.retrocamel_int;
    
	use namespace retrocamel_int;
	
    public class rEffMusicFade extends rEffect{
        private static var _currentFader:rEffMusicFade;
        
        private var fadeFrom:Number;
		private var fadeTo  :Number;
		
        public function rEffMusicFade(fadeTo:Number, duration:int, fadeFrom:Number = NaN, callback:Function = null, addTo:rGroup=null){
            super(duration, callback, addTo);
            
            this.fadeFrom = isNaN(fadeFrom) ? rSfx.musicFadeVolume : fadeFrom;
			this.fadeTo	  = fadeTo;
            
            if (_currentFader)
                _currentFader.finish();
            
            _currentFader = this;
            
            update();
        }
        
        override public function update():void {
            if (_blocked) return blockUpdate();
            
			rSfx.musicFadeVolume = getInterval(fadeFrom, fadeTo);
			
            super.update();
        }
        
        override protected function finish():void{
            rSfx.musicFadeVolume = fadeTo;
			
            _currentFader = null;
            
            super.finish();
        }
    }
}