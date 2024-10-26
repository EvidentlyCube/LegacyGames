package Classes.Items{
	import Classes.Interactivers.TFall;
	import Classes.Interactivers.TPlayer;
	import Classes.TLevel;
	import Classes.SFX;
	import Classes.UndoHandler;

	public class TDire extends TItem{
		[Embed("../../../assets/gfx/by_maurycy/gameplay/tile10.png")] public static var g: Class;
		public function TDire(_x: uint, _y: uint){
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
			if (TPlayer.moveX*TPlayer.moveY == 0){
				SFX.Play("hit2")
				new TDiag(x, y)
				UndoHandler.add(this)
			} else if (TPlayer.moveX*TPlayer.moveY!=0){
				SFX.Play("hit2")
				new THori(x, y)
				UndoHandler.add(this)

			}
		}
		override public function Remove(): void{
			TD.layerBlocks.removeChild(this)
			TLevel.needed--
		}
		override public function Undo(): void{
			new TDire(x, y)
		}
	}
}