package net.retrocade.camel.effects{
    /**
     * ...
     * @author Maurycy Zarzycki
     */
    public class rEffectSequence extends rEffectParallel{    
        public function rEffectSequence(effects:Array, callback:Function = null){
            super(effects, callback);
        }
        
        override protected function start():void{
            _effectsCount = 0;
            next();
        }
        
        protected function next():void{
            makeEffect(_effects[_effectsCount++], subeffectFinished);
        }
        
        override protected function subeffectFinished():void{
            if (_effectsCount == _effects.length){
                if (_callback != null)
                    _callback();
            } else
                next();
        }
    }
}