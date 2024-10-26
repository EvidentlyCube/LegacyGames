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
	import com.mauft.PlatformerEngine.objects.objects.TFireball;
	import com.mauft.PlatformerEngine.objects.objects.TPipe;
	import com.mauft.PlatformerEngine.tiles.TTile;
	
	import flash.display.MovieClip;
	
	final public class TPlayer extends TObject{
		override public function get xMod():Number{return -8}
		override public function get yMod():Number{return 0}
		public static var _hitBonus:Boolean=false		//Did the player hit the bonus in this step? 
		public static var _stomped:Boolean=false			//Did the player stomp on an enemy in this step?
		public static var _size:uint=0					//What is the player's size? Static so it remains in further levels!
		public var keys:Array=new Array(10)				//This variable contains all the keys data.
		public var invincible:Boolean=false				//Is the player invincible currently?
		public var sequence:uint=0							//What is the current movement sequence? (consult TPlayer.Step()
		public var shield:uint=0							//Is the player currently shielded?
		
		public var _jumpHold:int=0							//Holding jump, so when you hold the button player jumps higher
		private var _crouching:Boolean=false				//Is the player crouching at the moment?
		private var _isStanding:Boolean=false				//Is the player standing (or cruouching) on the floor?
		
		private var ___braking:Boolean=false				//Animation-Wise: Is the player braking?
		private var ___firing:uint=0						//Animation-Wise: Is the player firing a fireball?
		private var ___animTimer:Number=0 					//Animation-Wise: For animating player
		private var ___anim:Number=0						//Animation-Wise: For LevelEnding sequence
		private var ___piping:uint=0						//Animation-Wise: Direction the player enters/leaves pipe
		private var ___pipe:TPipe 							//Animation-Wise: Link to a pipe object
		private var ___morphFrom:uint=0					//Animation-Wise: From what is player morphing?
		private var ___morphAnim:uint=0					//Animation-Wise: Is the player morphing currently?
		public function TPlayer(setX:Number,setY:Number,_gfx:MovieClip):void{
			x=setX
			y=setY
			
			gfx=_gfx
			gfx.parent.removeChild(gfx)
			Engine.layerObjects.addChild(gfx)
			
			width=16
			if (_size==0){
				height=23
			} else {
				height=40
			}
			
			Engine.player=this
		}
		override public function Step():void{
			switch(sequence){
				case(0):	//Normal Movement
					Move()
					break;
				case(1):	//Entering Pipe
					Piping()
					break;
				case(2):	//Dead
					___animTimer++
					if (___animTimer<30){} else if (___animTimer<90){
						y-=(90-___animTimer)/10
					} else if(___animTimer<100){} else {
						y+=(___animTimer-100)/10
						if (y>Settings.LEVEL_HEIGHT*Settings.TILE_HEIGHT+200){
							if (Engine.lives==0){
								Engine.paused=true		//Stop the engine from acting
								Controls.disabled=true	//Mark the game as paused so nothing moves anymore.
								//WHEN RESTARTING THE GAME REMEMBER TO CHANGE THE ABOVE FLAGS TO __FALSE__!!!
							} else {
								Engine.lives--
								Engine.RestartLevel()
							}
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
			
			_hitBonus=false		//Reset the state...
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

			if (_speed>0){
				gfx.scaleX=1
				if (Controls.holdRight && (!_crouching || !_isStanding)){
					_speed+=Settings.PLAYER_ACCELERATION*_floorFriction*(_crouching?0.3:1)
				} else if (Controls.holdLeft && (!_crouching || !_isStanding)){
					_speed-=Settings.PLAYER_BRAKING*_floorFriction
					___braking=true
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
					___braking=true
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
			_gravity+=Settings.PLAYER_GRAVITY

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
				} else if (Controls.holdDown){//Or maybe he is trying to crouch?
					if (!_crouching && _size>0){	//If he is crouching already or is small mario, we skip this part
						_crouching=true
						height=23
						y+=17
					}
				} else if(_crouching && unCrouch()){//Then maybe he tries to Uncrouch? If he does and he can, we fullfill his wish!
					_crouching=false
					height=40
					y-=17
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
			if (gravity>1 || gravity<-1){
				_isStanding=false
			}
			Push(0,_gravity)						//And MOVE player vertically!
			
			/*
			==Now, if the player wants to fire a fireball, he is of proper size, he isn't crouching, and there isn't too many fireballs in the
			air already
			*/
			if (Controls.hitFire && _size==2 && !_crouching && TFireball._count<Settings.FIREBALL_MAX){
				___firing=3			//Set the ___firing to 3 so the firing frame is visible for three steps
				if (gfx.scaleX<0){
					new TFireball(x,y+4,-1)
				} else {
					new TFireball(x+width,y+4,1)
				}
			}
			
			updateAnimation()
			
			DebugDraw.Rect(x,y,width,height)	//Just some good ol' debuggin
		}
		/*The player is netering the pipe*/
		public function Piping():void{
			switch(___piping){
				case(0):		//Enters to the Right
					___animTimer++
					if (___animTimer<width+Settings.PIPE_FIX_RIGHT){
						x+=1
					} else if (___animTimer>=100){
						___pipe.leavePipe()
					}
					break;
				case(1):		//Enters to the Down
					___animTimer++
					if (___animTimer<height+Settings.PIPE_FIX_DOWN){
						y+=1
					} else if (___animTimer>=100){
						___pipe.leavePipe()
					}
					break;
				case(2):		//Enters to the Left
					___animTimer++
					if (___animTimer<width+Settings.PIPE_FIX_LEFT){
						x-=1
					} else if (___animTimer>=100){
						___pipe.leavePipe()
					}
					break;
				case(3):		//Enters to the Up
					___animTimer++
					if (___animTimer<height+Settings.PIPE_FIX_UP){
						y-=1
					} else if (___animTimer>=100){
						___pipe.leavePipe()
					}
					break;
				case(10):		//Leaves to the Right
					x+=1
					___animTimer++
					if (___animTimer>=width+Settings.PIPE_FIX_RIGHT){
						leftPipe()
					}
					break;
				case(11):		//Leaves to the Down
					y+=1
					___animTimer++
					if (___animTimer>=height+Settings.PIPE_FIX_DOWN){
						leftPipe()
					}
					break;
				case(12):		//Leaves to the Left
					x-=1
					___animTimer++
					if (___animTimer>=width+Settings.PIPE_FIX_LEFT){
						leftPipe()
					}
					break;
				case(13):		//Leaves to the Up
					y-=1
					___animTimer++
					if (___animTimer>=height+Settings.PIPE_FIX_UP){
						
						leftPipe()
					}
					break;
			}
			updateAnimation()
		}
		/*We want to make the player big!*/
		public function makeBig():void{
			if (_size>0){return} //If he is big already let's just skip it 
			if (unCrouch()){	//If he can be big here he appears as normal
				height=40
				y-=17
				_size=1
			} else {			//If not, he appears crouched
				_crouching=true
				_size=1
			}
			//Some animation stuff
			___morphAnim=50	//Show morph anim for 50 steps
			___morphFrom=0	//Morph from small Mario
			shield=100		//Shield player for 100 steps
			invincible=true
		}
		/*We want to make the player big and shoot fireballs!*/
		public function makeFlowery():void{
			if (_size==2){return}	//If he is big already, let's skip it
			if (_size==0){makeBig();return}	//If he is small, he has to get big first!
			___morphAnim=50
			___morphFrom=_size
			_size=2
			shield=100
			invincible=true
		}
		/*We want to make the player small again!*/
		public function makeSmall():void{
			if (_size==0){return}	//If he is small already, skip it!
			if (!_crouching){	//If he isn't crouching, relocate
				y+=17
			}
			___morphAnim=50
			___morphFrom=_size
			
			_crouching=false
			height=23
			_size=0
			shield=100
			invincible=true
			
			updateAnimation()
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
			/*1 to 10=Walk Frames 1-10
			  11=Jump
			  12=Brake
			  13=Crouch
			  14=Fire
			  15=Entering Pipe Vertically
			  16-19=FREE
			  
			  101=Dead
			*/
			/*All size's frames start every 20, from, so small mario has frames 1-20, big from 21-40, fireball 41-60. 
			There is still space for two more sizes, 61-80 and 81-100
			*/
			var newFrame:uint=___morphAnim%2?20*___morphFrom:20*_size		//If he is morphing, alternate between sizes
			switch (sequence){
				case(0):	//Is moving
				case(3):	//Is moving with level ending
					if (_crouching){	//If the player is crouching
						___animTimer=0
						___firing=0
						newFrame+=13
					} else if (___firing){	//Otherwise if he is firing
							newFrame+=14
					} else if (_isStanding){//Otherwise when he is standing
						if (___braking){		//and Braking
							___animTimer=0
							newFrame+=12
						} else {				//Or just walking
							if (_speed==0){___animTimer=0}
							___animTimer=(___animTimer+Math.abs(_speed))%(Settings.PLAYER_ANIMATION_SPEED*Settings.PLAYER_ANIMATION_WALK)
							newFrame+=1+Math.floor(___animTimer/Settings.PLAYER_ANIMATION_SPEED)
						}
					} else {	//Otherwise he stands in place
						___animTimer=0
						newFrame+=11
					}
					break;
				case(1):	// Enters/leaves pipe
					switch(___piping%10){
						case(0):newFrame+=11;gfx.scaleX=1;break
						case(1):newFrame+=15;break
						case(2):newFrame+=11;gfx.scaleX=-1;break
						case(3):newFrame+=15;break
					}
					break;
				case(2):	//Dies
					newFrame=101
					break;
			}
			gfx.gotoAndStop(newFrame)
			gfx.alpha=shield%2?0.5:1
			if (___morphAnim==0 || _crouching){	//The player is as usual
				gfx.x=Math.round(x)-xMod
				gfx.y=Math.round(y)-yMod
			} else if (___morphFrom==0 && _size>0){	//The player is morphing FROM small mario
				gfx.x=Math.round(x)-xMod
				gfx.y=Math.round(y)-yMod+(___morphAnim%2?17:0)
			} else if (___morphFrom>0 && _size==0){	//The player is morphing TO small mario
				gfx.x=Math.round(x)-xMod
				gfx.y=Math.round(y)-yMod-(___morphAnim%2?17:0)
			} else {								//The player is morphing between BIG and FLOWERY (or vice versa)
				gfx.x=Math.round(x)-xMod
				gfx.y=Math.round(y)-yMod
			}
			if (___morphAnim>0){___morphAnim--}
			___braking=false	//Reset the flag
			if (___firing>0){___firing--}
			
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
			if (_size>0){
				makeSmall()
			} else {
				kill()
			}
		}
		/*Called when player is killed, for example after getting hit when small or falling into a pit*/ 
		public function kill():void{
			if (sequence==2){return}
			_size=0
			sequence=2
			gfx.gotoAndStop(101)
			gfx.parent.removeChild(gfx)
			Engine.layerForeground.addChild(gfx)
		}
		/* Called when player enters a pipe*/
		public function enteredPipe(_dir:uint, _pipe:TPipe):void{
			___piping=_dir
			___pipe=_pipe
			sequence=1
			___animTimer=0
			invincible=true
			if (_crouching){
				_crouching=false
				height+=Settings.PLAYER_CROUCH_SIZE
			}
		}
		/*Called when player leaves a pipe*/
		public function leftPipe():void{
			___piping=0
			___pipe=null
			sequence=0
			___animTimer=0
			invincible=false
			_speed=0
			_gravity=0
			//_crouching=false
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
			super.StopFall()
			_isStanding=true
		}
		public function get isStanding():Boolean{return _isStanding}
		public function set isStanding(s:Boolean):void{_isStanding=s}
	}
}