package net.retrocade.tacticengine.monstro.gui.hud {
	import flash.geom.Point;

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

	import starling.display.DisplayObject;

	import starling.display.Image;

	import starling.display.Sprite;
    import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class MonstroHudTooltip extends Sprite implements IDisposable {
		private var _bgParchment:MonstroGrid9;
        private var _bodyText:TextField;

        public function MonstroHudTooltip() {
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

		public function showToButton(message:String, hookTo:MonstroHudButton):void{
			visible = true;
			_bodyText.text = message;

			_bodyText.width = 170;
			_bodyText.height = 50;
			_bgParchment.wrapAround(_bodyText);

			middle = hookTo.middle;
			x = hookTo.right + MonstroConsts.hudSpacer;
		}

		public function showToStats(message:String, statDisplayObject:DisplayObject, statBox:DisplayObject):void{
			var positionGlobal:Point = statDisplayObject.localToGlobal(new Point(0, statDisplayObject.height / 2));

			visible = true;
			_bodyText.text = message;

			_bodyText.width = 260;
			_bodyText.height = 60;
			_bgParchment.wrapAround(_bodyText);

			middle = positionGlobal.y;
			right = statBox.x - MonstroConsts.hudSpacer;
		}

		public function hide():void {
			visible = false;
		}

		private function initializeObjects():void {
			_bgParchment = MonstroGfx.getGrid9Parchment();
			_bodyText = new TextField(170, 50, "0", MonstroConsts.FONT_EBORACUM_48, 20, 0x382010);
		}

		private function initializeProperties():void {
			_bodyText.hAlign = HAlign.CENTER;
			_bodyText.vAlign = VAlign.CENTER;
		}
    }
}