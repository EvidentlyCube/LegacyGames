/*Platformer Engine by Mauft.com
__TFallObject__

This is just an effect object. Note you don't have to extends TObject even if you want to push it to listObjects! You only need a Step() function.
*/

package com.mauft.PlatformerEngine.objects.effects{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Settings;
	
	import flash.display.MovieClip;
	
	public class TFallObject{
		private var gfx:MovieClip
		private var x:Number
		private var y:Number
		private var _xMod:Number
		private var _yMod:Number
		private var _speed:Number
		private var _gravity:Number
		/*setX, setY - x,y coordinates of the object
		setXmod, setYmod - x,y gfx's position modifiers. Usually you setXmod=0 and setYmod=height-yMod
		_gfx - the movie clip
		_dir - the direction, which can be negative, positive or zero
		*/
		public function TFallObject(setX:Number, setY:Number, setXmod:Number, setYmod:Number, _gfx:MovieClip, _dir:int){
			x=setX
			y=setY
			_xMod=setXmod
			_yMod=setYmod
			_speed=(_dir>0?2:(_dir<0?-2:0))
			_gravity=-5
			gfx=_gfx
			gfx.scaleY=-1
			Engine.listObjects.push(this)
		}
		public function Step():void{
			_gravity+=Settings.GRAVITY/2
			x+=_speed
			y+=_gravity
			
			gfx.x=x+_xMod
			gfx.y=y+_yMod
			
			if (y>Settings.TILE_HEIGHT*Settings.LEVEL_HEIGHT+200){ //If out of screen let's get rid of it!
				gfx.parent.removeChild(gfx)
				Engine.removeObject(this)
			}
		}
	}
}