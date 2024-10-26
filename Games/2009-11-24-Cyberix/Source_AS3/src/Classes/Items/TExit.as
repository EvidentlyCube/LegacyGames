package Classes.Items
{
	import Classes.Interactivers.TExitHandle;
	import Classes.Interactivers.TFadeOut;
	import Classes.Interactivers.TFadeWhite;
	import Classes.Interactivers.TObject;
	import Classes.Interactivers.TPlayer;
	import Classes.SFX;
	import Classes.Scenes.TLevelScene;
	import Classes.TLevel;

	import mx.core.BitmapAsset;
	public class TExit extends TItem{
		[Embed("../../../assets/gfx/gameplay/Exit.png")] public static var g_00:Class;
		[Embed("../../../assets/gfx/gameplay/Exit_on00.png")] public static var g_o00:Class;
		[Embed("../../../assets/gfx/gameplay/Exit_on01.png")] public static var g_o01:Class;
		[Embed("../../../assets/gfx/gameplay/Exit_on02.png")] public static var g_o02:Class;
		[Embed("../../../assets/gfx/gameplay/Exit_off00.png")] public static var g_f00:Class;
		[Embed("../../../assets/gfx/gameplay/Exit_off01.png")] public static var g_f01:Class;
		[Embed("../../../assets/gfx/gameplay/Exit_off02.png")] public static var g_f02:Class;
		[Embed("../../../assets/gfx/gameplay/Exit_dead.png")] public static var g_x:Class;
		private var off:Array = new Array(4)
		private var on:Array = new Array(4)
		private var frame:uint = 0
		private var wait:uint = 0
		private var handle:TExitHandle
		public function TExit(_x:uint,_y:uint){
			x=_x
			y=_y

			on[0]=new g_o00
			on[1]=new g_o01
			on[2]=new g_o02
			on[3]=on[1]
			off[0]=new g_f00
			off[1]=new g_f01
			off[2]=new g_f02
			off[3]=off[1]

			frame = 0
			addChild(off[frame])

			handle = new TExitHandle(this)
			Game.layerEffects.addChild(handle)
			Game.layerItems.addChild(this)
		}
		override public function Remove():void{
			Game.layerItems.removeChild(this)
		}
		public function Update():void{
			if (TLevel.fruits > 0){
				wait++
				if (wait == 6){
					wait = 0
					removeChildAt(0)
					frame = (frame + 1)%4
					addChild(off[frame])
				}
			} else {
				wait++
				if (wait == 6){
					wait = 0
					removeChildAt(0)
					frame = (frame + 1)%4
					addChild(on[frame])
				}
			}
		}
		override public function Stomp(who:TObject):void{
			if (TLevel.fruits == 0 && who as TPlayer != null){
				var w:TPlayer = who as TPlayer
				w.Remove()
				TLevel.Remove(x,y)
				handle.Remove()
				new TFadeOut(x,y,new g_o01,0.04)
				if (w.dir == 0){
					new TFadeWhite(x,y,new TPlayer.g_0)
				} else if (w.dir == 1){
					new TFadeWhite(x,y,new TPlayer.g_1)
				} else	if (w.dir == 2){
					new TFadeWhite(x,y,new TPlayer.g_2)
				} else	if (w.dir == 3){
					new TFadeWhite(x,y,new TPlayer.g_3)
				}
				var ex:BitmapAsset = new g_x;
				ex.x = x
				ex.y = y
				Game.layerFloor.addChild(ex)
				TPlayer.playerCount--
				SFX.Play("completed")
				if (TPlayer.playerCount == 0){
					TLevel.endLevel(true)
					TLevelScene.alpha=-1
				}
			}
		}
	}
}