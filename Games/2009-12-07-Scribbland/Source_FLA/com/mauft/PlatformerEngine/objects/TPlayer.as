/*Platformer Engine by Mauft.com
__TPlayer__
Player Class. Player's movement properties can be found in the Settings.
This is the most COMPLEX class in the whole engine. Sorry for that, but with the comments it should all make sense!
*/

package com.mauft.PlatformerEngine.objects{
	import com.mauft.DataVault.Vault;
	import com.mauft.PlatformerEngine.Controls;
	import com.mauft.PlatformerEngine.DebugDraw;
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.effects.TPlayerKilled;
	import com.mauft.PlatformerEngine.tiles.TTile;

	import flash.display.MovieClip;
	import flash.geom.ColorTransform;

	final public class TPlayer extends TObject{
		override public function get xMod():Number{return 0}
		override public function get yMod():Number{return 0}

		public static var _hitBonus:Boolean=false		//Did the player hit the bonus in this step?
		public static var _stomped:Boolean=false			//Did the player stomp on an enemy in this step?
		public var invincible:Boolean=false				//Is the player invincible currently?
		public var sequence:uint=0							//What is the current movement sequence? (consult TPlayer.Step()
		public var shield:uint=0							//Is the player currently shielded?

		private var _jumpHold:int=0						//Holding jump, so when you hold the button player jumps higher
		private var _crouching:Boolean=false				//Is the player crouching at the moment?
		private var _isStanding:Boolean=false				//Is the player standing (or cruouching) on the floor?
		private var _damage:uint=0

		private var _dir:int=1


		private var _hp:int=50

		private var ___animTimer:Number=0 					//Animation-Wise: For animating player
		public var ___anim:Number=0						//Animation-Wise: For LevelEnding sequence
		private var ___ct:ColorTransform
		private var ___damageAnim:uint=0

		private var _startX:Number;
		private var _startY:Number;

		public function TPlayer(setX:Number,setY:Number,_gfx:MovieClip):void{
			_startX=x=setX
			_startY=y=setY

			gfx=_gfx
			gfx.parent.removeChild(gfx)
			Engine.layerObjects.addChild(gfx)

			width=20
			height=25

			___ct=gfx.transform.colorTransform

			Engine.player=this
			Engine.updateScrolling()
		}
		override public function Step():void{

			switch(sequence){
				case(0):	//Normal Movement
					Move()
					break;
				case(2):	//Dead
					updateAnimation()
					break;
				case(3):	//Level Ending
					Move()
					___anim++
					if (___anim>300){
						//Engine.LevelCompleted()		//We end the level, yay!
						Controls.disabled=false		//Giving control back to user
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

			if (Controls.isDownRight && Engine.started == 2){
				_speed += Settings.PLAYER_ACCELERATION * _dir;

			} else if (Controls.isDownLeft && Engine.started == 2){
				_speed -= Settings.PLAYER_ACCELERATION * _dir;

			} else {
				if (_speed > 0){
					_speed -= Settings.PLAYER_BRAKING

				} else if (_speed < 0){
					_speed += Settings.PLAYER_BRAKING
				}
			}

			if (_speed < -Settings.PLAYER_MAXSPEED){
				_speed = -Settings.PLAYER_MAXSPEED

			} else if (_speed > Settings.PLAYER_MAXSPEED){
				_speed = Settings.PLAYER_MAXSPEED
			}

			if (_speed > 1 || _speed < -1){
				Push(_speed,0)
			}	//Ok, now let's calculate the horizontal movement

			if (!Settings.PLAYER_REMEMBER_FLOOR){floorReset()}	//If we forget the floor, we have to reset its data now.
			if (_isStanding){	//If the player is standing let's check if he is still standing, otherwise we alter the gravity
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
				if (Controls.isJump && Engine.started==2){	//Is the player trying to jump?
					if (!Settings.PLAYER_REMEMBER_FLOOR){floorReset()}	//If we forget the floor, now is the time to reset it
					_gravity=Settings.PLAYER_JUMP*_floorMaxJump
					_jumpHold=Settings.PLAYER_JUMP_HOLD
					_isStanding=false
					SFX.playJump()
				}
			}

			_gravity=Math.min(_gravity,Settings.PLAYER_FALL)	//Change gravity
			Push(0,_gravity)						//And MOVE player vertically!
			updateAnimation()

			if (y>Settings.SCREEN_HEIGHT+30){
				kill()
			}

			DebugDraw.Rect(x,y,width,height)	//Just some good ol' debuggin
		}
		/*We update the animation here!*/
		private function updateAnimation():void{
			if (!_isStanding){
				gfx.gotoAndStop(3)

			}else if (_speed != 0 || Controls.isDownLeft || Controls.isDownRight){
				gfx.gotoAndStop(2)
			} else {
				gfx.gotoAndStop(1)
			}
			gfx.x=Math.round(x-xMod)
			gfx.y=Math.round(y-yMod)
				gfx.scaleX = 1;

			if (Controls.cheatAltControls && _speed < 0) {
				gfx.scaleX = -1;
				gfx.x += gfx.width * 0.6;
			}

			DebugDraw.Plot(Engine.player.x,Engine.player.y+Engine.player.height-(TPlayer._stomped?0:Engine.player.gravity)) //DEBUG!
		}
		/*Called when player is killed, for example after getting hit when small or falling into a pit*/
		public function kill():void{
			if (Engine.started<2 || invincible){return}
			SFX.playDie()
			x=_startX
			y=_startY
			if (gfx.currentFrame==2){gfx.gotoAndStop(3)}
			new TPlayerKilled(gfx, _speed)
			gfx=new _O_PLAYER
			gfx.mouseEnabled=false
			Engine.layerObjects.addChild(gfx)
			_speed=0
			_gravity=0

			Engine.RestartLevel()
		}
		/*Called when the player reaches some "level ending" spot, which can be exit or killing boss*/
		public function endLevel():void{
			Engine.player.sequence=3
			invincible=true
			Controls.disabled=true
		}
		override public function StopHorizontal():void{
			if (Engine.easy){
				if (Controls.cheatAltControls) {
					if (_speed < 0) {
						x = Math.floor(x / Settings.TILE_WIDTH) * Settings.TILE_WIDTH + Settings.TILE_WIDTH
					} else {
						x = Math.floor(x / Settings.TILE_WIDTH) * Settings.TILE_WIDTH + Settings.TILE_WIDTH - width
					}
					if (
						(_speed < 0 && !Controls.isDownLeft)
						|| (_speed > 0 && !Controls.isDownRight)
					) {
						_speed = 0;
					}
				} else if (_speed > 0) {
					x = Math.floor(x/Settings.TILE_WIDTH)*Settings.TILE_WIDTH+Settings.TILE_WIDTH-width
					_speed=-5
				}
				Vault.setValue("score", Vault.retrieveValue("score")+60)
			} else {
				kill()
			}
		}
		override public function StopJump():void{
			super.StopJump()
			_jumpHold=0
		}
		override public function StopFall():void{
			if (_gravity>1){
				SFX.playStep()
			}
			if (_damage==1){return} else if (_damage>1){_damage=0;_speed=0;shield=50}
			super.StopFall()
			_isStanding=true
		}
		public function get isStanding():Boolean{return _isStanding}
		public function get midX():uint{return x+width/2}
		public function get midY():uint{return y+height/2}
	}
}