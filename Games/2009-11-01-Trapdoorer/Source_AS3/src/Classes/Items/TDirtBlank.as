package Classes.Items{
	import Classes.Interactivers.TDisappear;
	import Classes.TLevel;
	import Classes.UndoHandler;

	public class TDirtBlank extends TItem{
		[Embed("../../../assets/gfx/by_maurycy/gameplay/tile09.png")] public static var g: Class;
		public function TDirtBlank(_x: uint, _y: uint){
			x=_x
			y=_y

			addChild(new g)
			TLevel.Set(x, y,this)
			TD.layerBlocks.addChild(this)
		}
		override public function CanLand(): Boolean{
			return false;
		}
		override public function Boom(): void{
			TLevel.Remove(x, y)
			new TBlank(x, y)
			new TDisappear(x, y,g)
			UndoHandler.add(this)
		}
		override public function Remove(): void{
			TD.layerBlocks.removeChild(this)
		}
		override public function Undo(): void{
			new TDirt(x, y)
		}
	}
}