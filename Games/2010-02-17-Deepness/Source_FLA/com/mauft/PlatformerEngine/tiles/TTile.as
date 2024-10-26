/*Platformer Engine by Mauft.com
__TTile__
This is an abstract class which is a parent for all tiles, which includes Bonus Blocks!

============TILE PROPERTIES EXPLANATION===========
:: friction:Number
Value from 0 to Infinity. It multiplies the player's default floor friction. Setting it to 0
will make the player slide without breaking, while setting it to 1 will make the player move
like usual. In-between numbers can be used, eg. 0.2 will make player slide heavily but he
will still be controllable. Setting it to anything bigger than 1 will make the player
accelerate and brake faster. It also affects acceleration.

:: maxSpeed:Number
Value from 0 to Infinity. It multiplies the player's default maximum speed. Seting it to 0
will make the player unable to move, while setting it to 10 will allow the player to move
10 times faster than usual. 1 is the default speed.

:: maxJump:Number
Value from 0 to Infinity. It multiplies the player's default jump height. Setting it to 0
will make the player unable to jump, while setting it to 2 will make player jump twice as high.
1 is the default jump height.

:: gravity:Number
Value from 0 to Infinity. It multiplies the player's default gravity. Setting it to 0
will disable the player's gravity (not something you might want), while setting it to 2 
will make the player's gravity twice as strong as usual.
1 is the default jump height. It doesn't work if Settings.PLAYER_REMEMBER_FLOOR is set to false.

:: blockUncrouch:Boolean
If set to true it won't allow player to stand from crouching if by crouching he would end up with his head in the tile

============TILE FUNCTIONS EXPLANATION===========
:: stomped()
Called when player stands on a tile. By default it stops the player's falling and
sets the floor multipliers.

:: landed()
Called when player lands on a tile. By default it calls stomped().

::hit()
Called when player hits the tile from the bottom. By default it stops the player's jump.

::pokedLeft()
Called when player runs into tile from the left. By default it stops the player's horizontal movement.

::pokedRight()
Called when player runs into tile from the right. By default it calls pokedLeft()
*/

package com.mauft.PlatformerEngine.tiles{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.objects.TObject;
	import com.mauft.PlatformerEngine.objects.TPlayer;
	
	import flash.errors.*;
	public class TTile{
		public function get friction():Number{return 1}
		public function get maxSpeed():Number{return 1}
		public function get maxJump():Number{return 1}
		public function get gravity():Number{return 1}
		public function get blockUncrouch():Boolean{return true}
		public function TTile(){}
		public function stomped(o:TObject):void{
			o.StopFall()
			
			o.floorSet(friction,maxSpeed,maxJump,gravity)
		}
		public function landed(o:TObject):void{stomped(o)}
		public function headbutt(o:TObject):void{
			o.StopJump()
		}
		public function pokedLeft(o:TObject):void{
			o.StopHorizontal()	
		}
		public function pokedRight(o:TObject):void{pokedLeft(o)}
	}
}