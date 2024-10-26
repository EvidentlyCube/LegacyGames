/*Platformer Engine by Mauft.com
__THud__
You can edit the Hud visuals in the .fla->CORE_HUD.
Hud object does not store any data, it only displays it.
*/

package com.mauft.PlatformerEngine.objects{
	import flash.display.MovieClip;
	
	public dynamic class THud extends MovieClip{
		public function THud(){}
		/*Sets the score text with leading zeroes to make the text length equal to 8
		*/
		public function setScore(n:uint):void{
			var s:String=n.toString()
			while (s.length<8){
				s="0"+s
			}
			_SCORE.text=n.toString()
		}
		/*Sets the lives text with leading zeroes to make the text length equal to 2
		*/
		public function setLives(n:uint):void{
			var s:String=n.toString()
			while (s.length<2){
				s="0"+s
			}
			_LIVES.text=n.toString()
		}
		/*Sets the time text
		*/
		public function setTime(n:uint):void{
			_TIME.text=n.toString()
		}
		
	}
}