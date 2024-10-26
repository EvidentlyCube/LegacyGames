/*Platformer Engine by Mauft.com
__TBonus__

The tile, which once headbutted throws a bonus!
*/ 

package com.mauft.PlatformerEngine.tiles{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.objects.TObject;
	import com.mauft.PlatformerEngine.objects.TPlayer;
	import com.mauft.PlatformerEngine.objects.effects.TCoinJump;
	import com.mauft.PlatformerEngine.objects.objects.TFireFlower;
	import com.mauft.PlatformerEngine.objects.objects.TShroom;
	
	import flash.display.MovieClip;
	
	public class TBonus extends TTile{
		private var _bonus:uint		//The ID of the bonus
		private var _gfx:MovieClip		//Link to the graphics
		
		private var ___anim:uint=0			//Some private animation variable
		private var ___bump:Boolean=false	//If the bonus was hit already
		private var ___y:Number			//The Y position for animation calculation
		
		public function TBonus(_x:Number,_y:Number,gfx:MovieClip,bonus:uint=0){
			/*List of bonuses:
			0 - Empty
			1 - Mushroom
			2 - Flower (or Mushroom if player is small
			3 - Star
			4 - 1UP Shroom
			5 - Deadlyshroom
			100+ - Coins. 100=1 Coin; 101=2 Coins, 120=21 Coins, 500=401 Coins and so on
			*/
			Engine.tileSet(_x,_y,this)
			
			_gfx=gfx
			_gfx.parent.removeChild(_gfx)
			Engine.layerTiles.addChild(_gfx)
			___y=_gfx.y
			
			
			Engine.listObjects.push(this)
			
			_bonus=bonus
		}
		public function Step():void{
			if (!___bump){	//If the bonus isn't hit, we animate it
				___anim++
				if (___anim==10){
					if (_gfx.currentFrame==4){
						_gfx.gotoAndStop(1)
					} else {
						_gfx.gotoAndStop(_gfx.currentFrame+1)
					}
					___anim=0
				}
			} else {//Otherwise we play the "jumping" sequence, and once it ends...
				___anim+=15
				_gfx.y=___y-Math.sin(___anim/180*Math.PI)*8
				if (___anim==180){
					if (_bonus>100){//If the bonus is multiple coins we turn it into usual block once again
						___anim=0
						___bump=false
						_bonus--
						if (_bonus==100){//Unless this was the last coin, in which case we "kill" it
							_gfx.gotoAndStop(5)
							_gfx.y=___y
							Engine.removeObject(this)
						}
					} else {		//Otherwise we give the bonus and kill it.
						GiveBonus()
						_gfx.gotoAndStop(5)
						_gfx.y=___y
						Engine.removeObject(this)
					}
					
				}
			}
		}
		/*This function is called when the bonus is supposed to appear
		*/
		private function GiveBonus():void{
			switch(_bonus){
				case(1):
					new TShroom(_gfx.x,_gfx.y)
					break;
				case(2):
					if (TPlayer._size>0){
						new TFireFlower(_gfx.x,_gfx.y)
					} else {
						new TShroom(_gfx.x,_gfx.y)
					}
					break;
				default:
					if (_bonus>100){
						new TCoinJump(_gfx.x,_gfx.y)
					}
					break
			}
		}
		override public function headbutt(o:TObject):void{
			super.headbutt(o) //Let's stop the object from moving
			//If the headbutter is player, the bonus isn't in the middle of being hit and player didn't hit any bonus in this step yet
			if (o as TPlayer && !___bump && !TPlayer._hitBonus){
				TPlayer._hitBonus=true
				___bump=true
				___anim=0
				if (_bonus>100){//If the bonus is multiple coins we throw one Right Now!
					GiveBonus()
				}
			}
		}
	}
}