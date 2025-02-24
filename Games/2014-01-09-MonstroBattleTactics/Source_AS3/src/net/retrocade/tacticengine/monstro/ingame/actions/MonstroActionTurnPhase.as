
package net.retrocade.tacticengine.monstro.ingame.actions {
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
    import net.retrocade.retrocamel.locale._;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.core.FPSFixer;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.global.core.SmartTouch;
    import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitFaction;
    import net.retrocade.tacticengine.monstro.global.states.MonstroStateIngame;
	import net.retrocade.tacticengine.monstro.gui.components.MissionObjectives;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroDisplayGroup;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroPrettyWindowGrid9;
	import net.retrocade.tacticengine.monstro.ingame.condition.IMonstroCondition;
    import net.retrocade.tacticengine.monstro.ingame.condition.MonstroConditionFactory;
    import net.retrocade.tacticengine.monstro.ingame.condition.MonstroLossConditionStallTurns;
    import net.retrocade.tacticengine.monstro.ingame.condition.MonstroVictoryConditionSurviveTurns;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventLockHud;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTap;
    import net.retrocade.utils.UtilsNumber;

    import starling.display.Image;
    import starling.display.Sprite;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
    import starling.textures.TextureSmoothing;

    public class MonstroActionTurnPhase extends MonstroAction {
        private var _layer:RetrocamelLayerStarling;
        private var _phaseImage:Image;
		private var _phaseBackground:MonstroGrid9;
		private var _fadeIn:Boolean = true;
		private var _waiter:int = 0;
        private var _controlledType:EnumUnitFaction;
        private var _displayMeta:Boolean;

		private var _missionObjectives:MissionObjectives;
		private var _missionObjectiveWrapper:MonstroPrettyWindowGrid9;
		private var _missionObjectiveGroup:MonstroDisplayGroup;

        public function MonstroActionTurnPhase(controlledType:EnumUnitFaction, displayMeta:Boolean) {
            super(null);

            _controlledType = controlledType;
            _displayMeta = displayMeta;
        }

		private function init():void {
			if (_displayMeta){
				new MonstroEventLockHud(true);
			}

			SmartTouch.isFastforwardTouch = false;

			_layer = new RetrocamelLayerStarling();

			_phaseImage = (_controlledType.isHuman() ? MonstroGfx.getHumanTurn() : MonstroGfx.getMonsterTurn());
			_phaseImage.filter = BlurFilter.createGlow(0, 1, 3, 0.5);
			_phaseBackground = MonstroGfx.getGrid9Window();
			_phaseBackground.visible = false;

			_phaseBackground.smoothing = TextureSmoothing.NONE;

			_phaseImage.alpha = 0;
			_phaseBackground.alpha = 0;

			Eventer.listen(MonstroEventTap.NAME, onTap, this);

			if (_displayMeta) {
				_missionObjectives = new MissionObjectives();
				_missionObjectiveWrapper = new MonstroPrettyWindowGrid9();
				_missionObjectiveGroup = new MonstroDisplayGroup();
				_missionObjectiveGroup.addElements([_missionObjectives, _missionObjectiveWrapper]);
				_missionObjectiveWrapper.wrapAround(_missionObjectives);
				_missionObjectiveWrapper.header = "Mission objectives";

				_layer.add(_missionObjectiveWrapper);
				_layer.add(_missionObjectives);
			} else {
				_layer.add(_phaseBackground);
				_layer.add(_phaseImage);
			}
		}

        override public function dispose():void {
			if (_displayMeta) {
				new MonstroEventLockHud(false);
			}

			Eventer.releaseContext(this);
			_layer.dispose();

            if (_displayMeta) {
				_missionObjectives.dispose();
				_missionObjectives = null;
            }

			if (_missionObjectiveGroup){
				_missionObjectiveGroup.dispose();
				_missionObjectiveWrapper.dispose();
			}

			_phaseImage.dispose();
			_phaseBackground.dispose();

            _phaseImage = null;
            _phaseBackground = null;
            _layer = null;

            super.dispose();
        }

		override public function update():Boolean {
			if (!_layer) {
				init();
			}

			_phaseBackground.innerWidth = _phaseImage.width + MonstroConsts.hudSpacer * 4;
			_phaseBackground.innerHeight = _phaseImage.height + MonstroConsts.hudSpacer * 4;

			_phaseBackground.alignCenter();
			_phaseBackground.y = MonstroConsts.hudSpacer * 3;
			_phaseImage.center = _phaseBackground.center;
			_phaseImage.middle = _phaseBackground.middle;
			_phaseImage.alignCenter();
			_phaseImage.middle = 100;

			if (_waiter > 0) {
				_waiter -= FPSFixer.factor;
			} else if (_fadeIn) {
				_phaseBackground.alpha = UtilsNumber.approach(_phaseBackground.alpha, 1, 0.12, 0.01);
				_phaseImage.alpha = UtilsNumber.approach(_phaseImage.alpha, 1, 0.12, 0.01);

				if (_phaseBackground.alpha >= 1.0 && !_displayMeta) {
					_fadeIn = false;
					_waiter = 30;
				}
			} else {
				_phaseBackground.alpha = UtilsNumber.approach(_phaseBackground.alpha, 0, 0.12, 0.01);
				_phaseImage.alpha = UtilsNumber.approach(_phaseImage.alpha, 0, 0.12, 0.01);
			}


			if (_displayMeta) {
				_missionObjectiveGroup.alignCenter();
				_missionObjectiveGroup.alignMiddle();
				_missionObjectiveGroup.alpha = _phaseImage.alpha;
			}

			return _phaseBackground.alpha == 0 && _phaseImage.alpha == 0;
		}

        private function onTap():void {
            if (_phaseBackground.alpha > 0.1) {
                _waiter = 0;
                _fadeIn = false;
            }
        }

		override public function get isProcessManagerBlocked():Boolean
		{
			return _displayMeta;
		}
		override public function get isBlockingOtherActions():Boolean
		{
			return _displayMeta;
		}

		override public function get shouldSkipFrameAfterFinished():Boolean {
			return false;
		}
	}
}
