package Classes.Interactivers{
	import Classes.SFX;
	public class TExplosion extends TObject{
		[Embed("../../../assets/gfx/gameplay/explo_00000.png")] private var g_00:Class;
		[Embed("../../../assets/gfx/gameplay/explo_00001.png")] private var g_01:Class;
		[Embed("../../../assets/gfx/gameplay/explo_00002.png")] private var g_02:Class;
		[Embed("../../../assets/gfx/gameplay/explo_00003.png")] private var g_03:Class;
		[Embed("../../../assets/gfx/gameplay/explo_00004.png")] private var g_04:Class;
		[Embed("../../../assets/gfx/gameplay/explo_00005.png")] private var g_05:Class;
		[Embed("../../../assets/gfx/gameplay/explo_00006.png")] private var g_06:Class;
		[Embed("../../../assets/gfx/gameplay/explo_00007.png")] private var g_07:Class;
		[Embed("../../../assets/gfx/gameplay/explo_00008.png")] private var g_08:Class;
		[Embed("../../../assets/gfx/gameplay/explo_00009.png")] private var g_09:Class;
		[Embed("../../../assets/gfx/gameplay/explo_00010.png")] private var g_10:Class;
		[Embed("../../../assets/gfx/gameplay/explo_00011.png")] private var g_11:Class;
		[Embed("../../../assets/gfx/gameplay/explo_00012.png")] private var g_12:Class;
		[Embed("../../../assets/gfx/gameplay/explo_00013.png")] private var g_13:Class;
		[Embed("../../../assets/gfx/gameplay/explo_00014.png")] private var g_14:Class;
		[Embed("../../../assets/gfx/gameplay/explo_00015.png")] private var g_15:Class;
		[Embed("../../../assets/gfx/gameplay/explo_00016.png")] private var g_16:Class;
		[Embed("../../../assets/gfx/gameplay/explo_00017.png")] private var g_17:Class;
		[Embed("../../../assets/gfx/gameplay/explo_00018.png")] private var g_18:Class;

		private var gfx:Array = new Array(19)
		private var frame:uint = 0
		private var wait:Number = 0
		private var kill:Boolean
		public function TExplosion(_x:int,_y:int,_kill:Boolean = false){
			x=_x - 12
			y=_y - 12
			kill=_kill

			gfx[0]=new g_00
			gfx[1]=new g_01
			gfx[2]=new g_02
			gfx[3]=new g_03
			gfx[4]=new g_04
			gfx[5]=new g_05
			gfx[6]=new g_06
			gfx[7]=new g_07
			gfx[8]=new g_08
			gfx[9]=new g_09
			gfx[10]=new g_10
			gfx[11]=new g_11
			gfx[12]=new g_12
			gfx[13]=new g_13
			gfx[14]=new g_14
			gfx[15]=new g_15
			gfx[16]=new g_16
			gfx[17]=new g_17
			gfx[18]=new g_18
			gfx[0].visible = false
			gfx[1].visible = false
			gfx[2].visible = false
			gfx[3].visible = false
			gfx[4].visible = false
			gfx[5].visible = false
			gfx[6].visible = false
			gfx[7].visible = false
			gfx[8].visible = false
			gfx[9].visible = false
			gfx[10].visible = false
			gfx[11].visible = false
			gfx[12].visible = false
			gfx[13].visible = false
			gfx[14].visible = false
			gfx[15].visible = false
			gfx[16].visible = false
			gfx[17].visible = false
			gfx[18].visible = false
			addChild(gfx[0])
			addChild(gfx[1])
			addChild(gfx[2])
			addChild(gfx[3])
			addChild(gfx[4])
			addChild(gfx[5])
			addChild(gfx[6])
			addChild(gfx[7])
			addChild(gfx[8])
			addChild(gfx[9])
			addChild(gfx[10])
			addChild(gfx[11])
			addChild(gfx[12])
			addChild(gfx[13])
			addChild(gfx[14])
			addChild(gfx[15])
			addChild(gfx[16])
			addChild(gfx[17])
			addChild(gfx[18])

			gfx[frame].visible = true
			blendMode = "add"
			SFX.Play("explosion")
			Game.layerEffects.addChild(this)
		}
		override public function Update():void{
			if (kill){
				var ox:int
				var oy:int
				var i:uint = 0
				var obj:TObject
				for (i = 0;i < Game.layerObjects.numChildren;i++){
					obj = Game.layerObjects.getChildAt(i) as TObject
					if (obj == null || !obj.F_mineKills){continue}
					ox = obj.x
					oy = obj.y
					if (x + 12 == obj.x && y + 12 == obj.y){
						obj.Destroy(this)
					}
				}
			}
			wait++
			if (wait > 1.5){
				wait -= 1.5
			} else {
				return
			}
			gfx[frame].visible = false
			frame++
			if (frame == 19){Remove();return}
			gfx[frame].visible = true
		}
		override public function Remove():void{
			Game.layerEffects.removeChild(this)
		}
		override public function Stop(who:TObject = null):void{
			Remove()
		}
	}
}