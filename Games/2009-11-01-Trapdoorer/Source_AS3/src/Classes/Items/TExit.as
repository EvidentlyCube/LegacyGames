package Classes.Items{
	import Classes.Interactivers.TFall;
	import Classes.TLevel;
	import Classes.UndoHandler;
	import Classes.SFX;

	public class TExit extends TItem{
		[Embed("../../../assets/gfx/by_maurycy/gameplay/tile03.png")] public static var g: Class;
		public function TExit(_x: uint, _y: uint){
			x=_x
			y=_y

			addChild(new g)
			TLevel.Set(x, y,this)
			TD.layerBlocks.addChild(this)
		}
		override public function CanLand(): Boolean{
			return true
		}
		override public function Land(): void{
			if (TLevel.needed == 0){
				SFX.Play("complete")
				TLevel.endLevel(true)
			}
		}
		override public function Remove(): void{
			TD.layerBlocks.removeChild(this)
		}
	}
}