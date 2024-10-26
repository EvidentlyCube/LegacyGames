package Classes.Items{
	import Classes.Interactivers.TAnimWall;
	import Classes.Interactivers.TItemAppear;
	import Classes.Interactivers.TObject;
	import Classes.SFX;
	import Classes.TLevel;

	public class TTeleport extends TItem{
		[Embed("../../../assets/gfx/gameplay/Teleporter.png")]	public static var g_0:Class;
		[Embed("../../../assets/gfx/gameplay/Teleporter1.png")]	public static var g_1:Class;
		[Embed("../../../assets/gfx/gameplay/Teleporter2.png")]	public static var g_2:Class;
		[Embed("../../../assets/gfx/gameplay/Teleporter3.png")]	public static var g_3:Class;
		[Embed("../../../assets/gfx/gameplay/Teleporter4.png")]	public static var g_4:Class;
		[Embed("../../../assets/gfx/gameplay/TeleporterCore.png")]	public static var g_core:Class;
		public var toX:uint
		public var toY:uint
		private var Anim:TAnimWall
		public function TTeleport(_x:uint,_y:uint,_tox:uint,_toy:uint){
			x=_x
			y=_y
			toX=_tox
			toY=_toy

			Anim = new TAnimWall(x,y,0)
			//addChild(new g_0)

			Game.layerItems.addChild(this)
		}
		override public function Stomp(who:TObject):void{
			if (who.F_isTeleportable && who.stomps){
				who.Teleport()
				who.stops = false
				who.waitTurn = true
				if (TLevel.checkAt(toX,toY) is TTeleport ||
					TLevel.checkAt(toX,toY) is TBouncerD){who.stomps = false} else {who.stomps = true}
				who.x = toX
				who.y = toY
				SFX.Play("teleport")
			}
		}
		override public function Remove():void{
			Game.layerItems.removeChild(this)
		}
		override public function Fold(first:Boolean = false):void{
			super.Fold()
			if (first){
				if (Anim){Anim.alpha = 0}
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