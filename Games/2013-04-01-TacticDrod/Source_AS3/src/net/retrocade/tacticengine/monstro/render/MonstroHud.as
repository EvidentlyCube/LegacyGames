/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 24.01.13
 * Time: 21:23
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.render {
    import net.retrocade.camel.interfaces.rIUpdatable;

    import net.retrocade.camel.layers.rLayerStarling;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.monstro.ais.IMonstroTurnProcess;
    import net.retrocade.tacticengine.monstro.ais.MonstroEnemyTurnProcess;
    import net.retrocade.tacticengine.monstro.ais.MonstroPlayerTurnProcess;

    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.core.MonstroGfx;

    import net.retrocade.tacticengine.monstro.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.events.MonstroEventDisplayAttackStats;
    import net.retrocade.tacticengine.monstro.events.MonstroEventEndTurn;
    import net.retrocade.tacticengine.monstro.events.MonstroEventNewAction;
    import net.retrocade.tacticengine.monstro.events.MonstroEventResize;
    import net.retrocade.tacticengine.monstro.events.MonstroEventStopUnit;
    import net.retrocade.tacticengine.monstro.events.MonstroEventTurnProcessChange;
    import net.retrocade.tacticengine.monstro.events.MonstroEventUndo;
    import net.retrocade.tacticengine.monstro.events.MonstroEventUnitDisable;
    import net.retrocade.tacticengine.monstro.events.MonstroEventDisplayUnitStats;
    import net.retrocade.tacticengine.monstro.events.MonstroEventUnitSelected;
    import net.retrocade.tacticengine.monstro.states.MonstroStateIngame;
    import net.retrocade.tacticengine.monstro.undo.UndoManager;
    import net.retrocade.tacticengine.monstro.windows.MonstroWindowPauseGame;

    public class MonstroHud extends rLayerStarling implements rIUpdatable {
        private var _bottomBarBg:MonstroGrid9;

        private var _buttonEndTurn:MonstroHudButton;
        private var _buttonMenu:MonstroHudButton;
        private var _buttonUndo:MonstroHudButton;
        private var _buttonEndUnitMove:MonstroHudButton;

        private var _statsWindow:MonstroHudStatsWindow;
        private var _attackWindow:MonstroHudAttackResults;

        private var _buttonOrder:Vector.<MonstroHudButton>;

        private var _isZoomedIn:Boolean = false;

        private var _ingameState:MonstroStateIngame;

        public function MonstroHud(ingameState:MonstroStateIngame) {
            super();

            _ingameState = ingameState;

            _bottomBarBg = MonstroGfx.getGrid9Window();
            _buttonEndTurn = new MonstroHudButton(MonstroGfx.getIconEndTurn(), MonstroGfx.getIconEndTurnDisabled(), onEndTurn);
            _buttonMenu = new MonstroHudButton(MonstroGfx.getIconMenu(), null, onMenu);
            _buttonUndo = new MonstroHudButton(MonstroGfx.getIconUndo(), MonstroGfx.getIconUndoDisabled(), onUndo);
            _buttonEndUnitMove = new MonstroHudButton(MonstroGfx.getIconUnitEndMove(), MonstroGfx.getIconUnitEndMoveDisabled(), onEndUnitMove);

            _statsWindow = new MonstroHudStatsWindow();
            _attackWindow = new MonstroHudAttackResults();

            _statsWindow.hide(true);
            _attackWindow.hide(true);

            _buttonEndTurn.enabled = true;
            _buttonMenu.enabled = true;

            Eventer.listen(MonstroEventDisplayUnitStats.NAME, onDisplayUnitStats);
            Eventer.listen(MonstroEventUnitDisable.NAME, onUnitDisabled);
            Eventer.listen(MonstroEventDisplayAttackStats.NAME, onDisplayAttackStats);
            Eventer.listen(MonstroEventResize.NAME, onResize);

            add(_statsWindow);
            add(_attackWindow);

            _buttonOrder = new Vector.<MonstroHudButton>();

            _buttonOrder.push(_buttonMenu);
            _buttonOrder.push(_buttonEndTurn);
            _buttonOrder.push(_buttonEndUnitMove);
            _buttonOrder.push(_buttonUndo);

            onResize();

            for each(var button:MonstroHudButton in _buttonOrder){
                add(button);
                button.y = Monstro.hudSpacer;
                button.enabled = false;
            }

            _buttonMenu.enabled = true;
        }

        public function update():void {
            _statsWindow.update();
            _attackWindow.update();

            var currentProcess:IMonstroTurnProcess = _ingameState.processManager.currentProcess;
            if (currentProcess is MonstroPlayerTurnProcess){
                var playerTurnProcess:MonstroPlayerTurnProcess = currentProcess as MonstroPlayerTurnProcess;

                _buttonEndTurn.enabled = true;
                _buttonUndo.enabled = UndoManager.instance.hasAnyUndo();
                _buttonEndUnitMove.enabled = playerTurnProcess.canStopUnitTurn();
            } else {
                _buttonEndTurn.enabled = false;
                _buttonUndo.enabled = false;
                _buttonEndUnitMove.enabled = false;
            }
        }

        private function onUnitDisabled(e:MonstroEventUnitDisable):void {
            if (e.unit.isPlayer) {
                _statsWindow.hide();
            }
        }

        private function onDisplayAttackStats(event:MonstroEventDisplayAttackStats):void {
            if (event.show && event.attacker !== event.defender) {
                _attackWindow.setUnit(event.attacker, event.defender);
                _attackWindow.recalculate(event.showTapNotification);
                _attackWindow.show();
            } else {
                _attackWindow.hide();
            }
        }

        private function onDisplayUnitStats(e:MonstroEventDisplayUnitStats):void {
            if (e.unit) {
                _statsWindow.setUnit(e.unit);
                _statsWindow.show();

            } else {
                _statsWindow.hide();
            }
        }

        private function onResize():void {
            var buttonEdge:Number = Monstro.fingerWidth * 2;

            _bottomBarBg.width = Monstro.gameWidth;
            _bottomBarBg.height = Monstro.bottomBarHeight;
            _bottomBarBg.y = Monstro.gameHeight - _bottomBarBg.height;

            var previousButton:MonstroHudButton = null;

            for each(var button:MonstroHudButton in _buttonOrder) {
                button.width = buttonEdge;
                button.height = buttonEdge;

                if (previousButton){
                    button.x = previousButton.x - Monstro.hudSpacer - button.width;
                } else {
                    button.x = Monstro.gameWidth - Monstro.hudSpacer - button.width;
                }

                previousButton = button;
            }

            _statsWindow.y = buttonEdge + Monstro.hudSpacer * 2;
            _attackWindow.y = _statsWindow.y + _statsWindow.height + Monstro.hudSpacer;
        }

        private function onMenu():void {
            MonstroWindowPauseGame.show();
        }

        private function onEndTurn():void {
            new MonstroEventEndTurn();
        }

        private function onEndUnitMove():void {
            new MonstroEventStopUnit();
        }

        private function onUndo():void {
            new MonstroEventUndo();
        }
    }
}