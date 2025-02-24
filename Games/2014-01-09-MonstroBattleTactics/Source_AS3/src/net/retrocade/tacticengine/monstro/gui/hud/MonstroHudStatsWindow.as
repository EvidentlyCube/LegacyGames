
package net.retrocade.tacticengine.monstro.gui.hud {
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.signal.Signal;
	import net.retrocade.tacticengine.monstro.gui.render.*;
	import net.retrocade.retrocamel.display.starling.RetrocamelMovieClipStarling;
	import net.retrocade.retrocamel.global.RetrocamelEventsQueue;
	import net.retrocade.tacticengine.core.Eventer;
	import net.retrocade.tacticengine.core.IDisposable;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
	import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
	import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntityStatistics;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventResize;
	import net.retrocade.tacticengine.monstro.ingame.traps.IMonstroTrap;
	import net.retrocade.tacticengine.monstro.ingame.traps.MonstroTrapSpike;
	import net.retrocade.utils.UtilsEvents;
	import net.retrocade.utils.UtilsNumber;

	import starling.display.DisplayObject;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.TextureSmoothing;
	import starling.utils.HAlign;

	public class MonstroHudStatsWindow extends Sprite implements IDisposable {

		private var _bgWindow:MonstroStatsWindowGrid9;
		private var _bgParchment:MonstroGrid9;
		private var _healthIcon:Image;
		private var _attackIcon:Image;
		private var _defenseIcon:Image;
		private var _movementIcon:Image;
		private var _attackRangeIcon:Image;
		private var _specialtyIcon1:Image;
		private var _specialtyIcon2:Image;
		private var _specialtyIcon3:Image;
		private var _healthText:TextField;
		private var _attackText:TextField;
		private var _defenseText:TextField;
		private var _movementText:TextField;
		private var _attackRangeText:TextField;
		private var _specialtyText1:TextField;
		private var _specialtyText2:TextField;
		private var _specialtyText3:TextField;
		private var _headerText:TextField;
		private var _isHidden:Boolean = false;
		private var _unitPreview:RetrocamelMovieClipStarling;
		private var _tilePreview:Image;

		public var onStatsHovered:Signal;

		public function init():void {
			const iconEdge:int = 32;
			const margin:int = 45 + MonstroConsts.hudSpacer;
			const normalTextWidth:int = 90;
			const textHeight:int = 33;
			const iconSpaceHorizontal:int = normalTextWidth + iconEdge + MonstroConsts.hudSpacer * 2;
			const headerOffset:int = 70;
			const unitAnimationSpace:int = 48 * 2 + MonstroConsts.hudSpacer * 2;
			const specialtyTextWidth:int = normalTextWidth * 2 + iconEdge + MonstroConsts.hudSpacer * 2;
			const windowWidth:int = normalTextWidth * 2 + MonstroConsts.hudSpacer*2 + iconEdge * 2 + iconSpaceHorizontal;

			_bgWindow = new MonstroStatsWindowGrid9();
			_bgParchment = MonstroGfx.getGrid9Parchment();
			_healthIcon = MonstroGfx.getIconHealth();
			_attackIcon = MonstroGfx.getIconAttack();
			_defenseIcon = MonstroGfx.getIconDefense();
			_movementIcon = MonstroGfx.getIconMovement();
			_attackRangeIcon = MonstroGfx.getIconRange();
			_specialtyIcon1 = MonstroGfx.getIconRange();
			_specialtyIcon2 = MonstroGfx.getIconRange();
			_specialtyIcon3 = MonstroGfx.getIconRange();

			_healthText = new TextField(normalTextWidth, textHeight, "7", MonstroConsts.FONT_EBORACUM_48, 32, 0x382010);
			_movementText = new TextField(normalTextWidth, textHeight, "5", MonstroConsts.FONT_EBORACUM_48, 32, 0x382010);
			_attackText = new TextField(normalTextWidth, textHeight, "3", MonstroConsts.FONT_EBORACUM_48, 32, 0x382010);
			_defenseText = new TextField(normalTextWidth, textHeight, "2/2", MonstroConsts.FONT_EBORACUM_48, 32, 0x382010);
			_attackRangeText = new TextField(normalTextWidth, textHeight, "1", MonstroConsts.FONT_EBORACUM_48, 32, 0x382010);
			_specialtyText1 = new TextField(specialtyTextWidth, _attackRangeIcon.height, "text 1", MonstroConsts.FONT_EBORACUM_48, 24, 0x382010);
			_specialtyText2 = new TextField(specialtyTextWidth, _attackRangeIcon.height, "text 2", MonstroConsts.FONT_EBORACUM_48, 24, 0x382010);
			_specialtyText3 = new TextField(specialtyTextWidth, _attackRangeIcon.height, "text 3", MonstroConsts.FONT_EBORACUM_48, 24, 0x382010);
			_headerText = new TextField(65, textHeight, "UnitName", MonstroConsts.FONT_EBORACUM_48, 32, 0x382010);
			onStatsHovered = new Signal();

			_healthText.hAlign = HAlign.LEFT;
			_movementText.hAlign = HAlign.LEFT;
			_attackText.hAlign = HAlign.LEFT;
			_defenseText.hAlign = HAlign.LEFT;
			_attackRangeText.hAlign = HAlign.LEFT;
			_specialtyText1.hAlign = HAlign.LEFT;
			_specialtyText2.hAlign = HAlign.LEFT;
			_specialtyText3.hAlign = HAlign.LEFT;

			_healthIcon.x = margin;
			_movementIcon.x = margin;
			_attackRangeIcon.x = margin;
			_defenseIcon.x = margin + MonstroConsts.hudSpacer + iconSpaceHorizontal | 0;
			_attackIcon.x = margin + MonstroConsts.hudSpacer + iconSpaceHorizontal | 0;

			_headerText.y = headerOffset + unitAnimationSpace - _headerText.height | 0;
			_healthIcon.y = headerOffset + unitAnimationSpace | 0;
			_movementIcon.y = _healthIcon.bottom + MonstroConsts.hudSpacer | 0;
			_attackRangeIcon.y = _movementIcon.bottom + MonstroConsts.hudSpacer | 0;
			_attackIcon.y = headerOffset + unitAnimationSpace | 0;
			_defenseIcon.y = _attackIcon.bottom + MonstroConsts.hudSpacer | 0;

			_healthText.x = _healthIcon.right + MonstroConsts.hudSpacer | 0;
			_movementText.x = _movementIcon.right + MonstroConsts.hudSpacer | 0;
			_attackRangeText.x = _attackRangeIcon.right + MonstroConsts.hudSpacer | 0;
			_attackText.x = _attackIcon.right + MonstroConsts.hudSpacer | 0;
			_defenseText.x = _defenseIcon.right + MonstroConsts.hudSpacer | 0;

			_healthText.y = _healthIcon.y + 9;
			_movementText.y = _movementIcon.y + 9;
			_attackRangeText.y = _attackRangeIcon.y + 9;
			_attackText.y = _attackIcon.y + 9;
			_defenseText.y = _defenseIcon.y + 9;

			_specialtyIcon1.x = margin | 0;
			_specialtyIcon2.x = margin | 0;
			_specialtyIcon3.x = margin | 0;
			_specialtyText1.x = _specialtyIcon1.right + MonstroConsts.hudSpacer | 0;
			_specialtyText2.x = _specialtyIcon2.right + MonstroConsts.hudSpacer | 0;
			_specialtyText3.x = _specialtyIcon3.right + MonstroConsts.hudSpacer | 0;

			_specialtyIcon1.y = _attackRangeIcon.bottom + MonstroConsts.hudSpacer | 0;
			_specialtyIcon2.y = _specialtyIcon1.bottom + MonstroConsts.hudSpacer | 0;
			_specialtyIcon3.y = _specialtyIcon2.bottom + MonstroConsts.hudSpacer | 0;
			_specialtyText1.y = _specialtyIcon1.y | 0;
			_specialtyText2.y = _specialtyIcon2.y | 0;
			_specialtyText3.y = _specialtyIcon3.y | 0;

			_bgWindow.width = windowWidth | 0;
			_bgWindow.height = _specialtyIcon3.bottom + MonstroConsts.hudSpacer + 150 | 0;

			_headerText.width = _bgWindow.width;

			addChild(_bgWindow);
			addChild(_bgParchment);
			addChild(_healthIcon);
			addChild(_attackIcon);
			addChild(_defenseIcon);
			addChild(_movementIcon);
			addChild(_attackRangeIcon);
			addChild(_specialtyIcon1);
			addChild(_specialtyIcon2);
			addChild(_specialtyIcon3);
			addChild(_healthText);
			addChild(_attackText);
			addChild(_defenseText);
			addChild(_movementText);
			addChild(_attackRangeText);
			addChild(_specialtyText1);
			addChild(_specialtyText2);
			addChild(_specialtyText3);
			addChild(_headerText);

			UtilsEvents.addListeners(TouchEvent.TOUCH, touchHandler, [
				_healthIcon, _healthText, _attackIcon, _attackText,
				_defenseIcon, _defenseText, _movementIcon, _movementText,
				_attackRangeIcon, _attackRangeText
			]);

			Eventer.listen(MonstroEventResize.NAME, onResize, this);
		}

		override public function dispose():void {
			Eventer.releaseContext(this);

			removeChildren();

			if (_unitPreview){
				_unitPreview.dispose();
				_unitPreview = null;
			}

			if (_tilePreview){
				_tilePreview.dispose();
				_tilePreview = null;
			}

			_bgWindow.dispose();
			_bgParchment.dispose();
			_healthIcon.dispose();
			_attackIcon.dispose();
			_defenseIcon.dispose();
			_movementIcon.dispose();
			_attackRangeIcon.dispose();
			_specialtyIcon1.dispose();
			_specialtyIcon2.dispose();
			_specialtyIcon3.dispose();
			_healthText.dispose();
			_attackText.dispose();
			_defenseText.dispose();
			_movementText.dispose();
			_attackRangeText.dispose();
			_specialtyText1.dispose();
			_specialtyText2.dispose();
			_specialtyText3.dispose();
			_headerText.dispose();
			onStatsHovered.clear();

			_bgWindow = null;
			_bgParchment = null;
			_healthIcon = null;
			_attackIcon = null;
			_defenseIcon = null;
			_movementIcon = null;
			_attackRangeIcon = null;
			_specialtyIcon1 = null;
			_specialtyIcon2 = null;
			_specialtyIcon3 = null;
			_healthText = null;
			_attackText = null;
			_defenseText = null;
			_movementText = null;
			_attackRangeText = null;
			_specialtyText1 = null;
			_specialtyText2 = null;
			_specialtyText3 = null;
			_headerText = null;
			onStatsHovered = null;

			super.dispose();
		}

		public function hide(immediately:Boolean = false):void {
            _isHidden = true;

			recalculateToXCache();
			reposition(immediately);
		}

		public function show(immediately:Boolean = false):void {
			_isHidden = false;

			recalculateToXCache();
			reposition(immediately);
		}

		public function setTrap(trap:IMonstroTrap):void{
			if (_tilePreview){
				removeChild(_tilePreview);
				_tilePreview.dispose();
				_tilePreview = null;
			}

			if (_unitPreview){
				removeChild(_unitPreview);
				_unitPreview.dispose();
				_unitPreview = null;
			}

			_tilePreview = MonstroGfx.getTrap(trap.type);
			_tilePreview.smoothing = TextureSmoothing.NONE;
			_tilePreview.scaleX = _tilePreview.scaleY = 2;
			addChild(_tilePreview);

			_tilePreview.alignCenterParent();
			_tilePreview.middle = _headerText.y - MonstroConsts.hudSpacer - 64;

			if (trap is MonstroTrapSpike){
				_attackText.text = ". . " + MonstroTrapSpike(trap).damage;

			} else {
				_attackText.text = " ---";
			}
			_headerText.text = _("trapName." + trap.name);
			_healthText.text = " ---";
			_defenseText.text = " --/--";
			_movementText.text = " ---";
			_attackRangeText.text = " ---";

			clearSpecializations();

			fitParchment();
		}

		public function setUnit(unit:MonstroEntity):void {
			var unitStats:MonstroEntityStatistics = unit.getStatistics();

			if (_tilePreview){
				removeChild(_tilePreview);
				_tilePreview.dispose();
				_tilePreview = null;
			}

			if (_unitPreview){
				removeChild(_unitPreview);
				_unitPreview.dispose();
				_unitPreview = null;
			}

			_unitPreview = new RetrocamelMovieClipStarling(MonstroGfx.getWalkingUnitAnimation(unit.unitType), 2);
			_unitPreview.smoothing = TextureSmoothing.NONE;
			_unitPreview.scaleX = _unitPreview.scaleY = 2;
			addChild(_unitPreview);

			_unitPreview.alignCenterParent();
			_unitPreview.middle = _headerText.y - MonstroConsts.hudSpacer - 64;

			if (unit.attackable){
				_healthText.text = ". . " + unitStats.hp.toString();
				_attackText.text = ". . " + unitStats.attack.toString();
				_defenseText.text = ". " + unitStats.defense + "/" + unitStats.defenseMax;
				_movementText.text = ". . " + unitStats.movesMax.toString();

				if (unit.getAttackDistanceMin() != unit.getAttackDistanceMax()) {
					_attackRangeText.text = ". " + unit.getAttackDistanceMin() + "-" + unit.getAttackDistanceMax();
				} else {
					_attackRangeText.text = ". . " + unit.getAttackDistanceMax().toString();
				}
			} else {
				_healthText.text = ". . -";
				_attackText.text = ". . -";
				_defenseText.text = ". -/-";
				_movementText.text = ". . -";
				_attackRangeText.text = ". . -";
			}

			if (unit.getSpecializationsCount() > 0) {
				RetrocamelEventsQueue.add(MonstroConsts.EVENT_SHOWN_STATS_FOR_SPECIALIZATION);
			}

			fillSpecialization(0, unit, _specialtyIcon1, _specialtyText1);
			fillSpecialization(1, unit, _specialtyIcon2, _specialtyText2);
			fillSpecialization(2, unit, _specialtyIcon3, _specialtyText3);

			fitParchment();

			_headerText.text = unit.prettyName;
		}

		private function fitParchment():void {
			_bgParchment.width = _bgWindow.innerWidth;
			_bgParchment.center = _bgWindow.center;
			_bgParchment.y = _headerText.y - 22;
			_bgParchment.height = _bgWindow.innerHeight - _bgParchment.y + 20;
		}

		public function clearSpecializations():void {
			_specialtyIcon1.visible = false;
			_specialtyIcon2.visible = false;
			_specialtyIcon3.visible = false;
			_specialtyText1.visible = false;
			_specialtyText2.visible = false;
			_specialtyText3.visible = false;

			var toAlign:DisplayObject = _attackRangeIcon;

			_bgWindow.height = toAlign.bottom + MonstroConsts.hudSpacer + 45 + MonstroConsts.hudSpacer;
		}

		public function fillSpecialization(index:int, unit:MonstroEntity, icon:Image, textField:TextField):void {
			if (unit.getSpecializationsCount() > index) {
				icon.texture = unit.getSpecialization(index).getLargeIconTexture();
				textField.text = unit.getSpecialization(index).getDescription();
				icon.visible = true;
				textField.visible = true;
			} else {
				textField.text = "---";

				icon.visible = false;
				textField.visible = false;
			}

			if (unit.getSpecializationsCount() <= index) {
				icon.visible = false;
				textField.visible = false;

			} else {
				icon.visible = true;
				textField.visible = true;
			}

			var toAlign:DisplayObject = (unit.getSpecializationsCount() == 0 ? _attackRangeIcon :
					unit.getSpecializationsCount() == 1 ? _specialtyIcon1 :
					unit.getSpecializationsCount() == 2 ? _specialtyIcon2 :
				_specialtyIcon3);

			_bgWindow.height = toAlign.bottom + MonstroConsts.hudSpacer + 45 + MonstroConsts.hudSpacer;
		}

		public function update():void {
			reposition(false);
			_unitPreview ? _unitPreview.advanceTime(50/3) :null;
		}

		private function onResize():void {
			recalculateToXCache();
			reposition(true);
		}

		private function reposition(immediately:Boolean = false):void {
			if (x === toX){
				return;
			}

			if (immediately) {
				x = toX | 0;
			} else {
				x = UtilsNumber.approach(x, toX, 0.5, 2, 50) | 0;
			}

			y = y | 0;

			visible = x < MonstroConsts.gameWidth;
		}

		private var _toXCache:Number;
		private function recalculateToXCache():void{
			_toXCache = (_isHidden ? MonstroConsts.gameWidth + MonstroConsts.hudSpacer : MonstroConsts.gameWidth - MonstroConsts.hudSpacer - _bgWindow.width) | 0;
		}
		private function get toX():Number{
			return _toXCache;
		}

		private function touchHandler(event:TouchEvent):void{
			var touch:Touch = event.getTouch(event.target as DisplayObject);

			if (!touch) {
				onStatsHovered.call(null, null);
			} else if (touch.phase == TouchPhase.HOVER) {
				RetrocamelEventsQueue.add(MonstroConsts.EVENT_HOVERED_OVER_STATS);
				onStatsHovered.call(getTooltipForElement(event.currentTarget as DisplayObject), event.currentTarget);
			}
		}

		private function getTooltipForElement(element:DisplayObject):String{
			switch(element){
				case(_attackIcon):
				case(_attackText):
					return "Damage.\nFirst drains the defense,\nthen the health of the target.";
				case(_defenseIcon):
				case(_defenseText):
					return "Defense.\nRestores at the beginning of each turn.";
				case(_healthIcon):
				case(_healthText):
					return "Health.\nWhen fully depleted the unit dies.";
				case(_movementIcon):
				case(_movementText):
					return "Movement range.";
				case(_attackRangeIcon):
				case(_attackRangeText):
					return "Attack range.\nSome units can't attack enemies standing next to them.";
				default:
					return "";
			}
		}
	}
}
