package net.retrocade.camel.effects{
    /**
     * ...
     * @author Maurycy Zarzycki
     */
    public class rEffectParallel{
        protected var _effectsCount:uint = 0;
        protected var _callback    :Function;
        protected var _effects       :Array
        
        public function rEffectParallel(effects:Array, callback:Function = null){
            _effects      = effects;
            _effectsCount = effects.length;
            _callback     = callback;
            
            start();
        }
        
        protected function start():void{
            for each(var entry:Array in _effects)
                makeEffect(entry, subeffectFinished);
        }
        
        protected function subeffectFinished():void{
            _effectsCount--;
            if (_effectsCount == 0 && _callback != null)
                _callback();
        }
        
        protected function makeEffect(entry:Array, callback:Function):void{
            switch(entry[0]){
                case('rEffFade'):
                    new rEffFade(entry[1], entry[2], entry[3], entry[4], callback);
                    return;
                
                case('rEffQuake'):
                    new rEffQuake(entry[1], entry[2], entry[3], entry[4], entry[5], entry[6], callback);
                    return;
            }
            
        }
    }
}