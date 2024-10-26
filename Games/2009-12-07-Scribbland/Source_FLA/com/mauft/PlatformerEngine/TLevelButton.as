package com.mauft.PlatformerEngine{
	import com.mauft.DataVault.Vault;
	import com.mauft.PlatformerEngine.objects.SFX;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class TLevelButton extends MovieClip{
		public var spin:Boolean=false
		public var spinned:uint=0
		public var lev:uint
		public var midx:Number
		public function TLevelButton(_x:Number, _y:Number, _level:uint){
			midx=x=_x
			y=_y
			lev=_level
			this.tabChildren=false
			this.tabEnabled=false
			if (Vault.retrieveValue("score_"+(lev-1).toString()) || lev==1){
				gotoAndStop(1)
			} else {
				gotoAndStop(2)
			}
			this.addEventListener(MouseEvent.ROLL_OVER, rOver)
			this.addEventListener(MouseEvent.ROLL_OUT, rOut)
			this.addEventListener(MouseEvent.CLICK, mClick)
			this.addEventListener(Event.ENTER_FRAME, step)
			this.addEventListener(Event.REMOVED_FROM_STAGE, kill)
			buttonMode=true
			cacheAsBitmap=true
		}
		public function rOver(e:MouseEvent):void{
			spin=true
			if (SFX.sfx){
				SFX.ROVER.play()
			}
		}
		public function rOut(e:MouseEvent):void{
			spin=false
		}
		public function mClick(e:MouseEvent):void{
			if (SFX.sfx){
				SFX.CLICK	.play()
			}
			parent.parent.parent.startFade(lev)
		}
		public function step(e:Event):void{
			if (M.animating){return}
			if (spin || spinned>0){
				spinned++
				x=midx+Math.sin(spinned*Math.PI/20)*15
				if (spinned==20){
					spinned=0
				}
			}
		}
		public function kill(e:Event):void{
			this.removeEventListener(MouseEvent.ROLL_OVER, rOver)
			this.removeEventListener(MouseEvent.ROLL_OUT, rOut)
			this.removeEventListener(MouseEvent.CLICK, mClick)
			this.removeEventListener(Event.ENTER_FRAME, step)
			this.removeEventListener(Event.REMOVED_FROM_STAGE, kill)
		}
	}
}