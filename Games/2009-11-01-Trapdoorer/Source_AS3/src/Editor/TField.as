package Editor{
	import Classes.SFX;
	import Classes.Scenes.TEditorScene;

	import flash.display.Sprite;
	public class TField extends Sprite{
		public var type: uint
		public function TField(fx: uint, fy: uint, ft: uint, chan: Boolean = true){
			x = fx*25
			y = fy*25
			type = ft
			if (type!=0){addChild(new (GiveClass(type)))}

			TEditorScene.layerBlocks.addChild(this)
		}
		override public function toString(): String{
			var result: String=""
			result += NumToText(type)
			return result;
		}
		public function remove(deArray: Boolean = false): void{
			TEditorScene.layerBlocks.removeChild(this)
			if (deArray){
				TEditorScene.layer[x/25][y/25]=null
			}
		}
	}
}