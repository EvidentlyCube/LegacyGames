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
	import com.mauft.PlatformerEngine.objects.*;
	import com.mauft.PlatformerEngine.objects.enemies.*;
	import com.mauft.PlatformerEngine.objects.objects.*;
	import com.mauft.PlatformerEngine.tiles.*;

	import flash.display.*;
	import flash.errors.*;
	import flash.events.*;
	import flash.geom.*;
	public class Engine{
		private static var _initialized:Boolean=false				//Just to make some major functions clean
		private static var _stage:Stage								//This is where the link to Stage is held
		private static var _gamefield:MovieClip						//And here we store the link to the main playfield
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

		public static var scrollLocked:Boolean=false					//Is the scrolling locked right now?
		public static var scrollX:Number=0							//The current X scroll
		public static var scrollY:Number=0							//The current Y scroll
		public static var scrollHorizontal:Boolean=false				//Shall we scroll horizontally?
		public static var scrollVertical:Boolean=false				//Shall we scroll vertically?
		public static var cappingTop:Boolean=false					//Should the scrolling stop when top of the level is seen, or should it go beyond?
		public static var cappingLeft:Boolean=true					//-------------||------------
		public static var cappingBottom:Boolean=true					//-------------||------------
		public static var paddingLeft:int=0							//-vv-
		public static var paddingTop:int=0							//Padding of scrolling, check to see how it works more exactly
		public static var paddingBottom:int=0							//-^^-

		public static var sectors:Array=new Array(25)

		public static var damageTaken:uint=0
		public static var coinsCollected:uint=0
		public static var enemyPoints:uint=0

		public static var ending:Boolean=false
		//This is used when iterating through enemies array, to avoid situation when one enemy removes other and some other enemy is skipped because of that
		private static var _checkedEnemy:int=0
		private static var _restartLevel:Boolean=false				//Are we restarting the level at the beginning of next step?

		/*Init - probably the most important method, it actually initializes the whole thing!
		You usually call it like that, in the first line of the first frame of the main timeline:
		Init(stage, this)
		*/
		public static function Init(s:Stage, gf:MovieClip):void{
			if (_initialized){return}							//We aren't evil enough to report an error on double-initialization
			DebugDraw.Init(s)									//Here we initialize the debugging object
			_initialized=true									//Set the flag to true so we know we called it before
			_stage=s											//Store the stage
			_gamefield=gf										//Store the main gamefield

			//Generating the empty Level Array
			_level=new Array(Settings.LEVEL_WIDTH)
			for (var i:uint=0;i<Settings.LEVEL_WIDTH;i++){
				_level[i]=new Array(Settings.LEVEL_HEIGHT)
			}

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

			for (i=0;i<25;i++){
				sectors[i]=new Array()
			}
		}
		/*This function is attached to the ENTER_FRAME event, and thus is called every step.
		*/
		public static function Step(e:Event):void{
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
			return; // Return early because it breaks ModernDisplay functionalities
			scrollX=-Math.floor(player.x/Settings.SCREEN_WIDTH)*Settings.SCREEN_WIDTH
			scrollY=-Math.floor(player.y/Settings.SCREEN_HEIGHT)*Settings.SCREEN_HEIGHT

			layerBackground.x=layerForeground.x=layerEnemies.x=layerObjects.x=layerTiles.x=_gamefield.x=scrollX
			layerBackground.y=layerForeground.y=layerEnemies.y=layerObjects.y=layerTiles.y=_gamefield.y=scrollY
		}
		public static function setSector(s:uint):void{
			for (var i:uint=0;i<sectors[s].length;i++){
				layerTiles.addChild(sectors[s][i])
			}
		}
		public static function foldSector(s:uint):void{
			var g:DisplayObject
			for (var i:uint=0;i<sectors[s].length;i++){
				g=sectors[s][i]
				g.parent.removeChild(g)
			}
		}
		public static function fillSector(_d:DisplayObject,_s:uint):void{
			if (_s<0 || _s>24){return}
			sectors[_s].push(_d)
		}
		/*StartLevel - You HAVE! to call this function, to make EVERYTHING appear on the screen (unless you screwed something on
		the playfield, then I guess you WILL see SOMETHING).
		It performs some basic level-initialization stuff, adding layers to stage, unlocking and resetting scrolling
		*/
		public static function StartLevel():void{
			_gamefield.addChild(layerParallax)
			_gamefield.addChild(layerBackground)
			_gamefield.addChild(layerTiles)
			_gamefield.addChild(layerEnemies)
			_gamefield.addChild(layerObjects)
			_gamefield.addChild(layerForeground)
			scrollLocked=false
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
			if (_gamefield.contains(layerParallax)){_gamefield.removeChild(layerParallax)}
			if (_gamefield.contains(layerBackground)){_gamefield.removeChild(layerBackground)}
			if (_gamefield.contains(layerObjects)){_gamefield.removeChild(layerObjects)}
			if (_gamefield.contains(layerEnemies)){_gamefield.removeChild(layerEnemies)}
			if (_gamefield.contains(layerTiles)){_gamefield.removeChild(layerTiles)}
			if (_gamefield.contains(layerForeground)){_gamefield.removeChild(layerForeground)}
			for (var i:uint=0;i<25;i++){
				while (sectors[i].length>0){
					sectors[i].pop()
				}
			}
			_gamefield.gotoAndStop(_gamefield.currentFrame+1)
		}
		/*Player calls this automagically when he ends his infinite voyage during the "level completed" sequence. You won't probably need to call this much,
		perhaps only after killing some boss or so.
		*/
		public static function LevelCompleted():void{
			EndLevel()
			if (_gamefield.currentFrame==22){
				Clear()
				_gamefield.gotoAndStop(23)
			} else {
				_gamefield.gotoAndStop(_gamefield.currentFrame+1)
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

			for (i=0;i<25;i++){
				sectors[i]=new Array()
			}

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
			_restartLevel=true
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
		public static function gameOver():void{
			Clear()
			_gamefield.gotoAndStop(3)

		}
	}

}