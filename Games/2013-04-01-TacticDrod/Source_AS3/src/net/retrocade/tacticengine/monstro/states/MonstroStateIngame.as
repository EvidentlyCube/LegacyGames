package net.retrocade.tacticengine.monstro.states {
    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.rInput;
    import net.retrocade.camel.global.rState;
    import net.retrocade.camel.layers.rLayerStarling;
    import net.retrocade.tacticengine.core.Entity;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.core.Field;
    import net.retrocade.tacticengine.monstro.actions.IMonstroAction;
    import net.retrocade.tacticengine.monstro.actions.MonstroActionFadeFromBlack;
    import net.retrocade.tacticengine.monstro.actions.MonstroActionFadeToBlack;
    import net.retrocade.tacticengine.monstro.actions.MonstroActionMissionEnded;
    import net.retrocade.tacticengine.monstro.actions.MonstroActionSlideLevelIn;
    import net.retrocade.tacticengine.monstro.actions.MonstroActionSlideLevelOut;
    import net.retrocade.tacticengine.monstro.ais.MonstroEnemyTurnProcess;
    import net.retrocade.tacticengine.monstro.ais.MonstroPlayerTurnProcess;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.core.MonstroData;
    import net.retrocade.tacticengine.monstro.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.core.MonstroLevelLoader;
    import net.retrocade.tacticengine.monstro.core.MonstroLevels;
    import net.retrocade.tacticengine.monstro.core.ProcessManager;
    import net.retrocade.tacticengine.monstro.core.SmartTouch;
    import net.retrocade.tacticengine.monstro.core.ZoomManager;
    import net.retrocade.tacticengine.monstro.desktop.HoverSniffer;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntityFactory;
    import net.retrocade.tacticengine.monstro.events.MonstroEventLoadLevel;
    import net.retrocade.tacticengine.monstro.events.MonstroEventMissionFinished;
    import net.retrocade.tacticengine.monstro.events.MonstroEventNewAction;
    import net.retrocade.tacticengine.monstro.events.MonstroEventTransition;
    import net.retrocade.tacticengine.monstro.events.MonstroEventUndo;
    import net.retrocade.tacticengine.monstro.render.MonstroFieldRenderer;
    import net.retrocade.tacticengine.monstro.render.MonstroHud;
    import net.retrocade.tacticengine.monstro.undo.UndoManager;
    import net.retrocade.tacticengine.monstro.utils.MonstroIngameMusicManager;
    import net.retrocade.utils.Key;

    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.display.Image;

    public class MonstroStateIngame extends rState {
        private var _field:Field;
        private var _fieldRenderer:MonstroFieldRenderer;
        private var _layerHud:MonstroHud;
        private var _processManager:ProcessManager;
        private var _zoomManager:ZoomManager;
        private var _hoverSniffer:HoverSniffer;
        private var _musicManager:MonstroIngameMusicManager;
        private var _backgroundLayer:rLayerStarling;
        private var _actionsStack:Vector.<IMonstroAction>;
        private var _isLevelLoaded:Boolean;
        private var _isPlayerHuman:Boolean;
        private var _isMissionFinished:Boolean = false;
        private var _levelHasBeethro:Boolean;

        public function MonstroStateIngame(isPlayerHuman:Boolean) {
            super();

            _isPlayerHuman = isPlayerHuman;
        }

        override public function create():void {
            Eventer.listen(MonstroEventNewAction.NAME, onAddAction);
            Eventer.listen(MonstroEventMissionFinished.NAME, onMissionFinished);
            Eventer.listen(MonstroEventTransition.NAME, onTransition);
            Eventer.listen(MonstroEventLoadLevel.NAME, onLoadLevel);
            Eventer.listen(MonstroEventUndo.NAME, onUndo);

            initCreateObjects();
            initBackgroundManager();
        }

        override public function update():void {
            super.update();

            _fieldRenderer.update();
            _zoomManager.update();

            _musicManager.update();

            if (_hoverSniffer) {
                _hoverSniffer.update();
            }


            _processManager.enabled = (_actionsStack.length === 0);
            if (_actionsStack.length && _actionsStack[0]) {
                while (_actionsStack.length && _actionsStack[0].update()) {
                    var isStoppingAction:Boolean = _actionsStack[0].isStoppingAction;
                    var actionToDestroy:IMonstroAction = _actionsStack.shift();

                    actionToDestroy.destruct();

                    missionCompletedCheck();

                    if (isStoppingAction) {
                        break;
                    }
                }
            } else {
                _processManager.update();
            }

            _layerHud.update();
        }

        override public function destroy():void {
            _musicManager.destruct();
            if (_hoverSniffer) {
                _hoverSniffer.destruct()
            }

            _zoomManager.destruct();
            _fieldRenderer.destruct();
            _field.destruct();
            _processManager.destruct();
            _isLevelLoaded = false;

            while (_actionsStack.length > 0) {
                _actionsStack.pop().destruct();
            }


            Eventer.release(MonstroEventNewAction.NAME, onAddAction);
            Eventer.release(MonstroEventMissionFinished.NAME, onMissionFinished);
            Eventer.release(MonstroEventTransition.NAME, onTransition);
            Eventer.release(MonstroEventLoadLevel.NAME, onLoadLevel);
            Eventer.release(MonstroEventUndo.NAME, onUndo);
        }

        public function onTransition(event:MonstroEventTransition):void {
            if (event.type == MonstroEventTransition.TRANSITION_RESTART_MISSION) {
                addAction(new MonstroActionSlideLevelOut(_fieldRenderer, doMissionRestart));
                _zoomManager.isEnabled = false;
            } else if (event.type == MonstroEventTransition.TRANSITION_NEXT_MISSION) {
                addAction(new MonstroActionSlideLevelOut(_fieldRenderer, doNextMission));
                _zoomManager.isEnabled = false;
            } else if (event.type == MonstroEventTransition.TRANSITION_RETURN_TO_MENU) {
                addAction(new MonstroActionFadeToBlack(returnToMainmenu));
                _zoomManager.isEnabled = false;
            }
        }

        private function initCreateObjects():void {
            _actionsStack = new Vector.<IMonstroAction>();
            _backgroundLayer = new rLayerStarling();

            _layerHud = new MonstroHud(this);

            _musicManager = new MonstroIngameMusicManager();
        }

        private function initNewLevel(levelIndex:int):void {
            _field = new Field();
            _fieldRenderer = new MonstroFieldRenderer(_field);
            _processManager = new ProcessManager();

            UndoManager.instance = new UndoManager();

            if (Monstro.singleClickActions) {
                _hoverSniffer = new HoverSniffer(_field, _fieldRenderer);
            }

            _layerHud.moveToFront();

            MonstroLevelLoader.loadLevel(MonstroLevels.getLevel(levelIndex), _field, _isPlayerHuman);
            _levelHasBeethro = doesLevelContainBeethro();

            _fieldRenderer.rerenderAll();
            _fieldRenderer.isPlayerHuman = _isPlayerHuman;

            _processManager.addProcess(new MonstroPlayerTurnProcess(_field, _fieldRenderer));
            _processManager.addProcess(new MonstroEnemyTurnProcess(_field, _fieldRenderer));

            SmartTouch.hook(new <DisplayObject>[
                _fieldRenderer.layerFloor.layer,
                _fieldRenderer.layerAnimatedFloor.layer,
                _fieldRenderer.layerSprites.layer,
                _fieldRenderer.layerRects.layer
            ]);
            _zoomManager = new ZoomManager(_field);
            _zoomManager.hook(new <DisplayObject>[
                _fieldRenderer.layerFloor.layer,
                _fieldRenderer.layerAnimatedFloor.layer,
                _fieldRenderer.layerSprites.layer,
                _fieldRenderer.layerRects.layer
            ]);

            _isMissionFinished = false;
        }

        private function initBackgroundManager():void {
            var background:Image = MonstroGfx.getGameplayBg();

            _backgroundLayer.add(background);
        }

        private function missionCompletedCheck():void {
            if (_isMissionFinished) {
                return;
            }

            var hasBeethro:Boolean = false;
            var hasFriendlyUnit:Boolean = false;
            var hasEnemyUnit:Boolean = false;

            for each(var entity:Entity in _field.getAllEntities()) {
                if (entity.get(Monstro.PROP_name) == MonstroEntityFactory.NAME_BEETHRO) {
                    hasBeethro = true;
                    hasFriendlyUnit = true;
                } else if (!entity.get(Monstro.PROP_isPlayerControlled)) {
                    hasEnemyUnit = true;
                } else {
                    hasFriendlyUnit = true;
                }
            }

            if (!hasFriendlyUnit || (hasBeethro == false && _levelHasBeethro)) {
                _isMissionFinished = true;
                new MonstroEventTransition(MonstroEventTransition.TRANSITION_RESTART_MISSION);
            } else if (!hasEnemyUnit) {
                _isMissionFinished = true;
                new MonstroEventMissionFinished(true);
            }
        }

        private function onAddAction(event:MonstroEventNewAction):void {
            addAction(event.action);
        }

        private function onMissionFinished():void {
            var action:MonstroActionMissionEnded = new MonstroActionMissionEnded();

            addAction(action);
            new MonstroEventTransition(MonstroEventTransition.TRANSITION_NEXT_MISSION);
        }

        private function onLoadLevel(event:MonstroEventLoadLevel):void {
            if (_isLevelLoaded) {
                _processManager.destruct();
                _zoomManager.destruct();
                _fieldRenderer.destruct();
                _field.destruct();

                UndoManager.instance.destruct();

                while (_actionsStack.length > 0) {
                    _actionsStack.pop().destruct();
                }

                if (_hoverSniffer) {
                    _hoverSniffer.destruct();
                }
            }

            MonstroData.currentLevel.set(event.index);

            initNewLevel(MonstroData.currentLevel.get());

            _zoomManager.update();
            _zoomManager.isEnabled = false;

            if (!_isLevelLoaded) {
                addAction(new MonstroActionFadeFromBlack());
            }

            addAction(new MonstroActionSlideLevelIn(_fieldRenderer, enableZoomManager));

            _isLevelLoaded = true;
        }

        private function doesLevelContainBeethro():Boolean {
            for each(var entity:MonstroEntity in _field.getAllEntities()) {
                if (entity.name == MonstroEntityFactory.NAME_BEETHRO) {
                    return true;
                }
            }

            return false;
        }

        private function returnToMainmenu():void {
            rCore.setState(new MonstroStateTitle());
        }

        private function doMissionRestart():void {
            new MonstroEventLoadLevel(MonstroData.currentLevel.get());
        }

        private function doNextMission():void {
            MonstroData.currentLevel.add(1);

            new MonstroEventLoadLevel(MonstroData.currentLevel.get());
        }

        private function enableZoomManager():void {
            _zoomManager.isEnabled = true;
        }

        private function addAction(action:IMonstroAction):void {
            action.field = _field;
            _actionsStack.push(action);
        }

        private function onUndo():void {
            if (UndoManager.instance.hasAnyUndo()) {
                _processManager.onUndo();
                UndoManager.instance.undo();
            }
        }

        public function get processManager():ProcessManager {
            return _processManager;
        }
    }
}