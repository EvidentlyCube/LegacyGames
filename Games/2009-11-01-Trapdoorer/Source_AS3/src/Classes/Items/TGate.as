package Classes.Items{
	import Classes.TLevel;
	import Classes.UndoHandler;

	import Editor.GiveClass;
	public class TGate extends TItem{
		[Embed("../../../assets/gfx/by_maurycy/gameplay/gate00.png")] public static var g_00: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/gate01.png")] public static var g_01: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/gate10.png")] public static var g_10: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/gate11.png")] public static var g_11: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/gate20.png")] public static var g_20: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/gate21.png")] public static var g_21: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/gate30.png")] public static var g_30: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/gate31.png")] public static var g_31: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/gate40.png")] public static var g_40: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/gate41.png")] public static var g_41: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/gate50.png")] public static var g_50: Class;
		[Embed("../../../assets/gfx/by_maurycy/gameplay/gate51.png")] public static var g_51: Class;
		private static var gates: Array = new Array
		private var col: uint
		private var state: uint
		public function TGate(_x: uint, _y: uint, c: uint, st: uint){
			x=_x
			y=_y
			col = c
			state = st

			gates.push(this)
			addChild(new (GiveClass(col*2+state+11)))
			TLevel.Set(x, y,this)
			TD.layerBlocks.addChild(this)
		}
		override public function CanLand(): Boolean{
			if (state){return true;} else {return false}
		}
		override public function Remove(): void{
			TD.layerBlocks.removeChild(this)
		}
		public function Switch(): void{
			removeChildAt(0)
			state = 1-state
			addChild(new (GiveClass(col*2+state+11)))
		}
		override public function Undo(): void{
			Switch()
		}
		public function Prune(): void{
			gates = new Array
		}
		public static function MassSwitch(c: uint): void{
			for (var i: uint = 0;i < gates.length;i++){
				var g: TGate = gates[i] as TGate
				if (g.col == c){
					g.Switch()
					UndoHandler.add(g)
				}
			}
		}
	}
}