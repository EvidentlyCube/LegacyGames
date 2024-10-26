package Classes.Items{
	import Classes.Interactivers.TBullet;
	import Classes.Interactivers.TCanonKill;
	import Classes.Interactivers.TExplosion;
	import Classes.Interactivers.TMuzzle;
	import Classes.Interactivers.TObject;
	import Classes.SFX;
	import Classes.TLevel;

	import mx.core.BitmapAsset;
	public class TCannon extends TItem{
		[Embed("../../../assets/gfx/gameplay/Cannon1.png")] public static var g_0:Class;
		[Embed("../../../assets/gfx/gameplay/Cannon2.png")] public static var g_1:Class;
		[Embed("../../../assets/gfx/gameplay/Cannon3.png")] public static var g_2:Class;
		[Embed("../../../assets/gfx/gameplay/Cannon4.png")] public static var g_3:Class;
		[Embed("../../../assets/gfx/gameplay/Cannon1b.png")] public static var g_0b:Class;
		[Embed("../../../assets/gfx/gameplay/Cannon2b.png")] public static var g_1b:Class;
		[Embed("../../../assets/gfx/gameplay/Cannon3b.png")] public static var g_2b:Class;
		[Embed("../../../assets/gfx/gameplay/Cannon4b.png")] public static var g_3b:Class;
		public var shX:int = 0;
		public var shY:int = 0;
		public var dir:uint
		public var Kill:TCanonKill
		public function TCannon(_x:uint,_y:uint,_dir:uint){
			x=_x
			y=_y
			dir=_dir
			var f:BitmapAsset
			switch (_dir){
				case(0):
					f = new g_0b
					addChild(new g_0)
					shX = 1
					break;
				case(1):
					f = new g_1b
					addChild(new g_1)
					shY = 1
					break;
				case(2):
					f = new g_2b
					addChild(new g_2)
					shX=-1
					break;
				case(3):
					f = new g_3b
					addChild(new g_3)
					shY=-1
					break;
			}
			f.x = x
			f.y = y
			Game.layerFloor.addChild(f)
			Game.layerItems.addChild(this)
		}
		public function Fire():void{
			SFX.Play("cannon")
			new TBullet(x,y,shX,shY)
			new TMuzzle(x,y,dir)
		}
		override public function Stomp(who:TObject):void{
			if (!who.stomps || Kill){return}
			SFX.Play("cannon die")
			Kill = new TCanonKill(this)
		}
		override public function Bullet(who:TObject):void{
			TLevel.Remove(x,y)
			who.Stop()
			new TExplosion(x,y)
		}
		public function Explode():void{
			new TExplosion(x,y,true)
			//new TExplosion(x,y,true)
			TLevel.Remove(x,y)

		}
		override public function Remove():void{
			if (Kill){Kill.Stop()}
			Game.layerItems.removeChild(this)
		}
	}
}