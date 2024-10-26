package Classes.Items{
	import Classes.Interactivers.TAnimWall;
	import Classes.Interactivers.TItemAppear;
	import Classes.Interactivers.TObject;
	import Classes.SFX;
	public class TRounder extends TItem{
		[Embed("../../../assets/gfx/gameplay/TurnwallA00.png")] public static var gcw:Class
		[Embed("../../../assets/gfx/gameplay/TurnwallA01.png")] public static var gcw1:Class
		[Embed("../../../assets/gfx/gameplay/TurnwallA02.png")] public static var gcw2:Class
		[Embed("../../../assets/gfx/gameplay/TurnwallA03.png")] public static var gcw3:Class
		[Embed("../../../assets/gfx/gameplay/TurnwallA04.png")] public static var gcw4:Class
		[Embed("../../../assets/gfx/gameplay/TurnwallA05.png")] public static var gcw5:Class
		[Embed("../../../assets/gfx/gameplay/TurnwallA06.png")] public static var gcw6:Class
		[Embed("../../../assets/gfx/gameplay/TurnwallA07.png")] public static var gcw7:Class
		[Embed("../../../assets/gfx/gameplay/TurnwallB00.png")] public static var gccw:Class
		[Embed("../../../assets/gfx/gameplay/TurnwallB01.png")] public static var gccw1:Class
		[Embed("../../../assets/gfx/gameplay/TurnwallB02.png")] public static var gccw2:Class
		[Embed("../../../assets/gfx/gameplay/TurnwallB03.png")] public static var gccw3:Class
		[Embed("../../../assets/gfx/gameplay/TurnwallB04.png")] public static var gccw4:Class
		[Embed("../../../assets/gfx/gameplay/TurnwallB05.png")] public static var gccw5:Class
		[Embed("../../../assets/gfx/gameplay/TurnwallB06.png")] public static var gccw6:Class
		[Embed("../../../assets/gfx/gameplay/TurnwallB07.png")] public static var gccw7:Class
		private var CW:Boolean = true
		private var Anim:TAnimWall
		public function TRounder(_x:uint,_y:uint,_dir:uint){
			x=_x
			y=_y
			CW = Boolean(1-_dir)
			addChild(_dir == 0?new gcw:new gccw)
			Anim = CW?new TAnimWall(x,y,1):new TAnimWall(x,y,2)
			Game.layerItems.addChild(this)
		}
		override public function Hit(who:TObject):void{
			var temp:int = who.moveX
			if (who.F_isTiny){who.Stop()}
			if (CW){
				SFX.Play("turnwall")
				who.moveX=-who.moveY
				who.moveY = temp
				who.waitTurn = true
			} else {
				SFX.Play("turnwall")
				who.moveX = who.moveY
				who.moveY=-temp
				who.waitTurn = true
			}
		}
		override public function Remove():void{
			Game.layerItems.removeChild(this)
		}
		override public function Fold(first:Boolean = false):void{
			super.Fold()
			if (first){
				Anim.alpha = 0
				alpha = 0
				return
			}
			if (Anim){
				//Anim.visible = false
				if (Anim.app != null){Anim.app.Remove()}
				Anim.app = new TItemAppear(Anim,-1)
			}
		}
		override public function Unfold():void{
			super.Unfold()
			if (Anim){
				//Anim.visible = true
				if (Anim.app != null){Anim.app.Remove()}
				Anim.app = new TItemAppear(Anim,1)
			}
		}
	}
}