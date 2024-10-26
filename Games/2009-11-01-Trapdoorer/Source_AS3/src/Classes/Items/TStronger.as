package Classes.Items{
	import Classes.Interactivers.TFall;
	import Classes.TLevel;
	import Classes.SFX;
	import Classes.UndoHandler;

	public class TStronger extends TItem{
		[Embed("../../../assets/gfx/by_maurycy/gameplay/tile11.png")] public static var g: Class;
		public function TStronger(_x: uint, _y: uint){
			x=_x
			y=_y

			addChild(new g)
			TLevel.Set(x, y,this)
			TD.layerBlocks.addChild(this)
			TLevel.needed++
		}
		override public function CanLand(): Boolean{
			return true
		}
		override public function Boom(): void{
			TLevel.Remove(x, y)
			new TFall(x, y,g)
			UndoHandler.add(this)
		}
		override public function JumpOff(): void{
			TLevel.Remove(x, y)
			SFX.Play("hit2")
			//new TFall(x, y,g_normal)
			new TStrong(x, y)
			UndoHandler.add(this)
		}
		override public function Remove(): void{
			TD.layerBlocks.removeChild(this)
			TLevel.needed--
		}
		override public function Undo(): void{
			new TStronger(x, y)
		}
	}
}