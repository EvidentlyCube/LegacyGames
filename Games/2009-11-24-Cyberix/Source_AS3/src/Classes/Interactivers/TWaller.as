package Classes.Interactivers{
	import Classes.Items.TItem;
	import Classes.Items.TWall;
	import Classes.SFX;
	import Classes.TLevel;

	import mx.core.BitmapAsset;
	public class TWaller extends TObject{
		[Embed("../../../assets/gfx/gameplay/Slimewall00.png")] public static var g_0:Class;
		[Embed("../../../assets/gfx/gameplay/Slimewall01.png")] public static var g_1:Class;
		[Embed("../../../assets/gfx/gameplay/Slimewall02.png")] public static var g_2:Class;
		[Embed("../../../assets/gfx/gameplay/Slimewall03.png")] public static var g_3:Class;
		[Embed("../../../assets/gfx/gameplay/Slimewall04.png")] public static var g_4:Class;
		[Embed("../../../assets/gfx/gameplay/Slimewall05.png")] public static var g_5:Class;
		[Embed("../../../assets/gfx/gameplay/Slimewall06.png")] public static var g_6:Class;
		[Embed("../../../assets/gfx/gameplay/Slimewall07.png")] public static var g_7:Class;
		[Embed("../../../assets/gfx/gameplay/Slimewall08.png")] public static var g_8:Class;
		private var gfx:Array
		private var frame:uint = 0
		private var wait:uint = 0
		private var disabled:Boolean = false
		public function TWaller(_x:uint,_y:uint){
			x=_x
			y=_y

			gfx = new Array(9)
			gfx[0]=new g_0
			gfx[1]=new g_1
			gfx[2]=new g_2
			gfx[3]=new g_3
			gfx[4]=new g_4
			gfx[5]=new g_5
			gfx[6]=new g_6
			gfx[7]=new g_7
			gfx[8]=new g_8

			addChild(gfx[frame])
			Game.layerEffects.addChild(this)
		}
		override public function Update():void{
			if (disabled){
				Remove()
				var g:BitmapAsset = new g_8
				g.x = x
				g.y = y
				Game.layerItems.addChild(g)
				return
			}
			if (frame > 0){
				if (frame == 1){
					if (TLevel.checkAt(x,y) != null){
						var b:TItem = TLevel.checkAt(x,y)
						var c:BitmapAsset = b.getChildAt(0) as BitmapAsset
						c.x = x
						c.y = y
						Game.layerFloor.addChild(c)
					}
					TLevel.Set(x,y,new TWall(x,y,0))
					swap()
				}
				wait++
				if (wait == 2){
					swap()
					wait = 0
				}
				return
			}
			var obj:TObject
			for (var i:uint = 0;i < Game.layerObjects.numChildren;i++){
				obj = Game.layerObjects.getChildAt(i) as TObject?Game.layerObjects.getChildAt(i) as TObject:null
				if (obj == null){continue}
				if (obj.F_hitsButtons && obj.x == x && obj.y == y){
					SFX.Play("waller")
					swap()
					//Remove()
					return;
				}
			}
		}
		public function swap():void{
			removeChild(gfx[frame])
			frame++
			addChild(gfx[frame])
			if (frame == 8){
				disabled = true
			}
		}

		override public function Remove():void{
			disabled = true
			Game.layerEffects.removeChild(this)
		}
	}
}