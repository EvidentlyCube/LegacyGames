/* Platformer Engine by Mauft.com
__Engine__
This is the main Class it holds all the important stuff.

THINGS TO KNOW:
--Here I put thoughts about the engine alltogether so it might be worth read--
* Private variables and functions are preceeded with underscore _
* Objects=Bonuses, Projectiles
* PPS=Pixels Per Step

Difference between listEnemies and listObjects is that you CAN check collision against Enemies, but can't
against Objects. That is, bonuses check collision against player, not the other way round (enemies too, but
for example Enemy like Koopa Troopa Shell can check collision against other enemies to see if it kills them)
*/
package com.mauft.PlatformerEngine{
	import com.mauft.DataVault.Vault;
	import com.mauft.PlatformerEngine.objects.*;
	import com.mauft.PlatformerEngine.objects.enemies.*;
	import com.mauft.PlatformerEngine.objects.objects.*;
	import com.mauft.PlatformerEngine.tiles.*;

	import flash.display.*;
	import flash.errors.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.TextField;
	public class Engine{
		public static var easy:Boolean=true
		private static var _initialized:Boolean=false				//Just to make some major functions clean
		public static var _stage:Stage								//This is where the link to Stage is held
		public static var _gamefield:MovieClip						//And here we store the link to the main playfield
		private static var _level:Array								//A Level array

		public static var paused:Boolean=false						//Is the game paused or not?

		public static var listEnemies:Array							//List of all Enemies
		public static var listObjects:Array							//List of all Objects

		public static var player:TPlayer								//Link to player instance!

		public static var layerParallax:Sprite						//Layer holding parallax backgrounds
		public static var layerBackground:Sprite						//Layer holding backgrounds
		public static var layerObjects:Sprite							//Layer holding objects
		public static var layerEnemies:Sprite							//Layer holding Enemies
		public static var layerTiles:Sprite							//Layer holding tiles/walls
		public static var layerForeground:Sprite						//Layer holding foreground images

		public static var bgFader:MovieClip
		public static var bgFaderState:uint=0
		public static var bgFaderTo:uint=0

		public static var started:uint=0
		public static var hud:TextField
		public static var ending:Boolean=false
		public static var titled:Boolean=false
		public static var time:int=1000
		public static var level:uint=0
		public static var finish:uint=0
		//This is used when iterating through enemies array, to avoid situation when one enemy removes other and some other enemy is skipped because of that
		private static var _checkedEnemy:int=0
		private static var _restartLevel:Boolean=false				//Are we restarting the level at the beginning of next step?

		/*Init - probably the most important method, it actually initializes the whole thing!
		You usually call it like that, in the first line of the first frame of the main timeline:
		Init(stage, this)
		*/
		public static function Init(s:Stage, gf:MovieClip):void{
			if (_initialized){return}
			DebugDraw.Init(s)									//Here we initialize the debugging object
			_initialized=true									//Set the flag to true so we know we called it before
			_stage=s											//Store the stage
			_gamefield=gf										//Store the main gamefield

			//Generating the empty Level Array
			_level=new Array(Settings.LEVEL_WIDTH)
			for (var i:uint=0;i<Settings.LEVEL_WIDTH;i++){
				_level[i]=new Array(Settings.LEVEL_HEIGHT)
			}

			bgFader=new _MC_PAPER
			bgFader.alpha=0

			//Creating empty Arrays for Lists
			listEnemies=new Array()
			listObjects=new Array()

			//Creating empty Sprites for Layers
			layerParallax=new Sprite()
			layerBackground=new Sprite()
			layerObjects=new Sprite()
			layerEnemies=new Sprite()
			layerTiles=new Sprite()
			layerForeground=new Sprite()

			new SFX

			//Adding some listeners
			_stage.addEventListener(Event.ENTER_FRAME,Step)
			_stage.addEventListener(KeyboardEvent.KEY_DOWN,Controls.listenerDown)
			_stage.addEventListener(KeyboardEvent.KEY_UP,Controls.listenerUp)
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, Controls.mouseDown)
			_stage.addEventListener(MouseEvent.MOUSE_UP, Controls.mouseUp)
		}
		/*This function is attached to the ENTER_FRAME event, and thus is called every step.
		*/
		public static function Step(e:Event):void{
			if (bgFaderState==1){ //Fade Level In
				if (bgFader.alpha>0){
					if (_gamefield.contains(bgFader)) {
						_gamefield.setChildIndex(bgFader,_gamefield.numChildren-1)
					}
					bgFader.alpha-=0.05
				} else {
					bgFaderState=0
				}
			} else if(bgFaderState==2){ //Fade Level Out
				if (bgFader.alpha<1){
					if (_gamefield.contains(bgFader)) {
						_gamefield.setChildIndex(bgFader,_gamefield.numChildren-1)
					}
					bgFader.alpha+=0.05
				} else {
					bgFaderState=0
					switch(bgFaderTo){
						case(0)://next level
							EndLevel()
							break;
						case(1)://title screen
							EndLevel()
							break;
					}
				}
			}
			if (started==0 && !Controls.isAnyInput){
				started=1
			} else if (started==1 && Controls.isAnyInput){
				started=2
			} else if (started==2 && bgFaderState<2){
				Vault.setValue("score", Vault.retrieveValue("score")+(Engine.easy?2:1))
			}
			if (hud){hud.text="Antiscore: "+Vault.retrieveValue("score").toString()}
			if (ending){												//Are we restarting the level?...
				ending=false												//Ok, we won't restart it more than once
				EndLevel()
			} else 	if (!paused){											//..Otherwise...
				if (player){player.Step()}												//If we actually have the player, let's make him MOVE!
				//Let's make the Enemies move!
				for(_checkedEnemy=0;_checkedEnemy<listEnemies.length;_checkedEnemy++){
					listEnemies[_checkedEnemy].Step()
				}
				//And objects too!
				for(var i:int=listObjects.length-1;i>=0;i--){
					listObjects[i].Step()
				}
			}
			//And let's Flush the controls now
			Controls.Update()
			SFX.musUpdate()

		}
		/*updateScrolling - It is called when the layers need repositioning depending on player's position.
		It's more or less self explanatory and does not really need to be changed.
		*/
		public static function updateScrolling():void{

		}
		/*StartLevel - You HAVE! to call this function, to make EVERYTHING appear on the screen (unless you screwed something on
		the playfield, then I guess you WILL see SOMETHING).
		It performs some basic level-initialization stuff, adding layers to stage, unlocking and resetting scrolling
		*/
		public static function StartLevel():void{
			titled=true
			Vault.setValue("score", 1000)
			started=0
			bgFader.alpha=1
			bgFaderState=1
			Controls.disabled=false
			_gamefield.addChild(layerParallax)
			_gamefield.addChild(layerBackground)
			_gamefield.addChild(layerTiles)
			_gamefield.addChild(layerEnemies)
			_gamefield.addChild(layerObjects)
			_gamefield.addChild(layerForeground)
			_gamefield.addChild(bgFader)

			Engine.listObjects.push(new ESCER())
		}
		/*EndLevel - Once you are done with a level, say, because you completed it or returned to menu, you call this little fella
		to make things disappear!
		Keep in mind that it DOES NOT remove the objects, locks the Controls or disables the step - the game is essentially still going on, you
		just don't see it.
		Use:
		Engine.Clear()
		Engine.paused
		Controls.disabled
		to do the stuff mentioned above!
		*/
		public static function EndLevel():void{
			var ret:Boolean=false
			if (bgFaderTo==0){
				if (Vault.retrieveValue("score_"+level)>0){ret=true}
				if (Vault.retrieveValue("score_"+level)>Vault.retrieveValue("score") || Vault.retrieveValue("score_"+level)==0){
					Vault.setValue("score_"+level, Vault.retrieveValue("score"))
				}
				Vault.saveVault()
			}
			Clear()
			if (_gamefield.contains(bgFader)){_gamefield.removeChild(bgFader)}
			if (_gamefield.contains(layerParallax)){_gamefield.removeChild(layerParallax)}
			if (_gamefield.contains(layerBackground)){_gamefield.removeChild(layerBackground)}
			if (_gamefield.contains(layerObjects)){_gamefield.removeChild(layerObjects)}
			if (_gamefield.contains(layerEnemies)){_gamefield.removeChild(layerEnemies)}
			if (_gamefield.contains(layerTiles)){_gamefield.removeChild(layerTiles)}
			if (_gamefield.contains(layerForeground)){_gamefield.removeChild(layerForeground)}
			if (_gamefield.currentFrame==43 || bgFaderTo==1 || ret){
				if (_gamefield.currentFrame==43){Engine.finish=Math.max(Engine.finish, 1)}
				_gamefield.gotoAndStop(3)
			} else {
				_gamefield.gotoAndStop(_gamefield.currentFrame+2)
				level++
			}
		}
		/*Clear - This function removes all graphics, objects and enemies from the layers and level,
		but it DOES NOT remove layers from display
		*/
		public static function Clear():void{
			if (!_initialized){throw new Error("Engine.Clear() called before Initializing the engine.")}
			//Empty the Level array
			for (var i:uint=0;i<Settings.LEVEL_WIDTH;i++){
				for (var j:uint=0;j<Settings.LEVEL_HEIGHT;j++){
					_level[i][j]=null
				}
			}
			player=null
			//Empty the Lists
			while (listEnemies.length>0){listEnemies.pop()}
			while (listObjects.length>0){listObjects.pop()}

			//Empty the Layers
			while (layerParallax.numChildren>0){layerParallax.removeChildAt(0)}
			while (layerBackground.numChildren>0){layerBackground.removeChildAt(0)}
			while (layerObjects.numChildren>0){layerObjects.removeChildAt(0)}
			while (layerEnemies.numChildren>0){layerEnemies.removeChildAt(0)}
			while (layerTiles.numChildren>0){layerTiles.removeChildAt(0)}
			while (layerForeground.numChildren>0){layerForeground.removeChildAt(0)}
			//while (layerHud.numChildren>0){layerHud.removeChildAt(0)}
		}
		/*Call this if player screwed something and you feel like restarting the level
		*/
		public static function RestartLevel():void{
			started=0
			Vault.setValue("score", 1000)
			var i:uint
			for (i=0; i<listObjects.length; i++){
				listObjects[i].Reappear()
			}
			for (i=0; i<listEnemies.length; i++){
				listEnemies[i].Reappear()
			}
		}
		/*getTileGrid() - This function returns the tile lying on the (x,y) position in the level array.
		*/
		public static function getTileGrid(x:int, y:int):TTile{
			DebugDraw.Rect(x*25,y*25,25,25)
			if (x<0 || y<0 || x>=Settings.LEVEL_WIDTH || y>=Settings.LEVEL_HEIGHT){
				return null
			} else {
				return _level[x][y]
			}
		}
		/*getTileFree() - This function returns the tile lying on the (x,y) position in the level array,
		however x and y are first divided by tile dimensions and then rounded down.
		*/
		public static function getTileFree(x:Number,y:Number):TTile{
			x=Math.floor(x/Settings.TILE_WIDTH)
			y=Math.floor(y/Settings.TILE_HEIGHT)
			DebugDraw.Rect(x*25,y*25,25,25)
			if (x<0 || y<0 || x>=Settings.LEVEL_WIDTH || y>=Settings.LEVEL_HEIGHT){
				return null
			} else {
				return _level[x][y]
			}
		}
		/*tileSet() - This function places the tile in the (x,y) positon in the level array,
		however x and y are first divided by tile dimensions and then rounded down.
		*/
		public static function tileSet(x:Number,y:Number,t:TTile):void{
			x=Math.floor(x/Settings.TILE_WIDTH)
			y=Math.floor(y/Settings.TILE_HEIGHT)
			if (x<0 || y<0 || x>=Settings.LEVEL_WIDTH || y>=Settings.LEVEL_HEIGHT){
				return
			} else {
				_level[x][y]=t
			}
		}
		/*This one removes tiles from the grid, the Grid/Free rule remains.
		*/
		public static function removeTileGrid(x:int, y:int):void{
			if (x<0 || y<0 || x>=Settings.LEVEL_WIDTH || y>=Settings.LEVEL_HEIGHT){
				return
			} else {
				_level[x][y]=null
			}
		}
		/*So does it, the Grid/Free rule remains.
		*/
		public static function removeTileFree(x:int, y:int):void{
			x=Math.floor(x/Settings.TILE_WIDTH)
			y=Math.floor(y/Settings.TILE_HEIGHT)
			if (x<0 || y<0 || x>=Settings.LEVEL_WIDTH || y>=Settings.LEVEL_HEIGHT){
				return
			} else {
				_level[x][y]=null
			}
		}
		/*Removes object o from the objects list
		*/
		public static function removeObject(o:*):void{
			listObjects.splice(listObjects.indexOf(o),1)
		}
		/*Removes enemy o from the enemies list
		*/
		public static function removeEnemy(o:TEnemy):void{
			var id:uint=listEnemies.indexOf(o)
			if (id<=_checkedEnemy){_checkedEnemy--}
			listEnemies.splice(id,1)
		}
		/*Removes object from the id position in the objects list, does not check for mistakes
		*/
		public static function removeObjectAt(id:uint):void{
			listObjects.splice(id,1)
		}
		/*Removes enemy from the id position in the enemies list, does not check for mistakes
		*/
		public static function removeEnemyAt(id:uint):void{
			if (id<=_checkedEnemy){_checkedEnemy--}
			listEnemies.splice(id,1)
		}
		public static function gotCoin():void{
			Vault.setValue("score", Vault.retrieveValue("score")-11)
		}
	}

}