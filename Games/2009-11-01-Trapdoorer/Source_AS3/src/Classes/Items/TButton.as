package Classes.Items{
	import Classes.SFX;
	import Classes.TLevel;
	import Classes.UndoHandler;

	import Editor.GiveClass;
	public class TButton extends TItem{
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button00.png")] public static var g_00: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button01.png")] public static var g_01: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button10.png")] public static var g_10: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button11.png")] public static var g_11: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button20.png")] public static var g_20: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button21.png")] public static var g_21: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button30.png")] public static var g_30: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button31.png")] public static var g_31: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button40.png")] public static var g_40: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button41.png")] public static var g_41: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button50.png")] public static var g_50: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button51.png")] public static var g_51: Class;
		private var col: uint
		private var state: uint
		public function TButton(_x: uint, _y: uint, c: uint, st: uint){
			x=_x
			y=_y
			col = c
			state = st

			addChild(new (GiveClass(col*2+state+23)))
			TLevel.Set(x, y,this)
			TD.layerBlocks.addChild(this)
		}
		override public function CanLand(): Boolean{
			return true;
		}
		override public function Land(): void{
			TGate.MassSwitch(col)
			SFX.Play("switch")
			Switch()
			UndoHandler.add(this)
		}
		override public function Remove(): void{
			TD.layerBlocks.removeChild(this)
		}
		public function Switch(): void{
			//removeChildAt(0)
			state = 1-state
			addChild(new (GiveClass(col*2+state+23)))
		}
		override public function Undo(): void{
			Switch()
		}
	}
}