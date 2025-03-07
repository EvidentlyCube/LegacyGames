﻿/*Platformer Engine by Mauft.com
__TEnemy__
To ease the process of making enemies, they have got their own parent class which obviously extends TObject!

It contains some additional functions.
*/

package com.mauft.PlatformerEngine.objects{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Geometry;
	
	import flash.geom.ColorTransform;
	
	public class TEnemy extends TObject{
		//Some flags for enemies, they aren't made with getters, because they CAN change dynamically!
		public function get type():uint{return 0}
		public var bounceTurning:Boolean=true		//Does this enemy "turn around" when stumping into other enemy?
		public var stopsShell:Boolean=false		//Does this enemy "kill" moving shell?
		public var bouncePlayer:Boolean=true		//Does this enemy make player jump when stomped on?
		protected var _hp:int
		protected var _sector:uint
		
		protected var ___CT:ColorTransform
		/*The thing with locked flag is that enemies by default are disabled, and only activate once the player is close enough to them.
		You can override this behavior by Overriding STEP instead of UPDATE!*/
		public var locked:Boolean=true
		
		public function TEnemy(){}
		/*You usually don't override this function for enemies, unless you want to disable the Locking
		*/
		override public function Step():void{
			Update()	//We call the update, which is enemy's equivalement of Step()
		}
		public function Update():void{}
		/*This function checks if the player is touching the enemy and if so, if he stomped on one or not.
		*/
		public function CheckPlayer():void{
			//If the player already stomped on an enemy in this step or is in the middle of some sequence, we skip this check
			if (Geometry.RectRect1(this,Engine.player)){	//If the player-enemy collision occurse
				Engine.player.kill()
			}
		}
		/*This function checks if enemy shoud bounce away from any other enemy
		*/
		public function CheckBounce():void{
			var e:TEnemy
			for (var i:uint;i<Engine.listEnemies.length;i++){
				e=Engine.listEnemies[i]
				if (e==this || e.type!=type){continue}	//If the checked enemy is this enemy or checked enemy has bounceTurning disabled, skip the rest
				if (Geometry.RectRect1(this,e)){
					if (x<e.x){	//If this enemy is to the left of the checked enemy
						if (_speed>0){Bounce()}
						if (e.speed<0){e.Bounce()}
					} else {	//otherwise
						if (_speed<0){Bounce()}
						if (e.speed>0){e.Bounce()}
					}
					return	//Once we got the check, we can skip the rest
				}
			}
		}
		/*This function is called when two enemies bounce from each other
		*/
		public function Bounce(dir:int=0):void{
			switch(dir){
				case(0):StopHorizontal();break;
				case(-1):
					if (_speed>0){_speed*=-1}
					break;
				case(1):
					if (_speed<0){_speed*=-1}
					break
			}
		}
		/*This function is called when enemy is hit by shell
		*/
		public function damage(_dam:uint):void{
			_hp-=_dam
		}
		protected function blinkUpdate():void{
			if(___CT.redOffset>0){
				___CT.redOffset-=5
				___CT.greenOffset-=5
				___CT.blueOffset-=5
				gfx.transform.colorTransform=___CT
			}
		}
		protected function blink():void{
			___CT.redOffset=100
			___CT.greenOffset=100
			___CT.blueOffset=100
			gfx.transform.colorTransform=___CT
		}
		public function get sector():uint{return _sector}
	}
}