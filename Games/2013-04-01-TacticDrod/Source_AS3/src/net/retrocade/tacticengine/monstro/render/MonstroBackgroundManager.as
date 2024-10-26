package net.retrocade.tacticengine.monstro.render {
    import net.retrocade.camel.interfaces.rIUpdatable;
    import net.retrocade.tacticengine.core.IDestruct;
    import net.retrocade.utils.Rand;
    import net.retrocade.utils.UNumber;

    public class MonstroBackgroundManager implements IDestruct{
        private var _scrollDirection:Number;
        private var _directionDeviation:Number;
        private var _scrollSpeed:Number;
        private var _speedDeviation:Number;

        private var _scrollDirectionWait:uint;
        private var _directionDeviationWait:uint;
        private var _scrollSpeedWait:uint;
        private var _speedDeviationWait:uint;

        private var _scrollDirectionTo:Number;
        private var _directionDeviationTo:Number;
        private var _scrollSpeedTo:Number;
        private var _speedDeviationTo:Number;

        private var _scrollDirectionChange:Number;
        private var _directionDeviationChange:Number;
        private var _scrollSpeedChange:Number;
        private var _speedDeviationChange:Number;

        private var _backgroundBottom:MonstroBackground;
        private var _backgroundTop:MonstroBackground;

        public function MonstroBackgroundManager(){
            _scrollSpeed = 2;

            _scrollDirection = Rand.om * Math.PI * 2;
            _scrollDirectionWait = 0;
            _scrollDirectionTo = _scrollDirection;
            _scrollDirectionChange = 1;

            _directionDeviation = (Rand.om - 1) * Math.PI * 0.2 ;
            _directionDeviationWait = 0;
            _directionDeviationTo = _directionDeviation;
            _directionDeviationChange = 1;

            _scrollSpeed = 0.3 + Rand.om * 1.7;
            _scrollSpeedWait = 0;
            _scrollSpeedTo = _scrollSpeed;
            _scrollSpeedChange = 1;

            _speedDeviation = Rand.om * 0.5;
            _speedDeviationWait = 0;
            _speedDeviationTo = _speedDeviation;
            _speedDeviationChange = 1;
        }

        public function setBackgrounds(bottomBackground:MonstroBackground, topBackground:MonstroBackground):void{
            _backgroundBottom = bottomBackground;
            _backgroundTop = topBackground;
        }

        public function update():void{
            if (_scrollDirectionWait == 0){
                if (_scrollDirectionTo != _scrollDirection){
                    _scrollDirection = UNumber.approach(_scrollDirection, _scrollDirectionTo,
                            _scrollDirectionChange, 0.05, _scrollDirectionChange)
                } else {
                    _scrollDirectionWait = Rand.u(1, 3600);
                    _scrollDirectionTo = _scrollDirection + (Rand.om - 1) * Math.PI;
                    _scrollDirectionChange = 0.003 + Rand.om * 0.007;
                }
            } else {
                _scrollDirectionWait--;
            }

            if (_directionDeviationWait == 0){
                if (_directionDeviationTo != _directionDeviation){
                    _directionDeviation = UNumber.approach(_directionDeviation, _directionDeviationTo,
                            _directionDeviationChange, 0.05, _directionDeviationChange)
                } else {
                    _scrollDirectionWait = Rand.u(1, 3600);
                    _directionDeviationTo = (Rand.om - 1) * Math.PI * 0.2;
                    _directionDeviationChange = 0.003 + Rand.om * 0.007;
                }
            } else {
                _directionDeviationWait--;
            }

            if (_scrollSpeedWait == 0){
                if (_scrollSpeedTo != _scrollSpeed){
                    _scrollSpeed = UNumber.approach(_scrollSpeed, _scrollSpeedTo,
                            _scrollSpeedChange, 0.05, _scrollSpeedChange)
                } else {
                    _scrollSpeedWait = Rand.u(1, 3600);
                    _scrollSpeedTo = 0.3 + Rand.om * 1.7;
                    _scrollSpeedChange = 0.003 + Rand.om * 0.007;
                }
            } else {
                _scrollSpeedWait--;
            }

            if (_speedDeviationWait == 0){
                if (_speedDeviationTo != _scrollSpeed){
                    _speedDeviation = UNumber.approach(_speedDeviation, _speedDeviationTo,
                            _speedDeviationChange, 0.05, _speedDeviationChange)
                } else {
                    _speedDeviationWait = Rand.u(1, 3600);
                    _speedDeviationTo = Rand.om * 0.5;
                    _speedDeviationChange = 0.003 + Rand.om * 0.007;
                }
            } else {
                _scrollSpeedWait--;
            }

            _backgroundBottom.x += Math.cos(_scrollDirection) * _scrollSpeed;
            _backgroundBottom.y += Math.sin(_scrollDirection) * _scrollSpeed;

            _backgroundTop.x += Math.cos(_scrollDirection + _directionDeviation) * (_scrollSpeed + _speedDeviation);
            _backgroundTop.y += Math.sin(_scrollDirection + _directionDeviation) * (_scrollSpeed + _speedDeviation);
        }

        public function destruct():void{
            if (_backgroundBottom){
                _backgroundBottom.dispose();
                _backgroundBottom = null;
            }

            if (_backgroundTop){
                _backgroundTop.dispose();
                _backgroundTop = null;
            }
        }
    }
}
