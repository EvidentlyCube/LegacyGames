package Classes.Items{
	import Classes.Interactivers.TObject;
	import Classes.Interactivers.TPlayer;
	import Classes.SFX;

	public class TArrow extends TItem{
		[Embed("../../../assets/gfx/gameplay/Arrow0.png")] public static var g0:Class;
		[Embed("../../../assets/gfx/gameplay/Arrow1.png")] public static var g1:Class;
		[Embed("../../../assets/gfx/gameplay/Arrow2.png")] public static var g2:Class;
		[Embed("../../../assets/gfx/gameplay/Arrow3.png")] public static var g3:Class;
		[Embed("../../../assets/gfx/gameplay/Arrow4.png")] public static var g4:Class;
		[Embed("../../../assets/gfx/gameplay/Arrow5.png")] public static var g5:Class;
		[Embed("../../../assets/gfx/gameplay/Arrow6.png")] public static var g6:Class;
		[Embed("../../../assets/gfx/gameplay/Arrow7.png")] public static var g7:Class;
		[Embed("../../../assets/gfx/gameplay/Arrow8.png")] public static var g8:Class;
		[Embed("../../../assets/gfx/gameplay/Arrow9.png")] public static var g9:Class;
		private var bx:int
		private var by:int
		public function TArrow(_x:uint,_y:uint,_dir:uint){
			x=_x
			y=_y
			switch (_dir){
				case(0):addChild(new g0);bx=-1;by = 10;break;
				case(1):addChild(new g1);bx = 10;by=-1;break;
				case(2):addChild(new g2);bx = 1;by = 10;break;
				case(3):addChild(new g3);bx = 10;by = 1;break;
				case(4):addChild(new g4);bx=-1;by=-1;break;
				case(5):addChild(new g5);bx = 1;by=-1;break;
				case(6):addChild(new g6);bx = 1;by = 1;break;
				case(7):addChild(new g7);bx=-1;by = 1;break;
				case(8):addChild(new g8);bx = 2;by = 0;break;
				case(9):addChild(new g9);bx = 0;by = 2;break;
			}
			Game.layerItems.addChild(this)
		}
		override public function Hit(who:TObject):void{
			if (who.F_ignoreArrows){return}
			if (bx == who.moveX || by == who.moveY){
				if (who .moveSteps > 1){SFX.Play("arrow")}
				who.Stop()
			} else if((bx == 2 && who.moveX != 0) || (by == 2 && who.moveY != 0)){
				if (who.moveSteps > 1){SFX.Play("arrow")}
				who.Stop()
			}

		}
		override public function Remove():void{
			Game.layerItems.removeChild(this)
		}
	}
}
