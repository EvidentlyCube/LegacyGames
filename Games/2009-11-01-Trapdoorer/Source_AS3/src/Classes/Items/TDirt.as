package Classes.Items{
	import Classes.Interactivers.TFall;
	import Classes.Interactivers.TPlayer;
	import Classes.TLevel;
	import Classes.Interactivers.TDisappear
	import Classes.UndoHandler;

	public class TDirt extends TItem{
		[Embed("../../../assets/gfx/by_maurycy/gameplay/tile08.png")] public static var g: Class;
		public function TDirt(_x: uint, _y: uint){
			x=_x
			y=_y

			addChild(new g)
			TLevel.Set(x, y,this)
			TD.layerBlocks.addChild(this)
			TLevel.needed++
		}
		override public function CanLand(): Boolean{
			return false;
		}
		override public function Boom(): void{
			TLevel.Remove(x, y)
			new TNormal(x, y)
			new TDisappear(x, y,g)
			UndoHandler.add(this)
		}
		override public function Remove(): void{
			TD.layerBlocks.removeChild(this)
			TLevel.needed--
		}
		override public function Undo(): void{
			new TDirt(x, y)
		}
	}
}