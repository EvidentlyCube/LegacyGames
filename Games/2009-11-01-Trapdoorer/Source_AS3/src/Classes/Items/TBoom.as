package Classes.Items{
	import Classes.Interactivers.TFall;
	import Classes.SFX;
	import Classes.TLevel;
	import Classes.UndoHandler;

	public class TBoom extends TItem{
		[Embed("../../../assets/gfx/by_maurycy/gameplay/tile05.png")] public static var g: Class;
		public function TBoom(_x: uint, _y: uint){
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
			SFX.Play("break")
			new TFall(x, y,g)
			UndoHandler.add(this)
			TLevel.Boom(x+25, y)
			TLevel.Boom(x-25, y)
			TLevel.Boom(x, y+25)
			TLevel.Boom(x, y-25)
		}
		override public function Remove(): void{
			TLevel.needed--
			TD.layerBlocks.removeChild(this)
		}
		override public function Undo(): void{
			new TBoom(x, y)
		}
	}
}