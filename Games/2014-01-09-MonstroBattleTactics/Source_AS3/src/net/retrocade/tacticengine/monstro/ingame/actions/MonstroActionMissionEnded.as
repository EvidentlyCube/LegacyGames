
package net.retrocade.tacticengine.monstro.ingame.actions {
    import net.retrocade.retrocamel.core.RetrocamelInputManager;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.global.core.MonstroSfx;
	import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;
	import net.retrocade.tacticengine.monstro.global.states.MonstroStateIngame;
    import net.retrocade.tacticengine.monstro.gui.windows.IWindowMissionFinished;
    import net.retrocade.tacticengine.monstro.gui.windows.WindowMissionFinishedOptions;
	import net.retrocade.tacticengine.monstro.gui.windows.MonstroWindowIntroductionCompleted;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventLockHud;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTap;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTransition;
    import net.retrocade.utils.UtilsNumber;

    import starling.display.Image;

    public class MonstroActionMissionEnded extends MonstroAction {
        private static const CHAR_CODE_SPACE:uint = 32;
        private static const CHAR_CODE_TILDE:uint = 126;

        private static const FADE_TO:Number = 0.7;
        private var _layer:RetrocamelLayerStarling;
        private var _phaseImage:Image;
        private var _bg:Image;
        private var _fadeIn:Boolean = true;
        private var _fadeOut:Boolean = false;
        private var _waiter:int = 0;
        private var _isVictory:Boolean;
        private var _playerIsHuman:Boolean;
        private var _showEndGameCampaignScreen:Boolean;
        private var _menuShown:Boolean = false;
        private var _musicDelay:uint = 60;
		private var _window:IWindowMissionFinished;
        private var _isSkipping:Boolean;

        public function MonstroActionMissionEnded(isVictory:Boolean, playerIsHuman:Boolean, showEndGameCampaignScreen:Boolean) {
            super(null);

            _isVictory = isVictory;
            _playerIsHuman = playerIsHuman;
            _showEndGameCampaignScreen = showEndGameCampaignScreen;
        }

		private function init():void {
			new MonstroEventLockHud(true);

			_layer = new RetrocamelLayerStarling();

			if (_isVictory) {
				if (_playerIsHuman) {
					_phaseImage = MonstroGfx.getHumansVictory();
				} else {
					_phaseImage = MonstroGfx.getMonstersVictory();
				}
			} else if (_playerIsHuman) {
				_phaseImage = MonstroGfx.getHumansLose();
			} else {
				_phaseImage = MonstroGfx.getMonstersLose();
			}

			_bg = MonstroGfx.getPhaseBackground();

			_bg.width = MonstroConsts.gameWidth;
			_bg.height = _phaseImage.height + 120;

			_phaseImage.alpha = 0;
			_bg.alpha = 0;

			_layer.add(_bg);
			_layer.add(_phaseImage);

			Eventer.listen(MonstroEventTap.NAME, skip, this);
		}

		override public function dispose():void {
			new MonstroEventLockHud(false);
			Eventer.releaseContext(this);

			if (_window){
				_window.hide();
			}

			_phaseImage.dispose();
			_layer.dispose();

			_phaseImage = null;
			_bg = null;
			_layer = null;

			super.dispose();
		}

        override public function update():Boolean {
            if (!_layer) {
                init();
            }

            if (RetrocamelInputManager.isAnyKeyDown(CHAR_CODE_SPACE, CHAR_CODE_TILDE)){
                skip();
            }

			if (_window){
				var toY:Number = _window.maxTopPosition - 30;

				_phaseImage.x = (MonstroConsts.gameWidth - _phaseImage.width) / 2;
				_phaseImage.bottom = UtilsNumber.approach(_phaseImage.bottom, toY, 0.1, 1);
				_bg.middle = _phaseImage.middle;

				if (_fadeOut){
					_bg.alpha -= 0.05;
					_phaseImage.alpha -= 0.05;

					if (_phaseImage.alpha <= 0){
						return true;
					}
				}

				return false;
			}

            if (_musicDelay) {
                _musicDelay--;
                if (_musicDelay == 0) {
                    playJingle();
                }
            }

            _phaseImage.x = (MonstroConsts.gameWidth - _phaseImage.width) / 2;
            _phaseImage.y = (MonstroConsts.gameHeight - _phaseImage.height) / 2;

            _bg.width = MonstroConsts.gameWidth;
            _bg.y = (MonstroConsts.gameHeight - _bg.height) / 2;

            if (_waiter > 0) {
                _waiter -= 1;
            } else if (_fadeIn) {
                _bg.alpha = UtilsNumber.approach(_bg.alpha, FADE_TO, 0.12 * skipMultiplier, 0.01);

                if (_bg.alpha >= FADE_TO) {
                    _phaseImage.alpha = UtilsNumber.approach(_phaseImage.alpha, 1, 0.12 * skipMultiplier, 0.01);

                    if (_phaseImage.alpha == 1) {
                        _fadeIn = false;
                        _waiter = _isSkipping ? 0 : 120;
                    }
                }
            } else if (!_menuShown) {
                _menuShown = true;

                if (_showEndGameCampaignScreen) {
					if (MonstroStateIngame.instance.currentCampaignType === EnumCampaignType.INTRODUCTION){
						_window = MonstroWindowIntroductionCompleted.showWindow();
						_window.onClosing.add(windowsStartHidingHandler);
						return false;
					} else {
						_fadeOut = true;
					}
                } else {
                    _window = WindowMissionFinishedOptions.showWindow(_isVictory);
					_window.onClosing.add(windowsStartHidingHandler);
                }

            } else if (_fadeOut) {
                _bg.alpha -= 0.025;
                _phaseImage.alpha -= 0.025;
            }

            if (_bg.alpha <= 0 && _phaseImage.alpha <= 0){
                if (_showEndGameCampaignScreen){
					new MonstroEventTransition(MonstroEventTransition.TRANSITION_SHOW_END_CAMPAIGN_SCREEN);
                }
                return true;
            } else {
                return false;
            }
        }

        private function playJingle():void {
            if (_isVictory) {
                if (_playerIsHuman) {
                    MonstroSfx.playJingleVictoryHumans();
                } else {
                    MonstroSfx.playJingleVictoryMonsters();
                }
            } else if (_playerIsHuman) {
                MonstroSfx.playJingleDefeatHumans();
            } else {
                MonstroSfx.playJingleDefeatMonsters();
            }
        }

        private function skip():void {
            if (_waiter > 0) {
                _waiter = 0;
                _fadeIn = false;
                _bg.alpha = FADE_TO;
                _phaseImage.alpha = 1;
                _isSkipping = true;
            }
        }

		private function windowsStartHidingHandler():void{
			_fadeOut = true;
		}

        override public function get canHaveMultipleInstances():Boolean {
            return false;
        }

		override public function get shouldSkipFrameAfterFinished():Boolean{
			return false;
		}

        public function get skipMultiplier():Number {
            return _isSkipping ? 3 : 1;
        }
    }
}
