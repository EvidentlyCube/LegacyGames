/*Platformer Engine by Mauft.com
__TPlayer__
Player Class. Player's movement properties can be found in the Settings.
This is the most COMPLEX class in the whole engine. Sorry for that, but with the comments it should all make sense!
*/

package com.mauft.PlatformerEngine.objects{
	import com.mauft.PlatformerEngine.Controls;
	import com.mauft.PlatformerEngine.DebugDraw;
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.tiles.TTile;
	
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	final public class TPlayer extends TObject{
		override public function get xMod():Number{return -3}
		override public function get yMod():Number{return -18}
		
		public static var _hitBonus:Boolean=false		//Did the player hit the bonus in this step? 
		public static var _stomped:Boolean=false			//Did the player stomp on an enemy in this step?
		public var invincible:Boolean=false				//Is the player invincible currently?
		public var sequence:uint=0							//What is the current movement sequence? (consult TPlayer.Step()
		public var shield:uint=0							//Is the player currently shielded?
		
		private var _jumpHold:int=0						//Holding jump, so when you hold the button player jumps higher
		private var _crouching:Boolean=false				//Is the player crouching at the moment?
		private var _isStanding:Boolean=false				//Is the player standing (or cruouching) on the floor?
		private var _damage:uint=0
		
		private var ___animTimer:Number=0 					//Animation-Wise: For animating player
		private var ___anim:Number=0						//Animation-Wise: For LevelEnding sequence
		private var ___ct:ColorTransform
		private var ___damageAnim:uint=0
		public function TPlayer(setX:Number,setY:Number,_gfx:MovieClip):void{
			x=setX
			y=setY
			
			gfx=_gfx
			gfx.parent.removeChild(gfx)
			Engine.layerObjects.addChild(gfx)
			
			width=7
			height=22
			
			___ct=gfx.transform.colorTransform

			Engine.player=this
		}
		override public function Step():void{
			switch(sequence){
				case(0):	//Normal Movement
					Move()
					break;
				case(2):	//Dead
					___animTimer++
					if (___animTimer<30){} else if (___animTimer<90){
						y-=(90-___animTimer)/10
					} else if(___animTimer<100){} else {
						y+=(___animTimer-100)/10
						if (y>Settings.LEVEL_HEIGHT*Settings.TILE_HEIGHT+200){
							
						}
					}
					updateAnimation()
					break;
				case(3):	//Level Ending
					Move()
					___anim++
					if (___anim>300){
						Engine.LevelCompleted()		//We end the level, yay!
						Controls.disabled=false		//Giving control back to user
						Controls.puppet(Settings.KEY_RIGHT,true)	//Let's release that key!
						sequence=0					//And set sequence to zero
					}
					break;
			}
		}
		/*The player is moving as usual*/
		public function Move():void{
			/*
			==First we Init some useful variables which will come in handy later
			The overall Player Movement Model looks like this:
			1. Alter Horizontal Movement
			2. Move Horizontally and check if hit wall
			3. Check if player is standing and update Floor data
			4. Check if player is jumping and jump/continue jumping
			5. Move Vertically and check if hit wall
			6. Update animation
			*/
			var i:Number
			var j:Number
			var checkX:Number
			var checkY:Number
			var z:Number
			var tile:TTile
			
			if (_damage>0){_damage++}
			_stomped=false		//...of these two flags
			
			//Calculate the shield
			if (shield>0){
				shield--	//Lessen the shield time by one
				invincible=true
				if (shield==0){	
					invincible=false
				}
			}
			
			/*
			==Ok, we have to calculate how the player's horizontal movement changes depending on what buttons we are holding.
			Sorry, I am not going to explain this one. It is just loads of math and I guess it can be figured out pretty easily
			if you take time to read carefully. Keep in mind that I made it that the player moves much slower when crouching,
			should you want to get rid of it remove the "*(_crouching?0.3:1)" from the bottom script
			*/

			if (!_damage){
				if (_speed>0){
					gfx.scaleX=1
					if (Controls.holdRight && (!_crouching || !_isStanding)){
						_speed+=Settings.PLAYER_ACCELERATION*_floorFriction*(_crouching?0.3:1)
					} else if (Controls.holdLeft && (!_crouching || !_isStanding)){
						_speed-=Settings.PLAYER_BRAKING*_floorFriction
					} else {
						_speed-=Settings.PLAYER_FRICTION*_floorFriction
						if (Math.abs(_speed)<Settings.PLAYER_ACCELERATION*2*_floorFriction){_speed=0}
					}
				} else if (_speed<0){
					gfx.scaleX=-1
					if (Controls.holdLeft && (!_crouching || !_isStanding)){
						_speed-=Settings.PLAYER_ACCELERATION*_floorFriction*(_crouching?0.3:1)
					} else if (Controls.holdRight && (!_crouching || !_isStanding)){
						_speed+=Settings.PLAYER_BRAKING*_floorFriction
					} else {
						_speed+=Settings.PLAYER_FRICTION*_floorFriction
						if (Math.abs(_speed)<Settings.PLAYER_ACCELERATION*2*_floorFriction){_speed=0}
					}
				} else {
					if (Controls.holdLeft && (!_crouching || !_isStanding)){
						_speed-=Settings.PLAYER_ACCELERATION*_floorFriction*(_crouching?0.3:1)
					} else if (Controls.holdRight && (!_crouching || !_isStanding)){
						_speed+=Settings.PLAYER_ACCELERATION*_floorFriction*(_crouching?0.3:1)
					}
				}
			}
			/*
			==Cap the player's speed
			*/
			if (_speed>Settings.PLAYER_MAXSPEED*_floorMaxSpeed){
				_speed=Settings.PLAYER_MAXSPEED*_floorMaxSpeed
			} else	if (_speed<-Settings.PLAYER_MAXSPEED*_floorMaxSpeed){
				_speed=-Settings.PLAYER_MAXSPEED*_floorMaxSpeed
			}
			Push(_speed,0)	//Ok, now let's calculate the horizontal movement
				
			if (!Settings.PLAYER_REMEMBER_FLOOR){floorReset()}	//If we forget the floor, we have to reset its data now.
			if (_isStanding){	//If the player is standing let's check if he is still standing, otherwise we alter the gravity
				trace("FLOOR CHEXOR")
				_isStanding=false
				z=Math.ceil(width/Settings.TILE_WIDTH)
				for (i=0;i<=z;i++){
					checkX=x+(i==z?width-1:Settings.TILE_WIDTH*i)
					DebugDraw.Plot(checkX,y+height)
					tile=Engine.getTileFree(checkX,y+height)
					if (tile){tile.stomped(this)}
				}
			} else {
				_gravity+=Settings.PLAYER_GRAVITY
			}

			/*
			So, if the player IS still standing, let's check Jumping and crouching.
			And YES, you can't crouch or uncrouch in the midair!
			*/
			if (_isStanding){
				if (Controls.hitJump){	//Is the player trying to jump?
					if (!Settings.PLAYER_REMEMBER_FLOOR){floorReset()}	//If we forget the floor, now is the time to reset it
					_gravity=Settings.PLAYER_JUMP*_floorMaxJump
					_jumpHold=Settings.PLAYER_JUMP_HOLD
					_isStanding=false
				}
			} else if (_jumpHold>0){//If the player is not standing, perhaps he can lenghten the jump?
				if (Controls.holdJump){//Is he even trying to do so?
					//Let's keep him in the air then
					_jumpHold--
					_gravity=Settings.PLAYER_JUMP*_floorMaxJump
				} else {
					_jumpHold=0 //Otherwise, we disallow the further jump holding for this jump
				}
			}
			
			_gravity=Math.min(_gravity,Settings.PLAYER_FALL)	//Change gravity
			trace("A falz ---")
			Push(0,_gravity)						//And MOVE player vertically!
			trace("--- falzed A")
			updateAnimation()
			
			DebugDraw.Rect(x,y,width,height)	//Just some good ol' debuggin
		}
		/*This function checks if the player can uncrouch in his current position*/
		private function unCrouch():Boolean{
			var z:Number
			var i:uint
			var tile:TTile
			z=Math.ceil(width/Settings.TILE_WIDTH)
			for (i=0;i<=z;i++){
				tile=Engine.getTileFree(x+(i==z?width-1:Settings.TILE_WIDTH*i),y-Settings.PLAYER_CROUCH_SIZE)
				if (tile && tile.blockUncrouch){
					return false
				}
			}
			return true
		}
		/*We update the animation here!*/
		private function updateAnimation():void{
			/*All size's frames start every 20, from, so small mario has frames 1-20, big from 21-40, fireball 41-60. 
			There is still space for two more sizes, 61-80 and 81-100
			*/
			var newFrame:uint=0
			switch (sequence){
				case(0):	//Is moving
				case(3):	//Is moving with level ending
					if (_speed==0){___animTimer=0}
					___animTimer=(___animTimer+Math.abs(_speed))%(Settings.PLAYER_ANIMATION_SPEED*Settings.PLAYER_ANIMATION_WALK)
					newFrame+=1+Math.floor(___animTimer/Settings.PLAYER_ANIMATION_SPEED)
					break;
				case(2):	//Dies
					newFrame=101
					break;
			}
			gfx.gotoAndStop(newFrame)
			gfx.alpha=shield%2?0.5:1
			gfx.x=Math.round(x)-xMod
			gfx.y=Math.round(y)-yMod
			gfx.rotation=_speed*3
			
			if (___damageAnim>0){
				___damageAnim--
				___ct.blueOffset=___ct.redOffset=___ct.greenOffset=___damageAnim*6
				gfx.transform.colorTransform=___ct
			}
			
			DebugDraw.Plot(Engine.player.x,Engine.player.y+Engine.player.height-(TPlayer._stomped?0:Engine.player.gravity)) //DEBUG!
		}	
		/*This function is called when player stomps on an enemy, and we pass the enemy's top Y coordinate*/
		public function Stomped(enemyY:Number):void{
			_stomped=true
			enemyY-=height
			Push(0,enemyY-y)	//Let's relocate the player but in a way he can't end up in a wall!
			updateAnimation()
			_gravity=Settings.PLAYER_BOUNCE
			_jumpHold=Settings.PLAYER_BOUNCE_HOLD
		}
		/*Called when player is damaged, for example by running into an enemy*/
		public function Damaged():void{
			if (invincible){return}	//If he is invincible we can just ignore it, eh?
			_damage=1
			___damageAnim=15
			_speed=gfx.scaleX==1?-1:1
			_gravity=-1.5
			_isStanding=false
			trace("AYAYAYAYAYAYAYAYAYAYA++++++++++++++")
		}
		/*Called when player is killed, for example after getting hit when small or falling into a pit*/ 
		public function kill():void{
			if (sequence==2){return}
			sequence=2
			gfx.gotoAndStop(101)
			gfx.parent.removeChild(gfx)
			Engine.layerForeground.addChild(gfx)
		}
		/*Called when the player reaches some "level ending" spot, which can be exit or killing boss*/
		public function endLevel():void{
			Engine.player.sequence=3
			Engine.scrollLocked=true
			invincible=true
			___animTimer=0
			Controls.disabled=true
			Controls.puppet(Settings.KEY_RIGHT,false)
			Controls.puppet(Settings.KEY_LEFT,true)
			Controls.puppet(Settings.KEY_JUMP,true)
			Controls.puppet(Settings.KEY_FIRE,true)
		}
		override public function StopHorizontal():void{
			super.StopHorizontal()
			_speed=0	//And also let's set player's speed to 0!
		}
		override public function StopJump():void{
			super.StopJump()
			_jumpHold=0
		}
		override public function StopFall():void{

			if (_damage==1){return} else if (_damage>1){_damage=0;_speed=0}
			if (_gravity>4.5){
				super.StopFall()
				Damaged()
			} else {
				super.StopFall()
				_isStanding=true
			}
			
			
		}
		public function get isStanding():Boolean{return _isStanding}
	}
}