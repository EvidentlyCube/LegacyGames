package net.retrocade.tacticengine.monstro.actions{
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.core.MonstroFunctions;
    import net.retrocade.tacticengine.monstro.core.MonstroSfx;
    import net.retrocade.tacticengine.monstro.core.SmartTouch;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.events.MonstroEventSortUnitDisplay;
    import net.retrocade.tacticengine.monstro.render.MonstroUnitClip;

    public class MonstroActionMoveUnit extends MonstroAction{
        private var _path:Vector.<MonstroUnitStepData>;
        private var _currentStep:int = 0;
        
        private var _fromX:int = -1;
        private var _fromY:int = -1;
        
        private var _toX:int = -1;
        private var _toY:int = -1;
        private var _direction:int;

        private var _slideStep:Number;
        private var _unitGraphic:MonstroUnitClip;
        private var _unitObject:MonstroEntity;

        private var _wasUnitRectVisible:Boolean;
        
        public function MonstroActionMoveUnit(unitGraphic:MonstroUnitClip, unitObject:MonstroEntity, path:Vector.<MonstroUnitStepData>, onFinished:Function = null){
            super(onFinished);

            _unitGraphic = unitGraphic;
            _unitObject = unitObject;
            _path = path;
        }
        
        override public function update():Boolean{
            if (_toX == -1){
                init();
            }

            if (_path.length == 1){
                _unitGraphic.x = _toX;
                _unitGraphic.y = _toY;

                new MonstroEventSortUnitDisplay();

                return true;
            }

            if ((_slideStep += movementSpeed) >= 1 || (_toX == _fromX && _toY == _fromY)){
                if (_currentStep < _path.length - 2){
                    setStep(++_currentStep);
                } else {
                    _unitGraphic.x = _toX;
                    _unitGraphic.y = _toY;

                    return true;
                }
            }

            _unitGraphic.direction = _direction;

            _unitGraphic.x = _fromX + (_toX - _fromX) * _slideStep;
            _unitGraphic.y = _fromY + (_toY - _fromY) * _slideStep;

            new MonstroEventSortUnitDisplay();
            
            return false;
        }

        private function get movementSpeed():Number{
            if (!SmartTouch.isSingleTouchDown){
                return Monstro.movementSpeed;
            } else {
                return 1;
            }
        }

        private function playUnitSound(unit:MonstroEntity):void{
            if (MonstroFunctions.unitIsHuman(unit.name)){
                MonstroSfx.playHumanStep();
            } else {
                MonstroSfx.playMonsterStep();
            }
        }
        
        private function setStep(step:int):void{
            _fromX = _path[step].toX * Monstro.tileWidth;
            _fromY = _path[step].toY * Monstro.tileHeight;
            
            _toX = _path[step + 1].toX * Monstro.tileWidth;
            _toY = _path[step + 1].toY * Monstro.tileHeight;
            _direction = _path[step + 1].direction;

            if (field && (_toX != _fromX || _toY != _fromY)){
                playUnitSound(_unitObject);
            }
            
            _slideStep = 0;
        }

        private function init():void{
            _wasUnitRectVisible = _unitGraphic.showUnitRect;
            _unitGraphic.showUnitRect = false;

            if (_path.length > 1){
                setStep(0);
            } else if (_path.length == 1){
                _fromX = _path[0].toX * Monstro.tileWidth;
                _fromY = _path[0].toY * Monstro.tileHeight;

                _toX = _path[0].toX * Monstro.tileWidth;
                _toY = _path[0].toY * Monstro.tileHeight;
            }
        }
        
        override public function destruct():void{
            _unitGraphic.showUnitRect = _wasUnitRectVisible;

            super.destruct();

            _path = null;
            _unitGraphic = null;
        }
    }
}