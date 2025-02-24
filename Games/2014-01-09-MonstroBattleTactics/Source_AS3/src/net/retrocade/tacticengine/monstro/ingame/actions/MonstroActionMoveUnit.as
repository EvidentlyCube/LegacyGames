package net.retrocade.tacticengine.monstro.ingame.actions{
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGameplayDefinition;
    import net.retrocade.tacticengine.monstro.global.core.MonstroSfx;
    import net.retrocade.tacticengine.monstro.global.core.SmartTouch;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitType;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventSortUnitDisplay;
    import net.retrocade.tacticengine.monstro.ingame.floors.MonstroTileFloor;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroUnitClip;

    public class MonstroActionMoveUnit extends MonstroAction{
        [Inject]
        public var gameplayDefinition:MonstroGameplayDefinition;

        private var _path:Vector.<Tile>;
        private var _currentStep:int = 0;

        private var _fromX:int = -1;
        private var _fromY:int = -1;

        private var _toX:int = -1;
        private var _toY:int = -1;

        private var _slideStep:Number;
        private var _unitGraphic:MonstroUnitClip;
        private var _unitObject:MonstroEntity;

        public function MonstroActionMoveUnit(){
            super(null);
        }

        public function init(unitGraphic:MonstroUnitClip, unitObject:MonstroEntity, path:Vector.<Tile>, onFinished:Function = null):void{
            _callback = onFinished;

            _unitGraphic = unitGraphic;
            _unitObject = unitObject;
            _path = path;
        }

        override public function update():Boolean{
            if (_toX == -1){
                startAction();
            }

            if (_path.length == 1){
                _unitGraphic.x = _toX;
                _unitGraphic.y = _toY;

                new MonstroEventSortUnitDisplay();

                return true;
            }

            _unitGraphic.isSpeeding = true;

            if ((_slideStep += movementSpeed) >= 1){
                if (_currentStep < _path.length - 2){
                    setStep(++_currentStep);
                } else {
                    _unitGraphic.x = _toX;
                    _unitGraphic.y = _toY;

                    new MonstroEventSortUnitDisplay();

                    return true;
                }
            }

            if (_fromX > _toX){
                _unitGraphic.mirror = true;
            } else if (_fromX < _toX){
                _unitGraphic.mirror = false;
            }

            _unitGraphic.x = _fromX + (_toX - _fromX) * _slideStep;
            _unitGraphic.y = _fromY + (_toY - _fromY) * _slideStep;

            new MonstroEventSortUnitDisplay();

            return false;
        }

        private function get movementSpeed():Number{
            if (SmartTouch.isRightButtonDown){
                return 1;
            } else {
                return gameplayDefinition.gameSpeed;
            }
        }

        private function playUnitSound(unit:MonstroEntity, tile:Tile):void{
            if (unit.canFly){
                MonstroSfx.playStepFlying();

            } else if (unit.unitType !== EnumUnitType.MOBILE_WALL){
                var floor:MonstroTileFloor = tile.floor as MonstroTileFloor;

                if (floor.isGrass){
                    MonstroSfx.playStepGrass();
                } else if (floor.isGround){
                    MonstroSfx.playStepGround();
                } else if (floor.isSidewalk){
                    MonstroSfx.playStepSidewalk();
                }
            }
        }

        private function setStep(step:int):void{
            _fromX = _path[step].x * MonstroConsts.tileWidth;
            _fromY = _path[step].y * MonstroConsts.tileHeight;

            _toX = _path[step + 1].x * MonstroConsts.tileWidth;
            _toY = _path[step + 1].y * MonstroConsts.tileHeight;

            if (field){
                playUnitSound(_unitObject, field.getTileAt(_path[step].x, _path[step].y));
            }

            _slideStep = 0;
        }

        private function startAction():void{
            if (_path.length > 1){
                setStep(0);
            } else if (_path.length == 1){
                _fromX = _path[0].x * MonstroConsts.tileWidth;
                _fromY = _path[0].y * MonstroConsts.tileHeight;

                _toX = _path[0].x * MonstroConsts.tileWidth;
                _toY = _path[0].y * MonstroConsts.tileHeight;
            }

            if (_path.length > 1 && _unitObject.unitType === EnumUnitType.MOBILE_WALL){
                MonstroSfx.playStepMobileWall();
            }
        }

        override public function dispose():void{
            super.dispose();

            _unitGraphic.isSpeeding = false;

            _path = null;
            _unitGraphic = null;
        }
    }
}