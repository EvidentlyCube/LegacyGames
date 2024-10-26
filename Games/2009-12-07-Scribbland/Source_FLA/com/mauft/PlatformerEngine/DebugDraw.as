/* Platformer Engine by Mauft.com
__DebugDraw__
This is a little class I created to make things easier to debug. The debug ALWAYS draws on top of all other layers,
and is scrolled properly.

Before releasing, to speed things up remove all DebugDraw calls.
*/

package com.mauft.PlatformerEngine{
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class DebugDraw{
		private static const DISABLED:Boolean=true			//Set it to false if you want to make debug disappear
		private static var s:Stage
		private static var sh:Shape
		public function DebugDraw(){}
		public static function Init(_s:Stage):void{
			sh=new Shape
			s=_s
			s.addChild(sh)
			s.addEventListener(Event.ENTER_FRAME,step)
		}
		private static function step(e:Event):void{
			if (DISABLED){return}
			sh.graphics.clear()
			s.setChildIndex(sh,s.numChildren-1)
		}
		//Plots a 3x3 Pixel on designated dimensions
		public static function Plot(x:Number,y:Number):void{
			if (DISABLED){return}
			sh.graphics.beginFill(0xFF0000)
			sh.graphics.drawRect(x-1,y-1,3,3)
			sh.graphics.endFill()
		}
		//Draws a rectangle in designated dimensions
		public static function Rect(x:Number,y:Number,w:Number,h:Number):void{
			if (DISABLED){return}
			sh.graphics.beginFill(0x00FF00,0.3)
			sh.graphics.drawRect(x,y,w,h)
			sh.graphics.endFill()
		}
	}
}