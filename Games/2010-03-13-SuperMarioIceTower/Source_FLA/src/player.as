package src{
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.media.SoundTransform
	public class player{
		private function get wid():Number{return 20;}
		public var gfx:MovieClip
		public var x:Number
		public var y:Number
		private var modX:Number
		private var modY:Number
		private var speed:Number=0
		private var gravity:Number=0
		private var stands:Boolean=false
		private var dying:Boolean=false
		private var hiJump:Boolean=false
		public function player(_x:Number, _y:Number, _gfx:MovieClip, _modX:Number, _modY:Number):void{
			x=_x
			y=_y
			gfx=_gfx
			modX=_modX
			modY=_modY
			
			gfx.x=x+modX
			gfx.y=y+modY
		}
		public function update():void{
			if (dying==true){return}
			var accel:Number=0.2
			if (Main.holdLeft){
				if (speed>-8){speed-=accel}
			} else if (Main.holdRight){
				if (speed<8){speed+=accel}
			} else {
				if (speed>accel){
					speed-=accel
				} else if(speed<-accel){
					speed+=accel
				} else {
					speed=0
				}
			}
			gravity+=0.4
			x+=speed
			y+=gravity
			if (x+wid>465){x=465-wid; speed*=-1}
			if (x<35){x=35; speed*=-1}
			
			var f:floor
			var col:Boolean=false
			if (gravity>0){
				for (var i:uint=0; i<Main.display.numChildren-1; i++){
					f=Main.display.getChildAt(i) as floor
					if (x+wid>=f.x && x<f.x+f.width && y>f.y && y<f.y+f.height && y-gravity-1<f.y){
						if (stands==false){
							Main.landed(f.f);
						}
						hiJump=false
						col=true
						y=f.y
						gravity=0
						if (Main.holdJump){
							if (Math.abs(speed)>5){
								hiJump=true
								gfx.rotation=0
							} else {
								gfx.rotation=0
							}
							if (Main.sCombo && Math.random()<0.3){
								switch(Math.floor(Math.random()*3)){
									case(0):
										Sound(new SFX_JUMP_1).play(0, 0, new SoundTransform(Main.sfxVol/5))
										break;
									case(1):
										Sound(new SFX_JUMP_2).play(0, 0, new SoundTransform(Main.sfxVol/5))
										break;
									case(2):
										Sound(new SFX_JUMP_3).play(0, 0, new SoundTransform(Main.sfxVol/5))
										break;
								}
							} else {
								Sound(new SFX_JUMP_0).play(0, 0, new SoundTransform(Main.sfxVol/5))
							}
							gravity=-8-Math.abs(speed)
						}
					}
				}
			}
			stands=col
			if (gravity==0 && !hiJump){
				gfx.rotation=0
				if (speed>0){
					gfx.gotoAndStop(2)
					gfx.scaleX=1
				} else if (speed<0){
					gfx.gotoAndStop(2)
					gfx.scaleX=-1
				} else {
					gfx.gotoAndStop(1)
				}
			} else {
				if (speed>0){
					gfx.scaleX=1
				} else if (speed<0){
					gfx.scaleX=-1
				}
				gfx.gotoAndStop(3)
				if (hiJump){
					gfx.rotation+=5+(gfx as PlayerGFX3)?10:0
				}
			}
			gfx.x=x+modX
			gfx.y=y+modY-Main.lev_y
			if (y>Main.lev_y+500+gfx.height){
				dying=true
				Main.self.addChild(new YOU_RE_DEAD)
				switch(Math.floor(Math.random()*4)){
					case(0):
						Sound(new SFX_DIE_1).play(0, 0, new SoundTransform(Main.sfxVol/5))
						break;
					case(1):
						Sound(new SFX_DIE_2).play(0, 0, new SoundTransform(Main.sfxVol/5))
						break;
					case(2):
						Sound(new SFX_DIE_3).play(0, 0, new SoundTransform(Main.sfxVol/5))
						break;
					case(3):
						Sound(new SFX_DIE_4).play(0, 0, new SoundTransform(Main.sfxVol/5))
						break;
				}
				Main.dead()
			}
			if (Math.random()<0.1){
				new CIUF(x, y);
			}
		}
	}
}