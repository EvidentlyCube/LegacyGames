package com.mauft.PlatformerEngine.objects.effects{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Settings;
	
	import flash.display.MovieClip;
	public class TStoneDropper{
		private var x:Number
		private var y:Number
		private var wid:Number
		private var hei:Number
		private var _st:MovieClip
		private var _spd:Number
		private var _rot:Number
		private var gfx:MovieClip
		public function TStoneDropper(setX:Number, setY:Number, _gfx:MovieClip){
			x=setX+5
			y=setY
			
			wid=_gfx.width-10
			hei=_gfx.height
			
			gfx=_gfx
			gfx.scaleX=1
			gfx.scaleY=1
			while (gfx.numChildren>0){
				gfx.removeChildAt(0)
			}
			
			Engine.listObjects.push(this)
		}
		public function Step():void{
			if (!_st){
				if (Math.random()<0.005){
					_st=new MC_STONES
					_st.x=Math.random()*wid
					_st.y=Settings.TILE_HEIGHT/2
					_spd=0
					_rot=(Math.random()-0.5)*40
					gfx.addChild(_st)
				}
			} else {
				_spd+=Settings.GRAVITY/2
				_st.y+=_spd
				_st.rotation+=_rot
				if (_st.y>hei){
					gfx.removeChild(_st)
					_st=null
				}
			}
		}
	}
}