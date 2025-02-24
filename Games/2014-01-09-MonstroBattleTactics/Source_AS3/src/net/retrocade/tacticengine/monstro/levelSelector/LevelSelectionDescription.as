package net.retrocade.tacticengine.monstro.levelSelector {
	import net.retrocade.retrocamel.core.RetrocamelInputManager;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.gui.components.MissionObjectives;

	import starling.display.DisplayObject;

	import starling.display.Sprite;

	public class LevelSelectionDescription extends Sprite{
		private var _objectives:MissionObjectives;

		public function LevelSelectionDescription() {
			_objectives = new MissionObjectives();
			addChild(_objectives);

			touchable = false;

			scaleX = scaleY = 0.5;
		}

		public function show(to:DisplayObject):void{
			visible = true;

			x = RetrocamelInputManager.mouseX + 20;
			middle = RetrocamelInputManager.mouseY;

			if (right > MonstroConsts.gameWidth - 20){
				right = RetrocamelInputManager.mouseX - 20;
			}
		}

		public function hide():void{
			visible = false;
		}
	}
}
