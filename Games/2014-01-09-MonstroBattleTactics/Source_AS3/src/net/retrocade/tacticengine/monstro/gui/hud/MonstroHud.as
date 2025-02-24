
package net.retrocade.tacticengine.monstro.gui.hud {
	import net.retrocade.retrocamel.locale._;
    import net.retrocade.retrocamel.global.RetrocamelEventsQueue;
    import net.retrocade.retrocamel.interfaces.IRetrocamelUpdatable;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.core.IDisposable;
    import net.retrocade.tacticengine.core.injector.injectCreate;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.global.states.MonstroStateIngame;
	import net.retrocade.tacticengine.monstro.gui.windows.MonstroWindowHelp;
	import net.retrocade.tacticengine.monstro.gui.windows.MonstroWindowMissionObjective;
	import net.retrocade.tacticengine.monstro.gui.windows.MonstroWindowPauseGame;
    import net.retrocade.tacticengine.monstro.ingame.ais.common.IMonstroTurnProcess;
    import net.retrocade.tacticengine.monstro.ingame.ais.classic.MonstroEnemyTurnProcess;
    import net.retrocade.tacticengine.monstro.ingame.ais.classic.MonstroPlayerTurnProcess;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventDisplayAttackStats;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventDisplayTrapStats;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventDisplayUnitStats;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventEndTurn;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventLockHud;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventResize;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTurnProcessIsChanging;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUndo;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitDisable;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventZoomChange;
    import net.retrocade.tacticengine.monstro.ingame.undo.UndoManager;

    import starling.display.DisplayObject;

    final public class MonstroHud extends RetrocamelLayerStarling implements IRetrocamelUpdatable, IDisposable {
        [Inject]
        public var ingameState:MonstroStateIngame;
        private var _buttonEndTurn:MonstroHudButton;
        private var _buttonMenu:MonstroHudButton;
        private var _buttonUndo:MonstroHudButton;
        private var _buttonZoomIn:MonstroHudButton;
        private var _buttonZoomOut:MonstroHudButton;
        private var _buttonHelp:MonstroHudButton;
        private var _buttonObjective:MonstroHudButton;
        private var _statsWindow:MonstroHudStatsWindow;
        private var _attackWindow:MonstroHudAttackResults;
        private var _timeoutWindow:MonstroHudTurnsLeft;
        private var _visibleButtons:Vector.<MonstroHudButton>;
		private var _tooltip:MonstroHudTooltip;

		private var _attackStatsHiddenThisTurn:Boolean = false;
        private var _isHudLocked:Boolean = false;

        public function MonstroHud() {
        }

        final public function init():void {
            _buttonEndTurn = new MonstroHudButton(MonstroGfx.getIconEndTurn(), MonstroGfx.getIconEndTurnDisabled(), onEndTurn);
            _buttonEndTurn = new MonstroHudButton(MonstroGfx.getIconEndTurn(), MonstroGfx.getIconEndTurnDisabled(), onEndTurn);
            _buttonMenu = new MonstroHudButton(MonstroGfx.getIconMenu(), MonstroGfx.getIconMenuDisabled(), onMenu);
            _buttonUndo = new MonstroHudButton(MonstroGfx.getIconUndo(), MonstroGfx.getIconUndoDisabled(), onUndo);
            _buttonZoomIn = new MonstroHudButton(MonstroGfx.getIconZoomIn(), MonstroGfx.getIconZoomInDisabled(), onZoom);
            _buttonZoomOut = new MonstroHudButton(MonstroGfx.getIconZoomOut(), MonstroGfx.getIconZoomOutDisabled(), onZoom);
            _buttonHelp = new MonstroHudButton(MonstroGfx.getIconHelp(), MonstroGfx.getIconHelpDisabled(), onHelp);
			_buttonObjective = new MonstroHudButton(MonstroGfx.getIconObjective(), MonstroGfx.getIconObjectiveDisabled(), onObjective);
			_tooltip = new MonstroHudTooltip();

            _statsWindow = injectCreate(MonstroHudStatsWindow);
            _attackWindow = injectCreate(MonstroHudAttackResults);
            _timeoutWindow = injectCreate(MonstroHudTurnsLeft);

            _statsWindow.hide(true);
            _attackWindow.hide();

            _buttonEndTurn.enabled = true;
            _buttonMenu.enabled = true;


            Eventer.listen(MonstroEventDisplayUnitStats.NAME, onDisplayUnitStats, this);
            Eventer.listen(MonstroEventDisplayTrapStats.NAME, onDisplayTrapStats, this);
            Eventer.listen(MonstroEventUnitDisable.NAME, onUnitDisabled, this);
            Eventer.listen(MonstroEventTurnProcessIsChanging.NAME, onTurnProcessChanged, this);
            Eventer.listen(MonstroEventDisplayAttackStats.NAME, onDisplayAttackStats, this);
            Eventer.listen(MonstroEventResize.NAME, onResize, this);
            Eventer.listen(MonstroEventLockHud.NAME, onLockHud, this);

            add(_statsWindow);
            add(_attackWindow);
            add(_timeoutWindow);
            add(_tooltip);

            _visibleButtons = new Vector.<MonstroHudButton>();

            _visibleButtons.push(_buttonMenu);
            _visibleButtons.push(_buttonHelp);
            _visibleButtons.push(_buttonObjective);

            _visibleButtons.push(_buttonUndo);
            _visibleButtons.push(_buttonEndTurn);

            if (MonstroConsts.enableZoomButtons) {
                _visibleButtons.push(_buttonZoomOut);
                _visibleButtons.push(_buttonZoomIn);
            }

            onResize();

            for each(var button:MonstroHudButton in _visibleButtons) {
                add(button);
                button.enabled = false;
				button.onMouseOver.add(buttonMouseOverHandler);
				button.onMouseOut.add(buttonMouseOutHandler);
            }

            _statsWindow.onStatsHovered.add(statsWindowHoverHandler);

            _buttonMenu.enabled = true;
			_buttonHelp.enabled = true;
			_buttonObjective.enabled = true;
            _buttonZoomIn.enabled = true;
            _buttonZoomOut.enabled = true;

            _timeoutWindow.y = MonstroConsts.hudSpacer | 0;
        }

        private function onLockHud(event:MonstroEventLockHud):void{
            _isHudLocked = event.lockHud;
        }

        override final public function dispose():void {
            _statsWindow.dispose();
            _statsWindow = null;

            _attackWindow.dispose();
            _attackWindow = null;

            _timeoutWindow.dispose();
            _timeoutWindow = null;

            for each(var hudButton:MonstroHudButton in _visibleButtons) {
                hudButton.dispose();
            }
            _visibleButtons.length = 0;
            _visibleButtons = null;

            ingameState = null;
            _buttonEndTurn = null;
            _buttonMenu = null;
            _buttonUndo = null;
            _buttonZoomIn = null;
            _buttonZoomOut = null;


            clear();

			Eventer.releaseContext(this);

            super.dispose();
        }

        final public function update():void {
			_attackStatsHiddenThisTurn = false;

            _statsWindow.update();
            _attackWindow.update();

            var currentProcess:IMonstroTurnProcess = ingameState.processManager.currentProcess;
            if (currentProcess is MonstroPlayerTurnProcess) {
                _buttonEndTurn.enabled = true;
                _buttonUndo.enabled = UndoManager.instance.hasAnyUndo() && !ingameState.hasBlockingActions;
            } else {
                _buttonEndTurn.enabled = false;
                _buttonUndo.enabled = false;
            }

            _buttonZoomIn.enabled = (ingameState.zoomManager.zoomLevel < ingameState.zoomManager.totalZoomLevels - 1);
            _buttonZoomOut.enabled = (ingameState.zoomManager.zoomLevel > 0);


			if (_isHudLocked || ingameState.hasBlockingActions){
				_buttonEndTurn.enabled = false;
				_buttonUndo.enabled = false;
			} else {
				_buttonMenu.enabled = true;
				_buttonHelp.enabled = true;
				_buttonObjective.enabled = true;
			}

			if (_isHudLocked){
				_buttonMenu.enabled = false;
				_buttonHelp.enabled = false;
				_buttonObjective.enabled = false;
				_buttonZoomIn.enabled = false;
				_buttonZoomOut.enabled = false;
				_buttonEndTurn.enabled = false;
				_buttonUndo.enabled = false;
			}
		}

		private function buttonMouseOverHandler(button:MonstroHudButton):void {
			var message:String;
			switch(button){
				case(_buttonMenu): message = _("hud.button.menu"); break;
				case(_buttonHelp): message = _("hud.button.help"); break;
				case(_buttonObjective): message = _("hud.button.objectives"); break;
				case(_buttonZoomIn): message = _("hud.button.zoomIn"); break;
				case(_buttonZoomOut): message = _("hud.button.zoomOut"); break;
				case(_buttonUndo): message = _("hud.button.undo"); break;
				case(_buttonEndTurn): message = _("hud.button.endTurn"); break;
			}
			_tooltip.showToButton(message, button);
		}

		private function statsWindowHoverHandler(message:String, hudElement:DisplayObject):void {
            if (hudElement){
                _tooltip.showToStats(message, hudElement, _statsWindow);
            } else {
                _tooltip.hide();
            }
		}

		private function buttonMouseOutHandler(button:MonstroHudButton):void {
			_tooltip.hide();
		}

        private function onUnitDisabled(e:MonstroEventUnitDisable):void {
            if (e.unit.controlledBy.isPlayer()) {
                _statsWindow.hide();
            }
        }

        private function onTurnProcessChanged(e:MonstroEventTurnProcessIsChanging):void {
            _buttonEndTurn.enabled = !(e.newProcess is MonstroEnemyTurnProcess);
        }

        private function onDisplayAttackStats(event:MonstroEventDisplayAttackStats):void {
            if (event.show && event.attacker !== event.defender) {
				_statsWindow.hide(true);
                _attackWindow.setUnit(event.attacker, event.defender);
                _attackWindow.recalculate(event.showTapNotification);
                _attackWindow.show();
            } else {
				_attackStatsHiddenThisTurn = !_attackWindow.isHidden || _attackStatsHiddenThisTurn;
				_attackWindow.hide();
			}
        }

        private function onDisplayUnitStats(e:MonstroEventDisplayUnitStats):void {
            if (e.unit) {
                _statsWindow.setUnit(e.unit);
                _statsWindow.show(_attackStatsHiddenThisTurn);

            } else {
                _statsWindow.hide();
            }
        }
        private function onDisplayTrapStats(e:MonstroEventDisplayTrapStats):void {
            if (e.trap) {
                _statsWindow.setTrap(e.trap);
                _statsWindow.show(_attackStatsHiddenThisTurn);

            } else {
                _statsWindow.hide();
            }
        }

        private function onResize():void {
            var buttonEdge:Number = calculateButtonEdge();

            var previousButton:MonstroHudButton = null;

			var offsetY:Number = (MonstroConsts.gameHeight - _visibleButtons.length * buttonEdge - (_visibleButtons.length - 1) * MonstroConsts.hudSpacer) / 2;

            for each(var button:MonstroHudButton in _visibleButtons) {
                button.width = buttonEdge;
                button.height = buttonEdge;

				button.x = MonstroConsts.hudSpacer | 0;
                if (previousButton) {
                    button.y = previousButton.bottom + MonstroConsts.hudSpacer | 0;
                } else {
                    button.y = MonstroConsts.hudSpacer | 0;
                    button.y = offsetY + MonstroConsts.hudSpacer | 0;
                }

                previousButton = button;
            }

            _timeoutWindow.right = MonstroConsts.gameWidth - MonstroConsts.hudSpacer;
            _statsWindow.y = _timeoutWindow.bottom + MonstroConsts.hudSpacer;
            _attackWindow.y = _statsWindow.y;// + _statsWindow.currentHeight + MonstroConsts.hudSpacer | 0;
        }

		private function calculateButtonEdge():Number {
			return (MonstroConsts.gameHeight - (_visibleButtons.length + 1) * MonstroConsts.hudSpacer) / _visibleButtons.length;
		}

        private function onMenu():void {
            MonstroWindowPauseGame.show();
            RetrocamelEventsQueue.add(MonstroConsts.EVENT_PAUSE_MENU_OPENED);
			_tooltip.hide();
        }

        private function onEndTurn():void {
            new MonstroEventEndTurn();
			_tooltip.hide();
        }

        private function onUndo():void {
            new MonstroEventUndo();
			_tooltip.hide();
        }

        private function onZoom(target:MonstroHudButton):void {
            new MonstroEventZoomChange(target == _buttonZoomIn);
			_tooltip.hide();
        }

        private function onHelp():void {
            MonstroWindowHelp.showWindow();
			_tooltip.hide();
        }

        private function onObjective():void {
            MonstroWindowMissionObjective.show();
			_tooltip.hide();
        }
    }
}
