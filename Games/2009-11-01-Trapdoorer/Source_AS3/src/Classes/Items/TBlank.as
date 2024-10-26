package Classes.Items{
	import Classes.Interactivers.TFall;
	import Classes.TLevel;
	import Classes.UndoHandler;

	public class TBlank extends TItem{
		[Embed("../../../assets/gfx/by_maurycy/gameplay/tile04.png")] public static var g_blank: Class;
		public function TBlank(_x: uint, _y: uint){
			x=_x
			y=_y

			addChild(new g_blank)
			TLevel.Set(x, y,this)
			TD.layerBlocks.addChild(this)
		}
		override public function CanLand(): Boolean{
			return true
		}
		override public function Boom(): void{
			TLevel.Remove(x, y)
			new TFall(x, y,g_blank)
			UndoHandler.add(this)
		}
		override public function Remove(): void{
			TD.layerBlocks.removeChild(this)
		}
		override public function Undo(): void{
			new TBlank(x, y)
		}
	}
}