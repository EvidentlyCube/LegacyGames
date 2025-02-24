package net.retrocade.tacticengine.monstro.gui.hud {
	import net.retrocade.tacticengine.monstro.gui.render.*;
	import net.retrocade.retrocamel.display.starling.RetrocamelMovieClipStarling;
	import net.retrocade.retrocamel.locale._;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.core.IDisposable;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.ingame.utils.MonstroAttackSimulation;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntityStatistics;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventResize;
    import net.retrocade.utils.UtilsNumber;
    import net.retrocade.utils.UtilsString;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.text.TextField;
    import starling.text.TextFieldBatch;
	import starling.textures.TextureSmoothing;
	import starling.utils.HAlign;

    public class MonstroHudAttackResults extends Sprite implements IDisposable {
        private static const COLOR_DEFAULT:uint = 0x382010;
        private static const COLOR_ATTACK:uint = 0x382010;
        private static const COLOR_DEFENSE:uint = 0x382010;
        private static const COLOR_HP:uint = 0x382010;
        private static const COLOR_DAMAGE_DONE:uint = 0x9E771D;
        private static const COLOR_NO_DAMAGE:uint = 0x382010;
        private static const COLOR_ALL_DRAINED:uint = 0xDB3131;
		private static const WINDOW_WIDTH:int = 386;
//        private static const COLOR_DEFENSE:uint = 0xDEDEDE;
//        private static const COLOR_HP:uint = 0xFFDEDE;
//        private static const COLOR_DAMAGE_DONE:uint = 0xFFAA66;
//        private static const COLOR_NO_DAMAGE:uint = 0x00FF00;
//        private static const COLOR_ALL_DRAINED:uint = 0xFF0000;

		private var _bgWindow:MonstroStatsWindowGrid9;
		private var _bgParchment:MonstroGrid9;
		private var _headerText:TextField;
        private var _attackText:TextField;
        private var _defenseText:TextField;
        private var _hpText:TextField;
        private var _attackIcon:Image;
        private var _defenseIcon:Image;
        private var _hpIcon:Image;
        private var _tapNotificationText:TextField;
        private var _isHidden:Boolean = false;

		private var _attackerDefenderIcon:Image;
		private var _unitPreviewAttacker:RetrocamelMovieClipStarling;
		private var _unitPreviewDefender:RetrocamelMovieClipStarling;

        public function MonstroHudAttackResults() {
        }

        public function init():void {
            const textHeight:int = 33;

			_bgWindow = new MonstroStatsWindowGrid9();
			_bgParchment = MonstroGfx.getGrid9Parchment();

            _attackerDefenderIcon = new Image(MonstroGfx.getCursorAttack());
            _attackIcon = MonstroGfx.getIconAttack();
            _defenseIcon = MonstroGfx.getIconDefense();
            _hpIcon = MonstroGfx.getIconHealth();

            _attackText = new TextField(80, textHeight, "0", MonstroConsts.FONT_EBORACUM_48, 32);
            _defenseText = new TextField(80, textHeight, "0", MonstroConsts.FONT_EBORACUM_48, 32);
			_hpText = new TextField(80, textHeight, "0", MonstroConsts.FONT_EBORACUM_48, 32);
			_tapNotificationText = new TextField(300, textHeight, _("tap_screen"), MonstroConsts.FONT_EBORACUM_48, 18, 0x382010);
			_headerText = new TextField(WINDOW_WIDTH, textHeight, _("attack_results"), MonstroConsts.FONT_EBORACUM_48, 32, 0x382010);
			_tapNotificationText.hAlign = HAlign.CENTER;

            _attackText.color = 0xFFFFFF;
			_defenseText.color = COLOR_DEFENSE;
            _hpText.color = COLOR_HP;

            _attackText.hAlign = HAlign.LEFT;
            _defenseText.hAlign = HAlign.LEFT;
            _hpText.hAlign = HAlign.LEFT;
            _tapNotificationText.hAlign = HAlign.CENTER;
			_headerText.hAlign = HAlign.CENTER;

            addChild(_bgWindow);
            addChild(_bgParchment);
            addChild(_headerText);
            addChild(_attackerDefenderIcon);
            addChild(_attackText);
            addChild(_defenseText);
            addChild(_hpText);
            addChild(_attackIcon);
            addChild(_defenseIcon);
            addChild(_hpIcon);
            addChild(_tapNotificationText);

            recalculate(false);

            Eventer.listen(MonstroEventResize.NAME, onResize, this);
        }

        override public function dispose():void {
			Eventer.releaseContext(this);

            removeChildren();

            if (_unitPreviewAttacker){
                _unitPreviewAttacker.dispose();
                _unitPreviewAttacker = null;
            }

            if (_unitPreviewDefender){
                _unitPreviewDefender.dispose();
                _unitPreviewDefender = null;
            }

            _attackerDefenderIcon.dispose();
            _bgWindow.dispose();
            _bgParchment.dispose();
            _headerText.dispose();
            _attackIcon.dispose();
            _attackText.dispose();
            _defenseIcon.dispose();
            _defenseText.dispose();
            _hpText.dispose();
            _hpIcon.dispose();
            _tapNotificationText.dispose();

            _attackerDefenderIcon = null;
            _bgParchment = null;
            _bgWindow = null;
            _headerText = null;
            _attackIcon = null;
            _attackText = null;
            _defenseIcon = null;
            _defenseText = null;
            _hpIcon = null;
            _hpText = null;
            _tapNotificationText = null;

            super.dispose();
        }


        public function setUnit(attacker:MonstroEntity, defender:MonstroEntity):void {
            var result:MonstroAttackSimulation = new MonstroAttackSimulation(attacker, defender);
            var attackerStats:MonstroEntityStatistics = attacker.getStatistics();
            var defenderStats:MonstroEntityStatistics = defender.getStatistics();

			if (_unitPreviewAttacker){
				removeChild(_unitPreviewAttacker);
				_unitPreviewAttacker.dispose();
			}

			if (_unitPreviewDefender){
				removeChild(_unitPreviewDefender);
				_unitPreviewDefender.dispose();
			}

			_unitPreviewAttacker = new RetrocamelMovieClipStarling(MonstroGfx.getWalkingUnitAnimation(attacker.unitType), 2);
			_unitPreviewDefender = new RetrocamelMovieClipStarling(MonstroGfx.getWalkingUnitAnimation(defender.unitType), 8);
			addChild(_unitPreviewAttacker);
			addChild(_unitPreviewDefender);

			_unitPreviewAttacker.smoothing = TextureSmoothing.NONE;
			_unitPreviewAttacker.scaleX = _unitPreviewAttacker.scaleY = 2;
			_unitPreviewDefender.smoothing = TextureSmoothing.NONE;
			_unitPreviewDefender.scaleX = _unitPreviewDefender.scaleY = 2;

			_unitPreviewAttacker.alignCenterParent(0, WINDOW_WIDTH / 2);
			_unitPreviewAttacker.middle = MonstroConsts.hudSpacer + 64;
			_unitPreviewDefender.alignCenterParent(WINDOW_WIDTH / 2, WINDOW_WIDTH / 2);
			_unitPreviewDefender.middle = MonstroConsts.hudSpacer + 64;

			_attackText.customBatches = new <TextFieldBatch>[
                new TextFieldBatch(UtilsString.padLeft(attackerStats.attack, 3), 0, 0, COLOR_ATTACK)
            ];
            _defenseText.customBatches = new <TextFieldBatch>[
                new TextFieldBatch(defenderStats.defense.toString()),
                new TextFieldBatch("->", 25),
                new TextFieldBatch(result.resultDefense.toString(), 60, 0, textGetColor(result.resultDefense, result.defenseDamage))
            ];
            _hpText.customBatches = new <TextFieldBatch>[
                new TextFieldBatch(defenderStats.hp.toString(), 0),
                new TextFieldBatch("->", 25),
                new TextFieldBatch(result.resultHP.toString(), 60, 0, textGetColor(result.resultHP, result.hpDamage))
            ];
        }

		public function recalculate(showTapNotification:Boolean):void {
            const margin:int = 45 + MonstroConsts.hudSpacer;
			const unitAnimationSpace:int = 128 + MonstroConsts.hudSpacer * 2;

            _attackIcon.x = margin;
            _defenseIcon.x = margin;
            _hpIcon.x = margin;

			_attackerDefenderIcon.alignCenterParent(0, WINDOW_WIDTH);
			_attackerDefenderIcon.middle = MonstroConsts.hudSpacer + 64;

			_headerText.y = MonstroConsts.hudSpacer + unitAnimationSpace | 0;

            _attackIcon.y = _headerText.bottom + MonstroConsts.hudSpacer - 6;
            _defenseIcon.y = _attackIcon.y + _attackIcon.height + MonstroConsts.hudSpacer;
            _hpIcon.y = _defenseIcon.y + _defenseIcon.height + MonstroConsts.hudSpacer;

            _attackText.x = _attackIcon.x + _attackIcon.width + MonstroConsts.hudSpacer * 2;
            _defenseText.x = _defenseIcon.x + _defenseIcon.width + MonstroConsts.hudSpacer * 2;
            _hpText.x = _hpIcon.x + _hpIcon.width + MonstroConsts.hudSpacer * 2;

            _attackText.y = _attackIcon.y + 9;
            _defenseText.y = _defenseIcon.y + 9;
            _hpText.y = _hpIcon.y + 9;

            _tapNotificationText.y = _hpIcon.y + _hpIcon.height + MonstroConsts.hudSpacer;
            _tapNotificationText.center = _bgWindow.center;

            _tapNotificationText.visible = showTapNotification;

            _bgWindow.width = WINDOW_WIDTH;
			_bgWindow.height = getWindowHeight(showTapNotification);

			_bgParchment.width = _bgWindow.innerWidth;
			_bgParchment.center = _bgWindow.center;
			_bgParchment.y = 121;
			_bgParchment.height = _bgWindow.innerHeight - _bgParchment.y + 20;
        }

		private function getWindowHeight(showTapNotification:Boolean):Number {
			if (showTapNotification){
				return _tapNotificationText.y + _tapNotificationText.height + MonstroConsts.hudSpacer * 2 + 45;
			} else {
				return _hpIcon.bottom + 45 + MonstroConsts.hudSpacer * 2;
			}
		}

        public function hide():void {
            _isHidden = true;
			recalculateToXCache();
			reposition(true);
        }

        public function show():void {
			_isHidden = false;
			recalculateToXCache();
			reposition(true);
        }

        public function update():void {
            reposition(false);

			if (_unitPreviewAttacker){
				_unitPreviewAttacker.advanceTime(50 / 3);
			}

			if (_unitPreviewDefender){
				_unitPreviewDefender.advanceTime(50 / 3);
			}
        }

        private function reposition(immediately:Boolean = false):void {
			if (x === toX){
				return;
			}

            if (immediately) {
                x = toX;
            } else {
                x = UtilsNumber.approach(x, toX, 0.3, 2, 30) | 0;
            }

            visible = x < MonstroConsts.gameWidth;
        }

        private function onResize():void {
			recalculateToXCache();
            reposition(true);
        }

        private function textGetColor(result:int, damage:int):uint {
            if (result == 0) {
                return COLOR_ALL_DRAINED;
            } else if (damage > 0) {
                return COLOR_DAMAGE_DONE;
            } else {
                return COLOR_DEFAULT;
            }
        }

		private var _toXCache:Number;
		private function recalculateToXCache():void{
			_toXCache = (_isHidden ? MonstroConsts.gameWidth + MonstroConsts.hudSpacer : MonstroConsts.gameWidth - MonstroConsts.hudSpacer - _bgWindow.width) | 0;
		}
		private function get toX():Number{
			return _toXCache;
		}


		public function get isHidden():Boolean {
			return _isHidden;
		}
	}
}