package Classes.Items{
	import Classes.Interactivers.TExplosion;
	import Classes.Interactivers.TMineGfx;
	import Classes.Interactivers.TObject;
	import Classes.Scenes.TLevelScene;
	import Classes.TLevel;

	import flash.display.Sprite;

	import mx.core.BitmapAsset;
	public class TMine extends TItem{
		[Embed("../../../assets/gfx/gameplay/Mine.png")] public static var g0:Class;
		[Embed("../../../assets/gfx/gameplay/Mine1.png")] public static var g1:Class;
		[Embed("../../../assets/gfx/gameplay/Mine2.png")] public static var g2:Class;
		private var gfx:Sprite
		private var rot:Number = 0
		private var siner:Number = 0
		private var gf:TMineGfx
		public function TMine(_x:uint,_y:uint){
			x=_x
			y=_y

			gfx = new Sprite
			var b:BitmapAsset = new g2
			b.smoothing = true
			b.x=-12
			b.y=-12
			gfx.addChild(b)
			gfx.x = 12
			gfx.y = 12

			rot = Math.random() * 4+2
			if (Math.random() < 0.5){
				rot*=-1
			}

			addChild(gfx)
			addChild(new g1)

			gf = new TMineGfx(this)
			Game.layerItems.addChild(this)
		}
		public function Update():void{
			y -= Math.round(Math.sin(siner))
			gfx.rotation += rot
			siner += rot / 32
			y += Math.round(Math.sin(siner))
		}
		override public function Stomp(who:TObject):void{
			if (who != null && who.F_mineKills){
				TLevelScene.killedObject(who)
				who.Destroy(this)
			}
			TLevel.Remove(x,y - Math.round(Math.sin(siner)))
			new TExplosion(x,y)
		}
		override public function Remove():void{
			gf.Remove()
			Game.layerItems.removeChild(this)
		}

	}
}