/*Platformer Engine by Mauft.com
__TCoinJump__

This is the funky effect of jumping coin.
*/
package com.mauft.PlatformerEngine.objects.effects{
	import com.mauft.PlatformerEngine.Engine;
	
	import flash.display.MovieClip;
	
	public class TCoinJump	{
		private var _gfx:MovieClip
		private var _speed:Number=12
		private var ___anim:uint=0
		public function TCoinJump(setX:Number, setY:Number){
			_gfx=new MC_COINJUMP
			_gfx.x=setX
			_gfx.y=setY
			Engine.layerObjects.addChild(_gfx)
			
			Engine.listObjects.push(this)
		}
		public function Step():void{
			_gfx.y-=_speed
			_speed-=0.5
			___anim++
			if (___anim==2){
				___anim=0
				_gfx.gotoAndStop(_gfx.currentFrame==4?0:_gfx.currentFrame+1)
			}
			if (_speed<5){
				_gfx.alpha-=0.1
				if (_gfx.alpha<=0){
					Engine.layerObjects.removeChild(_gfx)
					Engine.removeObject(this)
				}
			}
		}

	}
}