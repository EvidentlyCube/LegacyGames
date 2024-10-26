package Classes.Items{
	import Classes.Interactivers.*;
	import Classes.SFX;
	/*
	PMLBEG * Anonymous(Unnamed%None::!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!""'!"!!""C,-"!C.0"!C + 2"!C) / "!IO"L:!K:!J:!>9!K"!K4!L"!J"!K" != "!J"!L"!L"!J7!J"!L"!L"!J"!?"!K"!J"!L4!K"!K9!@:!J:!K:!L!!!!PMLEND
	*/
	public class TWallPierced extends TItem{
		[Embed("../../../assets/gfx/gameplay/PiercedH.png")] public static var g_00:Class;
		[Embed("../../../assets/gfx/gameplay/PiercedV.png")] public static var g_01:Class;
		[Embed("../../../assets/gfx/gameplay/PiercedB.png")] public static var g_02:Class;
		private var dir:uint
		public function TWallPierced(_x:uint,_y:uint,_dir:uint){
			x=_x
			y=_y
			dir=_dir
			switch(_dir){
				case(0):addChild(new g_00);break;
				case(1):addChild(new g_01);break;
				case(2):addChild(new g_02);break;
			}
			Game.layerItems.addChild(this)
		}
		override public function Hit(who:TObject):void{
			if (!who.F_isTiny || (who.moveX != 0 && dir == 1) || (who.moveY != 0 && dir == 0)){
				if (who.moveSteps > 1){SFX.Play("wall")}
				who.Stop()
			}
		}
		override public function Remove():void{
			Game.layerItems.removeChild(this)
		}
	}
}