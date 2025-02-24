


package net.retrocade.tacticengine.monstro.gui.windows {
	import net.retrocade.constants.KeyConst;
	import net.retrocade.retrocamel.core.RetrocamelInputManager;
	import net.retrocade.retrocamel.display.starling.RetrocamelWindowStarling;
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroEscapeBlocker;
	import net.retrocade.tacticengine.monstro.gui.helpers.MonstroCursorManager;
	import net.retrocade.tacticengine.monstro.gui.helpers.WindowSliderCounter;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroButton;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroDisplayGroup;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroPrettyWindowGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroTextButton;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventWindowClosed;

	public class MonstroWindowHelp extends RetrocamelWindowStarling {
		private static const BUTTON_WIDTH:Number = 400;

		public static function showWindow():void {
			var instance:MonstroWindowHelp = new MonstroWindowHelp();

			MonstroCursorManager.resetCursor();

			instance.show();
		}

		private var _background:MonstroPrettyWindowGrid9;
		private var _gameRules:MonstroTextButton;
		private var _controls:MonstroTextButton;
		private var _enemyMovement:MonstroTextButton;
		private var _traps:MonstroTextButton;
		private var _specializations:MonstroTextButton;
		private var _close:MonstroTextButton;
		private var _buttonsGroup:MonstroDisplayGroup;

		private var _isHiding:Boolean;
		private var _sliderCounter:WindowSliderCounter;
		private var _modal:MonstroWindowModal;
		private var _invertHiding:Boolean;
		private var _isClosing:Boolean;

		public function MonstroWindowHelp() {
			_blockUnder = false;

			initCreateObjects();

			_sliderCounter.onFinishedShowing.add(resetHidingInversion);

			_buttonsGroup.addElements(buttonsArray);
			_buttonsGroup.alignAllCenter();
			_buttonsGroup.verticalize(MonstroConsts.hudSpacer);

			_background.header = _("help.header");
			_background.wrapAround(_buttonsGroup);

			addChild(_background);
			addChildren(buttonsArray);
		}

		override public function hide():void {
			removeChildren();

			_background.dispose();
			_gameRules.dispose();
			_controls.dispose();
			_enemyMovement.dispose();
			_traps.dispose();
			_specializations.dispose();
			_close.dispose();
			_buttonsGroup.dispose();
			_sliderCounter.dispose();

			super.hide();

			new MonstroEventWindowClosed();
		}

		private function initCreateObjects():void {
			_background = new MonstroPrettyWindowGrid9();
			_gameRules = new MonstroTextButton(_("help.gameRules"), onGameRules, BUTTON_WIDTH);
			_controls = new MonstroTextButton(_("help.controls"), onControls, BUTTON_WIDTH);
			_enemyMovement = new MonstroTextButton(_("help.monsterMovement"), onEnemyMovement, BUTTON_WIDTH);
			_traps = new MonstroTextButton(_("help.traps"), onTraps, BUTTON_WIDTH);
			_specializations = new MonstroTextButton(_("help.specializations"), onSpecializations, BUTTON_WIDTH);
			_close = new MonstroTextButton(_("help.close"), onClose, BUTTON_WIDTH, MonstroButton.COLOR_RED);
			_buttonsGroup = new MonstroDisplayGroup();

			_sliderCounter = new WindowSliderCounter(1);
		}

		override public function show():void {
			_modal = MonstroWindowModal.show();

			super.show();

			resize();
		}

		private function startHiding():void {
			if (_isHiding) {
				return;
			}

			_isHiding = true;
			_sliderCounter.hide();
		}

		private function startClosing():void {
			startHiding();

			_modal.startHiding();

			_isClosing = true;
		}

		private function startShowing():void{
			visible = true;
			_isClosing = false;
			_isHiding = false;
			if (_sliderCounter.position >= 1){
				_sliderCounter.position = 1.2;
			}
			_sliderCounter.show();
		}

		override public function update():void {
			visible = true;

			if (MonstroEscapeBlocker.isEscapeDown || RetrocamelInputManager.isKeyHit(KeyConst.F1)) {
				MonstroEscapeBlocker.flush();

				startClosing();
			}

			if (_sliderCounter.update()) {
				refreshPosition();
			}

			if (_sliderCounter.isFullyHidden) {
				visible = false;
				if (_isClosing){
					hide();
				}
			}
		}

		private function refreshPosition():void {
			var calculatedPosition:Number = _sliderCounter.positionFactor;
			if (_invertHiding){
				middle = MonstroConsts.gameHeight / 2 - calculatedPosition * (MonstroConsts.gameHeight / 2 + height);
			} else {
				middle= MonstroConsts.gameHeight / 2 + calculatedPosition * (MonstroConsts.gameHeight / 2 + height);
			}

			alignCenter();
		}

		override public function resize():void {
			refreshPosition();
		}

		private function onGameRules():void {
			startHiding();
			_invertHiding = true;
			MonstroWindowHelpMessage.showWindow(_("help.game_rules.header"), _("help.game_rules.body"), 1200).onClosing.add(startShowing);
		}

		private function onEnemyMovement():void {
			startHiding();
			_invertHiding = true;
			MonstroWindowHelpMessage.showWindow(_("help.monster_movement.header"), _("help.monster_movement.body"), 1200).onClosing.add(startShowing);
		}

		private function onControls():void {
			startHiding();
			_invertHiding = true;
			MonstroWindowHelpMessage.showWindow(_("help.controls.header"), _("help.controls.body"), 900).onClosing.add(startShowing);
		}

		private function onTraps():void {
			startHiding();
			_invertHiding = true;
			MonstroWindowHelpMessage.showWindow(_("help.traps.header"), _("help.traps.body"), 700).onClosing.add(startShowing);
		}

		private function onSpecializations():void {
			startHiding();
			_invertHiding = true;
			MonstroWindowHelpMessage.showWindow(_("help.specializations.header"), _("help.specializations.body"), 700).onClosing.add(startShowing);
		}

		private function onClose():void {
			startClosing();
		}

		private function get buttonsArray():Array {
			return [_gameRules, _controls, _enemyMovement, _traps, _specializations, _close];
		}

		private function resetHidingInversion():void{
			_invertHiding = false;
		}
	}
}
