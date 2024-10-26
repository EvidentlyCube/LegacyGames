/*Platformer Engine by Mauft.com
__Settings__
This static class containst various settings for the game, some of which 
	are dynamically set upon Engine's Init.
	You are free to change all the settings here, but beware not to do here
	any changes DYNAMICALLY DURING THE PROGRAM FLOW, unless YOU KNOW what YOU are doing!
*/

package com.mauft.PlatformerEngine{
	import flash.ui.Keyboard;
	final public class Settings{
		public static const SCREEN_WIDTH:uint=640					//Just type the game screen width here, it does not neccesirily have to be the size of flash app (but can't be bigger
		public static const SCREEN_HEIGHT:uint=480					//Just type the game screen height here, it does not neccesirily have to be the size of flash app (but can't be bigger
		
		public static const TILE_WIDTH:uint=25					//Width of one tile in pixels
		public static const TILE_HEIGHT:uint=25					//Height of one tile in pixels
		public static const LEVEL_WIDTH:uint=500					//Maximum level width in tiles, best if not too big for speed reasons
		public static const LEVEL_HEIGHT:uint=20					//Maximum level height in tiles, best if not too big for speed reasons
		
		public static const PLAYER_MAXSPEED:Number=3.5			//Player's maximum speed in PPS
		public static const PLAYER_ACCELERATION:Number=0.2		//Player's acceleration in PPS
		public static const PLAYER_FRICTION:Number=0.1			//Player's speed of breaking when not running in PPS
		public static const PLAYER_BRAKING:Number=0.2				//Player's speed of running when trying to quickly change direction (in other words, if you run right and start to hold left, how quickly will you brake) in PPS
		public static const PLAYER_REMEMBER_FLOOR:Boolean=true	//If set to true, when floor modifies your parameters this modifications will work even when you jump, only to be removed once you land again
		public static const PLAYER_JUMP:Number=-5					//Player's vertical speed when jumping
		public static const PLAYER_JUMP_HOLD:uint=12				//When player holds the jump button after jumping, amount of steps he can "lenghten" the jump before gravity starts to work
		public static const PLAYER_BOUNCE:Number=-3				//Player's vertical speed after stomping on the enemy
		public static const PLAYER_BOUNCE_HOLD:uint=12			//When player holds the jump button after stomping on the enemy, amount of steps he can "lenghten" the jump before gravity starts to work
		public static const PLAYER_CROUCH_SIZE:uint=17			//Difference between player's crouching and uncrouching state
		public static const PLAYER_ANIMATION_SPEED:uint=10		//Speed of walk animation, the lower the faster, the faster player the faster animation!
		public static const PLAYER_ANIMATION_WALK:uint=4			//Amount of Walk/Run frames, maximum is 10
		
		public static const PIPE_FIX_RIGHT:int=10					//Play with these variables...
		public static const PIPE_FIX_LEFT:int=10					//	...if the player is not completely hidden...
		public static const PIPE_FIX_DOWN:int=0					//	...when residing...
		public static const PIPE_FIX_UP:int=10					//	...inside the pipe.
		
		public static const FIREBALL_SPEED:Number=5				//Horizontal Speed of the Fireballs
		public static const FIREBALL_HEADBUTT_KILLS:Boolean=false//If set to true, Fireballs will be destroyed if they hit wall from the bottom
		public static const FIREBALL_BOUNCE_COUNT:uint=1000		//Amount of time a Fireball can bounce before being destroyed
		public static const FIREBALL_JUMP:uint=6					//Maximum Fireball's jump
		public static const FIREBALL_KILL_OFFSCREEN:Boolean=true//If set to true Fireballs will be removed when they leave the visible screen
		public static const FIREBALL_MAX:uint=2					//The maximum number of Fireballs that can be fired in the same time
		
		public static const GRAVITY:Number=0.4					//Power of the gravity in PPS
		public static const PLAYER_GRAVITY:Number=0.4				//Power of the gravity for player in PPS
		public static const FIREBALL_GRAVITY:Number=0.4			//Power of the gravity for Fireballs in PPS (set to 0 to make them fly horizontally)
		
		public static const FALL:Number=10						//Maximum object's Fall speed
		public static const PLAYER_FALL:Number=10					//Maximum player's Fall speed
		public static const FIREBALL_FALL:Number=10				//Maximum fireball's Fall speed
		
		
		public static var KEY_LEFT:uint=Keyboard.LEFT
		public static var KEY_RIGHT:uint=Keyboard.RIGHT
		public static var KEY_UP:uint=Keyboard.UP
		public static var KEY_DOWN:uint=Keyboard.DOWN
		public static var KEY_JUMP:uint=90
		public static var KEY_FIRE:uint=88
		
	}
}