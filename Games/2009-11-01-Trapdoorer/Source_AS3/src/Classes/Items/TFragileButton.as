package Classes.Items{
	import Classes.Interactivers.TFall;
	import Classes.SFX;
	import Classes.TLevel;
	import Classes.UndoHandler;

	import Editor.GiveClass;
	public class TFragileButton extends TItem{
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button00b.png")] public static var g_00: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button01b.png")] public static var g_01: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button10b.png")] public static var g_10: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button11b.png")] public static var g_11: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button20b.png")] public static var g_20: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button21b.png")] public static var g_21: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button30b.png")] public static var g_30: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button31b.png")] public static var g_31: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button40b.png")] public static var g_40: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button41b.png")] public static var g_41: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button50b.png")] public static var g_50: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/button51b.png")] public static var g_51: Class;
		private var col: uint
		private var state: uint
		private var broken: Boolean = false
		public function TFragileButton(_x: uint, _y: uint, c: uint, st: uint){
			x=_x
			y=_y
			col = c
			state = st
			TLevel.needed++
			addChild(new (GiveClass(col*2+state+37)))
			TLevel.Set(x, y,this)
			TD.layerBlocks.addChild(this)
		}
		override public function CanLand(): Boolean{
			return true;
		}
		override public function Boom(): void{
			TLevel.Remove(x, y)
			new TFall(x, y,GiveClass(col*2+state+23))
			UndoHandler.add(this)
		}
		override public function JumpOff(): void{
			SFX.Play("hit")
			TLevel.Remove(x, y)
			new TFall(x, y,GiveClass(col*2+state+37))
			UndoHandler.add(this)
			TLevel.Strip(x+25, y)
			TLevel.Strip(x-25, y)
			TLevel.Strip(x, y+25)
			TLevel.Strip(x, y-25)
		}
		override public function Land(): void{
			TGate.MassSwitch(col)
			SFX.Play("switch")
			Switch()
			UndoHandler.add(this)
		}
		override public function Remove(): void{
			broken = true
			TLevel.needed--
			TD.layerBlocks.removeChild(this)
		}
		public function Switch(): void{
			removeChildAt(0)
			state = 1-state
			addChild(new (GiveClass(col*2+state+37)))
		}
		override public function Undo(): void{
			if (broken){new TFragileButton(x, y,col, state)} else{Switch()}
		}
	}
}