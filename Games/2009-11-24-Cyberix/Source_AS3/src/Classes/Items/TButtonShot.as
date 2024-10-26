package Classes.Items{
	import Classes.Interactivers.TObject;
	import Classes.SFX;
	import Classes.TLevel;
	public class TButtonShot extends TItem{
		[Embed("../../../assets/gfx/gameplay/Button1.png")] public static var g_0:Class;
		[Embed("../../../assets/gfx/gameplay/Button2.png")] public static var g_1:Class;
		public var itemX:uint
		public var itemY:uint
		public var red:Boolean = false
		public function TButtonShot(_x:uint,_y:uint,_ix:uint,_iy:uint){
			x=_x
			y=_y
			itemX=_ix
			itemY=_iy
			addChild(new g_0)
			Game.layerItems.addChild(this)
		}

		override public function Stomp(who:TObject):void{
			if (!who.F_hitsButtons || !who.stomps){return}
			SFX.Play("switch")
			var cannon:TItem = TLevel.checkAt(itemX,itemY)
			if (cannon as TCannon != null){
				(cannon as TCannon).Fire()
			}
			Swap()
		}

		public function Swap():void{
			if (red){
				removeChildAt(0)
				addChild(new g_0)
				red = false
			} else {
				removeChildAt(0)
				addChild(new g_1)
				red = true
			}
		}

		override public function Remove():void{
			Game.layerItems.removeChild(this)
		}
	}
}