package net.retrocade.tacticengine.monstro.levelSelector {
	public class LevelSelectionIslandDefinition {
		public var x:Number;
		public var y:Number;
		public var levelIndex:uint;
		public var islandImage:uint;

		public function LevelSelectionIslandDefinition(x:Number, y:Number, levelIndex:uint, islandImage:uint) {
			this.x = x;
			this.y = y;
			this.levelIndex = levelIndex;
			this.islandImage = islandImage;
		}
	}
}
