/*Platformer Engine by Mauft.com
__TObject__
This is an abstract class which is a parent for all objects which includes bonuses,
projectiles, player and enemies.

The most unique thing with the engine is that you pass the graphics as Movie Clips, 
consult the CORE_PLAYER MC's First frame's code for details on how the passing works.

Take a look through the thing to understand how the things work around here.
*/

package com.mauft.PlatformerEngine.objects{
	import com.mauft.PlatformerEngine.DebugDraw;
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.tiles.TTile;
	
	import flash.display.MovieClip;
	public class TObject{
		/*These two getters are used instead of variables to make inheritance properly (in case of static) or speed things up (in case of local vars). 
		They indicate how the GFX is pushed relatively to the object's bounding box X and Y*/
		public function get xMod():Number{return 0}
		public function get yMod():Number{return 0}
		protected var _speed:Number=0					//Horizontal movement speed
		protected var _gravity:Number=0				//Vertical movement speed
		
		protected var _floorFriction:Number=1			//Friction modifier of the floor
		protected var _floorMaxSpeed:Number=1			//MaxSpeed modifier of the floor
		protected var _floorMaxJump:Number=1			//MaxJump modifier of the floor
		protected var _floorGravity:Number=1			//Gravity modifier of the floor
		
		public var gfx:MovieClip						//This variable holds the object's graphic as Movie Clip
		
		public var width:uint							//Collision box width
		public var height:uint							//Collision box height
		public var x:Number							//Collision box's top left corner X
		public var y:Number							//Collision box's top left corner Y
		
		private var _pushX:Number						//Variable used to determine which direction the player was moving when using StopHorizontal()
		public function TObject():void{}
		public function Step():void{}				//When object resides in the Engine.listObjects, this method is called every step
		
		/*This function is called when a Tile tries to stop player's Jump (when headbutting bonus for example)
		*/
		public function StopJump():void{
			y=Math.ceil(y/Settings.TILE_HEIGHT)*Settings.TILE_HEIGHT	//Set player's position so he does not appear "inside" the tile
			_gravity=0				//Set gravity to zero, you can comment it out to allow the player to "slide" on the ceiling
		}
		/*This function is called when a Tile tries to stop player's Fall (when landing on the floor for example)
		*/
		public function StopFall():void{
			y=Math.floor((y+height)/Settings.TILE_HEIGHT)*Settings.TILE_HEIGHT-height //Set player's position so he does not appear "inside" the tile
			_gravity=0						//Set gravity to zero
		}
		/*This function is called when a Tile tries to stop player's horizontal movement (when running into block for example)
		*/
		public function StopHorizontal():void{
			if (_pushX>0){			//If object was moving right
				x=Math.floor((x+width)/Settings.TILE_WIDTH)*Settings.TILE_WIDTH-width	//Set player's position so he does not appear "inside" the tile
			} else if (_pushX<0){	//If object was moving left
				x=Math.ceil(x/Settings.TILE_WIDTH)*Settings.TILE_WIDTH	//Set player's position so he does not appear "inside" the tile
			}
		}
		/*You call this function if you actually want to modify objects's position. This function does all movement calculations
		to prevent any kinds of errors.
		If you set "move" to false, the object's position won't be changed, but the calculations will still be made. This is useful when
		you have more complex movement for enemy and already modified his X and Y coordinates.
		*/
		public function Push(pushX:Number, pushY:Number, move:Boolean=true):void{
			//Let's initialize some temporary variables first.
			var i:Number
			var checkX:Number
			var checkY:Number
			var z:Number
			var tile:TTile
			
			//This variable is set so StopHorizontal() still remembers the direction the object was moving.
			_pushX=pushX
			
			//If the object isn't moving horizontally we can completely skip this part.
			if (pushX!=0){
				if (move){x+=pushX}			//If move is set to true, let's change the object's position.
				
				/*Ok now, I am going to explain this only once, as the rule applies to all cases below, 
				and in this example we assume the player is FALLING!:
				To make it impossible for Object to fall "inside" of the floor, we use a simple For loop to check collision on
				left corner, then every TILE_WIDTH, then on right corner. This way, if your player width is=20 and TILE_WIDTH=30 you will only have
				2 collision checks (at X=0 and X=19), but if we changed the TILE_WIDTH to 7 we would have four collision checks 
				(x=0, x=7, x=14, x=19). Easy, eh?
				*/
				
				z=Math.ceil(height/Settings.TILE_HEIGHT)				//We set z to the amount of checks we have to make
				if (pushX>0){											//If the player is moving RIGHT
					checkX=x+width										//checkX is set to one pixel after player width, to fight weird movement behavior
					for (i=0;i<=z;i++){									//Ah, THE For!
						checkY=y+(i==z?height-1:Settings.TILE_HEIGHT*i)	//If this is the last check, set it to height-1, otherwise TILE_HEIGHT*i
						DebugDraw.Plot(checkX,checkY)					//Some Draw for debugging
						tile=Engine.getTileFree(checkX,checkY)			//Get the tile at positions checkX,checkY?
						if (tile){tile.pokedLeft(this)}				//If yes, then let's tell it we hit it from the left!
					}
				} else if (pushX<0){
					checkX=x
					for (i=0;i<=z;i++){
						checkY=y+(i==z?height-1:Settings.TILE_HEIGHT*i)
						DebugDraw.Plot(checkX=x,checkY)
						tile=Engine.getTileFree(checkX=x,checkY)
						if (tile){tile.pokedRight(this)}
					}
				}
			}
			//If the object isn't moving vertically we can completely skip this part.
			if (pushY!=0){
				if (move){y+=pushY}
				z=Math.ceil(width/Settings.TILE_WIDTH)
				if (pushY>0){
					checkY=y+height-1
					for (i=0;i<=z;i++){
						checkX=x+(i==z?width-1:Settings.TILE_WIDTH*i)
						DebugDraw.Plot(checkX,checkY)
						tile=Engine.getTileFree(checkX,checkY)
						if (tile){tile.landed(this)}
					}
				} else if (pushY<0){
					checkY=y
					for (i=0;i<=z;i++){
						checkX=x+(i==z?width-1:Settings.TILE_WIDTH*i)		
						DebugDraw.Plot(checkX,checkY)
						tile=Engine.getTileFree(checkX,checkY)
						if (tile){tile.headbutt(this)}
					}
				}
			}
		}
		public function Reappear():void{}
		/*This function sets the object's Floor modifiers. It is usually only called by the Tiles.
		*/
		public function floorSet(fr:Number, ms:Number, mj:Number, gr:Number):void{
			_floorFriction=fr
			_floorMaxSpeed=ms
			_floorMaxJump=mj
			_floorGravity=gr
		}
		/*This function resets Floor modifiers to the default state
		*/
		public function floorReset():void{
			_floorFriction=_floorMaxSpeed=_floorMaxJump=_floorGravity=1
		}
		public function get speed():Number{return _speed	}			//Some getters and setters for Protected Variables
		public function set speed(s:Number):void{_speed=s}
		public function get gravity():Number{	return _gravity}
	}
}