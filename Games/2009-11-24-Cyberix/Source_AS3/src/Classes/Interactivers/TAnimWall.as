package Classes.Interactivers
{
	import Classes.Items.TRounder;
	import Classes.Items.TTeleport;
	import Classes.Items.TWall;

	import flash.display.Sprite;

	import mx.core.BitmapAsset;
	public class TAnimWall extends TObject{
		public var app:TItemAppear
		private var frames:Array
		private var frame:uint = 0
		private var randomize:Boolean = false
		private var ranSpd:uint = 0
		private var spdTemp:int = 0
		private var spd:uint = 0
		private var wait:uint = 0
		private var gfx:Sprite = new Sprite
		public function TAnimWall(_x:int,_y:int,_g:uint){
			gfx.x=_x
			gfx.y=_y
			switch (_g){
				case(0):
					frames = new Array(8);
					frames[0]=new (TTeleport.g_0)
					frames[1]=new (TTeleport.g_1)
					frames[2]=new (TTeleport.g_2)
					frames[3]=new (TTeleport.g_3)
					frames[4]=new (TTeleport.g_4)
					frames[5]=new (TTeleport.g_3)
					frames[6]=new (TTeleport.g_2)
					frames[7]=new (TTeleport.g_1)
					spd = 3;
					Game.layerItems.addChild(gfx)
					break;
				case(1):
					frames = new Array(8);
					frames[0]=new (TRounder.gcw)
					frames[1]=new (TRounder.gcw1)
					frames[2]=new (TRounder.gcw2)
					frames[3]=new (TRounder.gcw3)
					frames[4]=new (TRounder.gcw4)
					frames[5]=new (TRounder.gcw5)
					frames[6]=new (TRounder.gcw6)
					frames[7]=new (TRounder.gcw7)
					addChild(gfx)
					spd = 2;
					break;
				case(2):
					frames = new Array(8);
					frames[0]=new (TRounder.gccw)
					frames[1]=new (TRounder.gccw1)
					frames[2]=new (TRounder.gccw2)
					frames[3]=new (TRounder.gccw3)
					frames[4]=new (TRounder.gccw4)
					frames[5]=new (TRounder.gccw5)
					frames[6]=new (TRounder.gccw6)
					frames[7]=new (TRounder.gccw7)
					addChild(gfx)
					spd = 2;
					break;
				case(111):
					frames = new Array(4);
					frames[0]=new (TWall.g_40)
					frames[1]=new (TWall.g_40_1)
					frames[2]=new (TWall.g_40_2)
					frames[3]=new (TWall.g_40_3)
					addChild(gfx)
					spd = 2
					break;
				case(112):
					frames = new Array(4);
					frames[0]=new (TWall.g_41)
					frames[1]=new (TWall.g_41_1)
					frames[2]=new (TWall.g_41_2)
					frames[3]=new (TWall.g_41_3)
					addChild(gfx)
					spd = 8
					break;
				case(88):
					frames = new Array(8);
					frames[0]=new (TWall.g_17)
					frames[1]=new (TWall.g_17_7)
					frames[2]=new (TWall.g_17_6)
					frames[3]=new (TWall.g_17_5)
					frames[4]=new (TWall.g_17_4)
					frames[5]=new (TWall.g_17_3)
					frames[6]=new (TWall.g_17_2)
					frames[7]=new (TWall.g_17_1)
					addChild(gfx)
					randomize = true
					frame = Math.floor(Math.random() * 8)
					ranSpd = 1
					spd = 2
					break;
				case(131):
					frames = new Array(4);
					frames[0]=new (TWall.g_60)
					frames[1]=new (TWall.g_60_1)
					frames[2]=new (TWall.g_60_2)
					frames[3]=new (TWall.g_60_3)
					addChild(gfx)
					//randomize = true
					frame = 3
					spd = 2
					break;
				case(132):
					frames = new Array(4);
					frames[0]=new (TWall.g_61)
					frames[1]=new (TWall.g_61_1)
					frames[2]=new (TWall.g_61_2)
					frames[3]=new (TWall.g_61_3)
					addChild(gfx)
					//randomize = true
					frame = 3
					spd = 8
					break;
			}
			var tmp:BitmapAsset
			for (var i:uint = 0;i < frames.length;i++){
				gfx.addChild(frames[i])
				tmp = frames[i] as BitmapAsset
				if (tmp == null){continue}
				tmp.visible = false
			}

			tmp = frames[frame] as BitmapAsset
			if (tmp != null){
				tmp.visible = true
			}
			Game.layerEffects.addChild(this)
		}
		override public function get alpha():Number{
			return gfx.alpha
		}
		override public function set alpha(a:Number):void{
			gfx.alpha = a
		}
		override public function Update():void{
			wait++

			if (wait == spd + spdTemp){
				if (frame == 0){
					if (randomize){
						if (Math.random() > 0.03){
							wait--
							return
						}
					}
					spdTemp = Math.floor(Math.random() * (ranSpd + 1))
					if (Math.random() < 0.5){
						spdTemp*=-1
					}
				}
				wait = 0
				var tmp:BitmapAsset
				tmp = frames[frame] as BitmapAsset
				if (tmp != null){
					tmp.visible = false
					frame++;
					if (frame >= frames.length){frame = 0}
					tmp = frames[frame] as BitmapAsset
					if (tmp != null){
						tmp.visible = true
					}
				}
			}
		}
		override public function Remove():void{
			gfx.parent.removeChild(gfx)
			Game.layerEffects.removeChild(this)
		}
	}
}