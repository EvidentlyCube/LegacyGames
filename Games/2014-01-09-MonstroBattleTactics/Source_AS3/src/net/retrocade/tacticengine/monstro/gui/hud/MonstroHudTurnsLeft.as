package net.retrocade.tacticengine.monstro.gui.hud {
	import net.retrocade.tacticengine.monstro.gui.render.*;
    import flash.utils.setTimeout;

	import net.retrocade.functions.printf;

	import net.retrocade.retrocamel.locale._;

    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.core.IDisposable;
	import net.retrocade.tacticengine.core.MonstroField;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.global.states.MonstroStateIngame;
    import net.retrocade.tacticengine.monstro.ingame.condition.IMonstroCondition;
    import net.retrocade.tacticengine.monstro.ingame.condition.MonstroLossConditionStallTurns;
    import net.retrocade.tacticengine.monstro.ingame.condition.MonstroVictoryConditionSurviveTurns;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventChangeConditions;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTurnProcessIsChanging;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUndidCurrentTurn;

	import starling.display.Sprite;
    import starling.text.TextField;
	import starling.utils.HAlign;

	public class MonstroHudTurnsLeft extends Sprite implements IDisposable {
        private static const COLOR_SURVIVE:uint = 0x008800;
        private static const COLOR_STALL:uint = 0x880000;
		private static const WINDOW_WIDTH:int = 386;

        [Inject]
        public var ingameState:MonstroStateIngame;
        [Inject]
        public var field:MonstroField;

		private var _bgWindow:MonstroStatsWindowGrid9;
		private var _bgParchment:MonstroGrid9;
        private var _headerText:TextField;
        private var _resultText:TextField;
        private var _victoryCondition:MonstroVictoryConditionSurviveTurns;
        private var _lossCondition:MonstroLossConditionStallTurns;

        public function MonstroHudTurnsLeft() {}

		public function init():void {
			initializeObjects();
			initializeProperties();

			addChildren([_bgWindow, _bgParchment, _headerText, _resultText]);

            Eventer.listen(MonstroEventChangeConditions.NAME, onConditionsChanged, this);
            Eventer.listen(MonstroEventTurnProcessIsChanging.NAME, onTurnProcessChanged, this);
            Eventer.listen(MonstroEventUndidCurrentTurn.NAME, onTurnProcessChanged, this);

            updateConditions(ingameState.lossCondition, ingameState.victoryCondition);
        }

		override public function dispose():void {
			Eventer.releaseContext(this);

			removeChildren();

			_bgWindow.destroy();
			_headerText.dispose();
			_resultText.dispose();

			_bgWindow = null;
			_headerText = null;
			_resultText = null;

			super.dispose();
		}

		private function initializeObjects():void {
			_bgWindow = new MonstroStatsWindowGrid9();
			_bgParchment = MonstroGfx.getGrid9Parchment();
			_headerText = new TextField(MonstroConsts.fingerWidth * 4 + MonstroConsts.hudSpacer, 36, "0", MonstroConsts.FONT_EBORACUM_48, 28);
			_resultText = new TextField(MonstroConsts.fingerWidth * 4 + MonstroConsts.hudSpacer, 36, "0", MonstroConsts.FONT_EBORACUM_48, 28);
		}

		private function initializeProperties():void {
			_headerText.hAlign = HAlign.RIGHT;
			_resultText.hAlign = HAlign.LEFT;

			_headerText.color = 0x382010;
			_resultText.color = 0xFFFFFF;

			_headerText.width = WINDOW_WIDTH / 2 - 10;
			_resultText.width = WINDOW_WIDTH / 4;

			_bgWindow.width = WINDOW_WIDTH;
			_bgWindow.height = 140;

			_bgParchment.width = _bgWindow.innerWidth;
			_bgParchment.height = _bgWindow.innerHeight;
			_bgParchment.x = 20;
			_bgParchment.y = 20;

			_resultText.y = _headerText.y = 50;
		}

		public function updateConditions(lossCondition:IMonstroCondition, victoryCondition:IMonstroCondition):void {
            _victoryCondition = victoryCondition as MonstroVictoryConditionSurviveTurns;
            _lossCondition = lossCondition as MonstroLossConditionStallTurns;

            if (_victoryCondition) {
                _headerText.text = _("conds_victoryIn");
                _resultText.color = COLOR_SURVIVE;
            } else if (_lossCondition) {
                _headerText.text = _("conds_failureIn");
                _resultText.color = COLOR_STALL;
            } else {
				_headerText.text = "Current turn: ";
                _resultText.color = COLOR_STALL;
			}

			updateTurnCount();
        }

        public function onConditionsChanged(event:MonstroEventChangeConditions):void {
            updateConditions(event.lossCondition, event.victoryCondition);
        }

        public function onTurnProcessChanged():void {
            setTimeout(updateTurnCount, 30);
        }

        public function updateTurnCount():void {
			var currentTurn:int = field.currentTurn;
            var maxTurns:int = getTurnLimit();

            _resultText.text = maxTurns > 0 ? printf("%% / %%", currentTurn, maxTurns) : currentTurn.toString();

			var totalTextWidth:uint = _headerText.textWidth + _resultText.textWidth + 10;
			_headerText.right = (WINDOW_WIDTH  - totalTextWidth) / 2 + _headerText.textWidth;
			_resultText.x = _headerText.right + 10;
        }

        public function getTurnLimit():int {
            return _victoryCondition ? _victoryCondition.turnCount :
                _lossCondition ? _lossCondition.turnCount : 0;
        }
    }
}