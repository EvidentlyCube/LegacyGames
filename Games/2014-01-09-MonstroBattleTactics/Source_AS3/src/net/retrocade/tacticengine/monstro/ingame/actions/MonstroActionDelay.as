package net.retrocade.tacticengine.monstro.ingame.actions{
    import flash.utils.getTimer;

    public class MonstroActionDelay extends MonstroAction{
        private var _endTime:Number;
        
        public function MonstroActionDelay(delayTime:int, onFinished:Function = null){
            super(onFinished);

            _endTime = getTimer() + delayTime;
        }
        
        override public function update():Boolean{
            return getTimer() >= _endTime
        }
    }
}