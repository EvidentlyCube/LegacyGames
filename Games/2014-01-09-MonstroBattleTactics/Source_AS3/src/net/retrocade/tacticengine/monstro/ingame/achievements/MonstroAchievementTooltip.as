package net.retrocade.tacticengine.monstro.ingame.achievements {
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.tacticengine.core.IDisposable;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
	import net.retrocade.tacticengine.monstro.gui.render.*;

	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class MonstroAchievementTooltip extends Sprite implements IDisposable {
		private var _bgParchment:MonstroGrid9;
		private var _bodyText:TextField;

		public function MonstroAchievementTooltip() {
			initializeObjects();
			initializeProperties();

			addChildren([_bgParchment, _bodyText]);

			visible = false;
		}

		override public function dispose():void {
			removeChildren();

			_bgParchment.dispose();
			_bodyText.dispose();

			_bgParchment = null;
			_bodyText = null;

			super.dispose();
		}

		public function showToAchievement(image:AchievementImage):void {
			var achievement:Achievement = image.achievement;

			visible = true;

			_bodyText.width = 400;
			_bodyText.height = 150;
			_bodyText.text = _("achievement.tooltip", _("achievement.title_" + achievement.index), _("achievement.description_" + achievement.index))
			_bodyText.height = _bodyText.textHeight + 20;

			_bgParchment.wrapAround(_bodyText);

			center = image.center;
			y = image.bottom + MonstroConsts.hudSpacer * 4;
		}

		public function hide():void {
			visible = false;
		}

		private function initializeObjects():void {
			_bgParchment = MonstroGfx.getGrid9Parchment();
			_bodyText = new TextField(170, 50, "0", MonstroConsts.FONT_NATIVE, 20, 0x382010);
			_bodyText.htmlText = true;
		}

		private function initializeProperties():void {
			_bodyText.hAlign = HAlign.CENTER;
			_bodyText.vAlign = VAlign.CENTER;
		}
	}
}