
package net.retrocade.tacticengine.monstro.ingame.ais.classic.enemyai {
    import flash.utils.getTimer;

    import net.retrocade.retrocamel.core.RetrocamelCore;
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGameplayDefinition;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroFieldRenderer;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.IMonstroEnemyStep;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.enemyai.normal.MonstroEnemyAIFilterClosest;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.enemyai.normal.MonstroEnemyAIFilterAttackFlagIfPossible;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.enemyai.normal.MonstroEnemyAIFilterLeastAttackers;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.enemyai.normal.MonstroEnemyAIFilterLeastFriendsBlocked;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.enemyai.normal.MonstroEnemyAIFilterMostDamage;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.enemyai.normal.MonstroEnemyAITargetAllTiles;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.enemyai.normal.MonstroEnemyAITargetClosestToPlayerTiles;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.enemyai.normal.MonstroEnemyAITargetOpponentsInRange;
	import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitType;
	import net.retrocade.tacticengine.monstro.ingame.utils.MonstroAttackSimulation;
	import net.retrocade.tacticengine.monstro.ingame.utils.MonstroPathmapper;
    import net.retrocade.functions.tracef;
	import net.retrocade.utils.UtilsNumber;

	public class MonstroEnemyAI {
		[Inject]
		public var field:MonstroField;
		[Inject]
		public var fieldRenderer:MonstroFieldRenderer;
		[Inject]
		public var gameplayDefinition:MonstroGameplayDefinition;
		public var friendlyUnits:Vector.<MonstroEntity>;
		public var hostileUnits:Vector.<MonstroEntity>;
		private var _flowsAndSteps:Vector.<Vector.<IMonstroEnemyStep>>;
		private var _currentStep:IMonstroEnemyStep;
		private var _currentFlow:Vector.<IMonstroEnemyStep>;
		private var _currentStepIndex:int = -1;
		private var _currentFlowIndex:int = -1;
		private var _unit:MonstroEntity;
		private var _tiles:Vector.<Tile>;

        private var _isFinished:Boolean;
        private var _approachableTiles:Vector.<Tile>;
        private var _attackableTiles:Vector.<Tile>;
        private var _forcedWait:int = 0;

		public function destroy():void{
			for each(var steps:Vector.<IMonstroEnemyStep> in _flowsAndSteps){
				for each(var step:IMonstroEnemyStep in steps){
					step.dispose();
				}
			}

			field = null;
			fieldRenderer = null;

			friendlyUnits = null;
			hostileUnits = null;
			_flowsAndSteps = null;
			_currentStep = null;
			_currentFlow = null;
			_unit = null;
			_tiles = null;
			_approachableTiles = null;
			_attackableTiles = null;
		}

        public function startForUnit(unit:MonstroEntity):void {
            if (!_flowsAndSteps){
                initFlows();
            }

            _unit = unit;

            _isFinished = false;
            _tiles = null;

            _currentFlow = null;
            _currentStep = null;
            _currentFlowIndex = -1;
            _currentStepIndex = -1;

            if (fieldRenderer && MonstroConsts.displayMonsterThinking) {
                _approachableTiles = _unit.getMovableTiles();
                _attackableTiles = _unit.getExpandedAttackableTiles(_approachableTiles);

                fieldRenderer.markTiles(_attackableTiles, MonstroConsts.MARK_TYPE_ATTACKABLE);
                fieldRenderer.markTiles(_approachableTiles, MonstroConsts.MARK_TYPE_MOVE);
                fieldRenderer.markTile(_unit.tile, MonstroConsts.MARK_TYPE_ATTACK_TARGET);

                _forcedWait = MonstroConsts.monsterThinkingDelay;
            } else {
                _forcedWait = 0;
            }
        }

        public function update():Boolean {
            _forcedWait -= RetrocamelCore.deltaTime;

            if (_forcedWait > 0) {
                return false;
            }

            var canThinkUntil:Number = getTimer() + MonstroConsts.timeToThink;

            while (!_isFinished && getTimer() < canThinkUntil) {
                if (_currentFlowIndex == -1) {
                    setNextFlow();
                }

                updateStep();
            }

            if (fieldRenderer && _isFinished && MonstroConsts.displayMonsterThinking) {
                fieldRenderer.markTiles(_approachableTiles, MonstroConsts.MARK_TYPE_RESET);
                fieldRenderer.markTiles(_attackableTiles, MonstroConsts.MARK_TYPE_RESET);
                fieldRenderer.markTile(_unit.tile, MonstroConsts.MARK_TYPE_RESET);
            }

            return _isFinished;
        }

		public function reset():void{
			_unit = null;
			_isFinished = false;
			_tiles = null;

			_currentFlow = null;
			_currentStep = null;
		}

        public function getTargetTile():Tile {
            if (!_tiles || _tiles.length == 0) {
                return _unit.tile;
            } else {
                return _tiles[0];
            }
        }

        private function initFlows():void {
            if (playerHasFlag()) {
                _flowsAndSteps = new <Vector.<IMonstroEnemyStep>>[
                    new <IMonstroEnemyStep>[
                        new MonstroEnemyAITargetOpponentsInRange(),
                        new MonstroEnemyAIFilterAttackFlagIfPossible(),
                        new MonstroEnemyAIFilterMostDamage(),
                        new MonstroEnemyAIFilterLeastAttackers(),
                        new MonstroEnemyAIFilterLeastFriendsBlocked(),
                        new MonstroEnemyAIFilterClosest()
                    ],
                    new <IMonstroEnemyStep>[
						new MonstroEnemyAITargetClosestToPlayerTiles(),
						new MonstroEnemyAIFilterLeastAttackers(),
						new MonstroEnemyAIFilterClosest()
                    ]];
            } else {
                _flowsAndSteps = new <Vector.<IMonstroEnemyStep>>[
                    new <IMonstroEnemyStep>[
                        new MonstroEnemyAITargetOpponentsInRange(),
                        new MonstroEnemyAIFilterMostDamage(),
                        new MonstroEnemyAIFilterLeastAttackers(),
                        new MonstroEnemyAIFilterLeastFriendsBlocked(),
                        new MonstroEnemyAIFilterClosest()
                    ],
                    new <IMonstroEnemyStep>[
                        new MonstroEnemyAITargetClosestToPlayerTiles(),
                        new MonstroEnemyAIFilterLeastAttackers(),
                        new MonstroEnemyAIFilterClosest()
                    ]];
            }
        }

        private function playerHasFlag():Boolean {
            for each(var unit:MonstroEntity in hostileUnits) {
                if (unit.unitType == EnumUnitType.FLAG_KING) {
                    return true;
                }
            }

            return false;
        }

        private function updateStep():void {
            if (_currentStep && _currentStep.update()) {
                stepFinished();
            }
        }

        private function stepFinished():void {
            _tiles = _currentStep.getResult();

            if (_tiles) {
                if (_tiles.length == 0) {
                    setNextFlow()
                } else if (_tiles.length == 1 && isLastStep()) {
                    _isFinished = true;
                } else {
                    setNextStep();
                }
            } else {
                setNextFlow();
            }
        }


        private function isLastStep():Boolean{
            return _currentStepIndex == _currentFlow.length - 1;
        }


        private function setNextFlow():void {
            _currentFlowIndex++;
            _currentStepIndex = -1;

            if (_currentFlowIndex < _flowsAndSteps.length) {
                _currentFlow = _flowsAndSteps[_currentFlowIndex];

                setNextStep();
            } else {
                _currentFlow = null;
                _currentStep = null;
                _isFinished = true;
            }
        }

        private function setNextStep():void {
            _currentStepIndex++;

            if (_currentStepIndex < _currentFlow.length) {
                MonstroPathmapper.stopCache();

                _currentStep = _currentFlow[_currentStepIndex];
                _currentStep.field = field;
                _currentStep.init(_unit, _tiles, friendlyUnits, hostileUnits);

                MonstroPathmapper.startCache();

            } else {
                _currentFlow = null;
                _currentStep = null;
                _isFinished = true;
            }
        }

        public function get isRunning():Boolean {
            return _unit !== null && !_isFinished;
        }

		public function get isFinished():Boolean{
			return _isFinished;
		}

        public function get unit():MonstroEntity {
            return _unit;
        }

		public function getBestAttackableUnit(targetTile:Tile, unit:MonstroEntity):MonstroEntity {
			var bestScore:int = int.MIN_VALUE;
			var bestTarget:MonstroEntity;

			for each(var playerUnit:MonstroEntity in hostileUnits) {
				var simulation:MonstroAttackSimulation = new MonstroAttackSimulation(unit, playerUnit);
				var calculatedScore:int = simulation.score * 100 - UtilsNumber.distanceManhattan(targetTile.x, targetTile.y, playerUnit.x, playerUnit.y);

				if (calculatedScore > bestScore && playerUnit.attackable && unit.canAttackFromTile(targetTile, playerUnit)) {
					bestScore = calculatedScore;
					bestTarget = playerUnit;
				} else if (
                    bestTarget
                    && calculatedScore === bestScore
                    && getPositionalScore(unit.x, unit.y, playerUnit.x, playerUnit.y) < getPositionalScore(unit.x, unit.y, bestTarget.x, bestTarget.y)
                ) {
                    bestScore = calculatedScore;
					bestTarget = playerUnit;
                }
			}

			return bestTarget;
		}

        public function getPositionalScore(fromX: Number, fromY: Number, toX: Number, toY: Number): Number {
            var angle: Number = Math.atan2(toY - fromY, toX - fromX);
            angle += Math.PI / 2;
            if (angle < 0) {
                angle += Math.PI;
            }

            return angle;
        }
	}
}
