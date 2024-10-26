package Classes.Items{
	import Classes.Interactivers.TFall;
	import Classes.TLevel;
	import Classes.UndoHandler;
	import Classes.SFX;

	public class TSteel extends TItem{
		[Embed("../../../assets/gfx/by_maurycy/gameplay/tile02.png")] public static var g_steel: Class;
		public function TSteel(_x: uint, _y: uint){
			x=_x
			y=_y

			addChild(new g_steel)
			TLevel.Set(x, y,this)
			TD.layerBlocks.addChild(this)
			TLevel.needed++
		}
		override public function CanLand(): Boolean{
			return true
		}
		override public function Boom(): void{
			TLevel.Remove(x, y)
			new TFall(x, y,g_steel)
			UndoHandler.add(this)
		}
		public function Strip(): void{
			SFX.Play("hit2")
			TLevel.Remove(x, y)
			new TNormal(x, y)
			UndoHandler.add(this)
		}
		override public function Remove(): void{
			TD.layerBlocks.removeChild(this)
			TLevel.needed--
		}
		override public function Undo(): void{
			new TSteel(x, y)
		}
	}
}