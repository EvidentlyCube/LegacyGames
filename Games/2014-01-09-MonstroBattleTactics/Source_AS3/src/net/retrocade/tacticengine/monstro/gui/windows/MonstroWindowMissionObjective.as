


package net.retrocade.tacticengine.monstro.gui.windows {
	import net.retrocade.constants.KeyConst;
	import net.retrocade.retrocamel.core.RetrocamelInputManager;
	import net.retrocade.retrocamel.display.starling.RetrocamelWindowStarling;
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.tacticengine.core.injector.injectCreate;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroEscapeBlocker;
	import net.retrocade.tacticengine.monstro.gui.components.MissionObjectives;
	import net.retrocade.tacticengine.monstro.gui.helpers.MonstroCursorManager;
	import net.retrocade.tacticengine.monstro.gui.helpers.WindowSliderCounter;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroDisplayGroup;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroPrettyWindowGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroTextButton;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventWindowClosed;

	public class MonstroWindowMissionObjective extends RetrocamelWindowStarling{
        public static function show():MonstroWindowMissionObjective{
            var instance:MonstroWindowMissionObjective = injectCreate(MonstroWindowMissionObjective);

			MonstroCursorManager.resetCursor();

            instance.show();

            return instance;
        }

		private var _background:MonstroPrettyWindowGrid9;
        private var _missionObjectives:MissionObjectives;
        private var _close:MonstroTextButton;

		private var _isHiding:Boolean;
		private var _sliderCounter:WindowSliderCounter;
		private var _modal:MonstroWindowModal;

        override public function show():void{
			_modal = MonstroWindowModal.show();

			initCreateObjects();
			initializeObjectProperties();


			var displayGroup:MonstroDisplayGroup = new MonstroDisplayGroup();
            displayGroup.addElement(_missionObjectives);
			displayGroup.addElement(_close);
			displayGroup.verticalize();
			displayGroup.alignAllCenter();

			_background.wrapAround(displayGroup);

            addChildren([_background, _missionObjectives, _close]);

            super.show();
            resize();

			displayGroup.dispose();
        }

		override public function hide():void {
			removeChildren();

			_background.dispose();
			_missionObjectives.dispose();
			_close.dispose();

			_background = null;
			_missionObjectives = null;
			_close = null;

			super.hide();

			new MonstroEventWindowClosed();
		}

		override public function update():void {
			if (MonstroEscapeBlocker.isEscapeDown || RetrocamelInputManager.isKeyHit(KeyConst.F2)) {
				MonstroEscapeBlocker.flush();

				startHiding();
			}

			if (_sliderCounter.update()) {
				refreshPosition();
			}

			if (_sliderCounter.isFullyHidden) {
				hide();
			}
		}

		private function refreshPosition():void {
			var calculatedPosition:Number = _sliderCounter.positionFactor;
			middle = MonstroConsts.gameHeight / 2 + calculatedPosition * (MonstroConsts.gameHeight / 2 + height);

			alignCenter();
		}

		private function initializeObjectProperties():void {
			_close.forcedWidth = _missionObjectives.width * 0.8;

			_background.header = "Mission objectives";

			_blockUnder = false;
		}

		private function initCreateObjects():void {
			_background = new MonstroPrettyWindowGrid9();
			_missionObjectives = new MissionObjectives();
			_close = new MonstroTextButton(_("title_close"), onClose);

			_sliderCounter = new WindowSliderCounter(1);
		}

		private function startShowing():void{
			_isHiding = false;

			_sliderCounter.show();
		}


		private function startHiding():void {
			if (_isHiding) {
				return;
			}

			_isHiding = true;
			_sliderCounter.hide();
		}

		private function onClose():void{
            startHiding();
        }


        override public function resize():void {
            refreshPosition();
        }
    }
}