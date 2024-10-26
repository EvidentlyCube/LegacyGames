/**
* ...
* @author Maurice Zarzycki
* @version 0.1
*
*/

package {
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Matrix;
	import flash.net.SharedObject;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.ui.*;

	import mx.core.BitmapAsset;

	import objects.*;


	[Frame(factoryClass="objects.Loading")]


	public class Mario extends Sprite{
		public static var cheatGuard:Boolean = false;
		public static var layerBack:Sprite=new Sprite();
		public static var layerBack2:Sprite=new Sprite();
		public static var layerHide:Sprite=new Sprite();
		public static var layerWall:Sprite=new Sprite();
		public static var layerFore:Sprite=new Sprite();
		public static var layerPipe:Sprite=new Sprite();
		public static var layerGover:Sprite=new Sprite();
		public static var layerEffects:Sprite=new Sprite();
		public static var classGFX:GFX
		public static var classSFX:SFX
		public static var Hud:TypeHud;
		public static var Waiter:WaitScreen
		public static var Logo1:Logoobj
		public static var Log2:Logo2
		public static var pause:Pauser
		public static var TScreen:TitleScreen
		public static var gravity:Number=0.4;
		public static var level:Array = new Array();
		public static var levelWid:uint;
		public static var levelHei:uint;
		public static var levelid:uint=12;
		public static var levelGenre:uint=0;
		public static var background:Shape=new Shape();
		public static var decreaseI:uint=0;
		public static var decreaseStomp:uint=0;
		public static var playerControllable:Boolean=true;
		private static var stompDistance:uint=999;
		private static var stompID:int=-1;
		private static var headbuttDistance:uint=999;
		private static var headbuttID:int=-1;
		private var instPlayer:Player;
		public static var instEnemies:Array = new Array();
		public static var instBlocks:Array = new Array();
		public static var instObjects:Array = new Array();
		public static var instEffects:Array = new Array();
		public static var radishNO:uint=0;
		public static var sounds:Boolean=true;
		public static var music:Boolean=true;
		private static var keysDown:Array=[false,false,false,false,false,false,false,false];
		private static var keysHit:Array=[0, 0, 0, 0, 0, 0, 0, 0];
		public static var sequence:uint=11;
		public static var mox:Number;
		public static var moy:Number;
		public static var scrolling:Boolean=true;
		public static var gradient:Shape=new Shape();
		public static var scrollEdge:int=0
		public static var scrollX:int=0
		public static var stepping:Boolean=true
		public static var musika:uint
		public static var checkPoint:uint=1
		public static var self:Mario
		public function Mario():void{
			self=this
			addEventListener(Event.ENTER_FRAME,MainGame);
			generateBackground(1)
			addChildAt(gradient,0);
			addChild(layerBack2);
			addChild(layerBack);
			addChild(layerPipe)
			addChild(layerHide);
			addChild(layerWall);
			addChild(layerFore);
			addChild(layerEffects);
			addChild(layerGover);
			//MakeLevel(levelid);
			MainGame(null)
			var maskus:Sprite=new Sprite
			maskus.graphics.beginFill(0xFFFFFF)
			maskus.graphics.drawRect(0,0,400,375)
			this.mask=maskus
			this.addChild(maskus);

			CheatCodes.AddCheat('life', function(): void {
				if (Mario.playerControllable) {
					Mario.instEffects.push(new Points(Player.pX,Player.pY,"1up"));
					if (Mario.sounds){Hud.SFXLife.play();}
				}
			});
			CheatCodes.AddCheat('guard', function(): void {
				if (Mario.playerControllable) {
					if (cheatGuard) {
						cheatGuard = false;
						if (Mario.sounds){Player.SFXPowerdown.play();}
					} else {
						cheatGuard = true;
						if (Mario.sounds){Player.SFXPowerup.play();}
					}
				}
			});
			CheatCodes.AddCheat('goto', function(): void {
				if (Mario.playerControllable) {
					Mario.playerControllable=false;
					Mario.levelid++
					Mario.clearLevel();
				}
			});
		}
		private function MainGame(e:Event):void{

			mox=mouseX;
			moy=mouseY;
			if (stepping){
				switch (sequence){
					case(0):waitScreen();break;
					case(1):ingameStep();break;
					case(2):Logo();break;
					case(3):LogoZwei();break;
					case(4):TitScreen();break;
					case(11):
						classGFX=new GFX();
						classSFX=new SFX();
						instPlayer = new Player(25, 200);
						Waiter=new WaitScreen();
						Logo1=new Logoobj;
						Log2=new Logo2;
						Player.GFX2.alpha=0
						Hud=new TypeHud();
						Hud.GFX.alpha=0
						addChild(Hud.Hud());
						sequence=3;
						break;
					case(12):/*PAUSE*/break;
				}
			}

		}
		public function Logo():void{
			if (Logo1.a==0){
				layerGover.addChild(Logo1)
			}
			Logo1.Step()
			if (Logo1.a>10){
				layerGover.removeChild(Logo1)
				Logo1=new Logoobj
				sequence=4
				//Hud.GFX.alpha=1
				//Player.GFX2.alpha=1
				//MakeLevel(levelid)
			}
		}
		public function LogoZwei():void{
			if (Log2.timer==0){
				Player.GFX2.alpha=0
				layerGover.addChild(Log2.GFX)
			}
			Log2.Update()
			if (Log2.timer==200){
				layerGover.removeChild(Log2.GFX)
				sequence=4
				Log2=new Logo2
			}

		}
		public function TitScreen():void{
			if (TScreen==null){
				TScreen=new TitleScreen;
			}
			TScreen.Update()
			keyHitReset();
			if (TScreen.sel==10){
				Player.GFX2.alpha=1
				levelid=0;
				Hud.Lives=2
				Mario.clearLevel()
				TScreen=null
				Hud.GFX.alpha=1
				waitScreen()
			} else if (TScreen.sel==11){
				Player.GFX2.alpha=1
				var sharx:SharedObject=SharedObject.getLocal("MarioForeverFlash");
				if (sharx.data.level>=12){
					levelid=12
				} else if (sharx.data.level>=8){
					levelid=8
				} else if (sharx.data.level>=4){
					levelid=4
				} else {
					levelid=0
				}
				Hud.Lives=2
				Mario.clearLevel()
				TScreen=null
				Hud.GFX.alpha=1
				waitScreen()
			}
		}
		public function waitScreen():void{
			switch(Waiter.update()){
				case(0):addChildAt(Waiter.GFX,this.numChildren-1);break;
				case(2):removeChild(Waiter.GFX);sequence=1;break;
			}
			layerBack.x=0;
			layerHide.x=0;
			layerWall.x=0;
			layerFore.x=0;
		}
		public function ingameStep():void{
			Hud.Update();
			if (playerControllable){instPlayer.Update();}
			var i:int;
			stompDistance=99;
			stompID=-1;
			for (i=instEnemies.length-1;i>=0;i--){
				instEnemies[i].Update(i);
				i-=decreaseI;
				stompID-=decreaseStomp
				decreaseI=0;
				decreaseStomp=0;
			}
			if (Mario.stompID>-1){
				instEnemies[stompID].Stomp(stompID);
			}
			headbuttID=-1;
			headbuttDistance=99;
			for (i=instBlocks.length-1;i>=0;i--){
				instBlocks[i].Update(i);
			}
			if (Mario.headbuttID>-1){
				instBlocks[headbuttID].Headbutt(headbuttID);
			}
			for (i=instObjects.length-1;i>=0;i--){
				instObjects[i].Update(i);
				if (decreaseI==1){
					decreaseI=0
					return;
				}
			}
			for (i=instEffects.length-1;i>=0;i--){
				instEffects[i].Update(i);
				if (decreaseI==1){
					decreaseI=0
					break;
				}
			}
			keyHitReset();
			Player.Reset();
			if (playerControllable && scrolling){
				scrollX=Math.min(200-Player.pX,-scrollEdge)
				layerBack.x=scrollX
				layerHide.x=scrollX
				layerWall.x=scrollX
				layerFore.x=scrollX
				layerEffects.x=scrollX
			}
		}
		private function keyHitReset():void{
			if (keysHit[0]==1){keysHit[0]=2}
			if (keysHit[1]==1){keysHit[1]=2}
			if (keysHit[2]==1){keysHit[2]=2}
			if (keysHit[3]==1){keysHit[3]=2}
			if (keysHit[4]==1){keysHit[4]=2}
			if (keysHit[5]==1){keysHit[5]=2}
			if (keysHit[6]==1){keysHit[6]=2}
			if (keysHit[7]==1){keysHit[7]=2}
		}
		public function keyDown(e:KeyboardEvent):void{
			switch(e.keyCode){
				case Keyboard.RIGHT:
					keysDown[0]=true;
					if (keysHit[0]==0){keysHit[0]=1};
					break;
				case Keyboard.DOWN:
					keysDown[1]=true;
					if (keysHit[1]==0){keysHit[1]=1};
					break;
				case Keyboard.LEFT:
					keysDown[2]=true;
					if (keysHit[2]==0){keysHit[2]=1};
					break;
				case Keyboard.UP:
					keysDown[3]=true;
					if (keysHit[3]==0){keysHit[3]=1};
					break;
				case 90:
					keysDown[4]=true;
					if (keysHit[4]==0){keysHit[4]=1};
					break;
				case 88:
					keysDown[5]=true;
					if (keysHit[5]==0){keysHit[5]=1};
					break;
				case Keyboard.ENTER:
					keysDown[6]=true;
					if (keysHit[6]==0){keysHit[6]=1};
					break;
				case Keyboard.SPACE:
					keysDown[7]=true;
					if (keysHit[7]==0){keysHit[7]=1};
					break;
				case Keyboard.ESCAPE:
					togglePause();
					break;
				case 83:
				//case 115:
					if (!GameOver.isGO){toggleSound();}
					break;
				case 77:
				//case 109:
					if (!GameOver.isGO){toggleMusic();}
					break;
			}
		}
		public function keyUp(e:KeyboardEvent):void{
			switch(e.keyCode){
				case Keyboard.RIGHT:
					keysDown[0]=false;
					if (keysHit[0]>0){keysHit[0]=0}
					break;
				case Keyboard.DOWN:
					keysDown[1]=false;
					if (keysHit[1]>0){keysHit[1]=0}
					break;
				case Keyboard.LEFT:
					keysDown[2]=false;
					if (keysHit[2]>0){keysHit[2]=0}
					break;
				case Keyboard.UP:
					keysDown[3]=false;
					if (keysHit[3]>0){keysHit[3]=0}
					break;
				case 90:
					keysDown[4]=false;
					if (keysHit[4]>0){keysHit[4]=0}
					break;
				case 88:
					keysDown[5]=false;
					if (keysHit[5]>0){keysHit[5]=0}
					break;
				case Keyboard.ENTER:
					keysDown[6]=false;
					if (keysHit[6]>0){keysHit[6]=0}
					break;
				case Keyboard.SPACE:
					keysDown[7]=false;
					if (keysHit[7]>0){keysHit[7]=0}
					break;
			}
		}
		public static function isKeyDown(kCode:uint):Boolean{
			return keysDown[kCode];
		}
		public static function isKeyPressed(kCode:uint):Boolean{
			if (keysHit[kCode]==1){return true;} else {return false;}
		}
		public static function levelColl(iX:Number, iY:Number):Boolean{
			if (iX<scrollEdge){
				return true;
			}
			iX=Math.floor(iX/25)
			iY=Math.floor(iY/25)
			if (iX<Mario.levelWid && iX>-1 && iY<Mario.levelHei && iY>-1){
				if (Mario.level[iY].charAt(iX)=="x"){
					return true;
				}
			}
			return false;
		}
		public static function drawLevel():void{
			var GFX:BitmapAsset;
			for (var i:uint = 0; i < Mario.levelHei; i++) {
				for (var j:uint = 0; j < Mario.levelWid; j++) {
					switch(Mario.level[i].charAt(j)){
					case(" "):
						break;
					case("n"):
					case("o"):
					case("p"):
						GFX = new (Mario.classGFX.AccessGFX("Wall_"+Mario.level[i].charAt(j)));
						GFX.x=j*25;
						GFX.y=i*25;
						Mario.layerHide.addChild(GFX);

						changeLevel(j,i," ");
						break;
					default:
						GFX = new (Mario.classGFX.AccessGFX("Wall_"+Mario.level[i].charAt(j)));
						GFX.x=j*25;
						GFX.y=i*25;
						Mario.layerWall.addChild(GFX);

						changeLevel(j,i,"x");
						break;
					}
				}
			}
		}
		public static function Sign(variable:Number):int{
			if (variable>0){
				return 1;
			} else if (variable<0){
				return -1;
			} else {
				return 0;
			}
		}
		public static function Collide(x1:uint, y1:uint, wid1:uint, hei1:uint, x2:uint, y2:uint, wid2:uint, hei2:uint):Boolean{

			var tempX:int = x2-x1;
			var tempY:int = y2-y1;
			if (tempX<wid1 && tempX>-wid2 && tempY<hei1 && tempY>-hei2){
				return true;
			}
			return false;
		}
		public static function playerCollide(x1:uint, y1:uint, wid1:uint, hei1:uint):Boolean{
			if (playerControllable){
				var tempX:int = Player.pX-x1;
				var tempY:int = Player.pY-y1;
				if (tempX<wid1 && tempX>-Player.pWid && tempY<hei1 && tempY>-Player.pHei){
					return true;
				}
			}
			return false;
		}
		public static function changeLevel(xPosition:uint, yPosition:uint, newChar:String):void{
			Mario.level[yPosition]=Mario.level[yPosition].substr(0,xPosition)+newChar+Mario.level[yPosition].substr(xPosition+1);
		}
		public static function removeEnemy(enemyId:uint):void{
			if (enemyId<stompID){stompID--;}
			Mario.instEnemies.splice(enemyId, 1);
		}
		public static function removeObject(objectId:uint):void{
			Mario.instObjects.splice(objectId, 1);
		}
		public static function removeBlock(blockId:uint):void{
			Mario.instBlocks.splice(blockId, 1);
		}
		public static function removeEffect(effectId:uint):void{
			Mario.instEffects.splice(effectId, 1);
		}
		public static function enemyBounce(myID:uint, oX:int, oY:int, oWid:uint, oHei:uint):Boolean{
			//return false;
			for (var i:int=instEnemies.length-1;i>=0;i--){
				if (i != myID && instEnemies[i].bounce==true && Mario.Collide(oX, oY, oWid, oHei, instEnemies[i].eX, instEnemies[i].eY, instEnemies[i].eWid, instEnemies[i].eHei)){
					return true;
				}
			}
			return false;
		}
		public static function enemyHitFireball(oX:int, oY:int, oWid:uint, oHei:uint,dir:int):Boolean{
			for (var i:int=instEnemies.length-1;i>=0;i--){
				if (Mario.Collide(oX, oY, oWid, oHei, instEnemies[i].eX, instEnemies[i].eY, instEnemies[i].eWid, instEnemies[i].eHei)){
					if (instEnemies[i].FireballHit(i,dir)){return true;}
				}
			}
			return false;
		}
		public static function enemyStarHit(oX:int, oY:int, oWid:uint, oHei:uint,dir:int):void{
			for (var i:int=instEnemies.length-1;i>=0;i--){
				if (Mario.Collide(oX, oY, oWid, oHei, instEnemies[i].eX, instEnemies[i].eY, instEnemies[i].eWid, instEnemies[i].eHei)){
					var ins:Enemy=instEnemies[i]
					if (ins.Fire(i,dir)){
						if (Mario.sounds){ins.SFXKick.play();}
						Mario.instEffects.push(new Points(oX,oY,"200"))
					}
				}
			}
		}
		public static function enemyShellHit(myID:int, oX:int, oY:int, oWid:uint, oHei:uint,dir:int):int{
			var ret:int=0;
			var hit:int=1;
			for (var i:int=instEnemies.length-1;i>=0;i--){
				if (i != myID && Mario.Collide(oX, oY, oWid, oHei, instEnemies[i].eX, instEnemies[i].eY, instEnemies[i].eWid, instEnemies[i].eHei)) {
					if (i<myID){Mario.decreaseI++;}
					if (stompID<myID){Mario.decreaseStomp++;}
					if (i<Mario.stompID){Mario.stompID--;}
					if (instEnemies[i].isShell){
						hit=-1;
					}
					var ins:Enemy=instEnemies[i]
					if (ins.Fire(i,dir)){
						if (Mario.sounds){ins.SFXKick.play();}
					}

					ret++;
				}
			}
			return ret*hit;
		}
		public static function hitPlayer(permaDeath:Boolean=false, isPitOrTimeout:Boolean = false):void{
			if (cheatGuard && !isPitOrTimeout) {
				return;
			}

			if ((Player.shield==0 && Player.sequence==0 && Player.starred==0) || permaDeath){
				if (Player.pSize>0){
					if (Player.pSize==1){
						Player.sequence=2;
					} else {
						Player.sequence=-2;
					}
					Player.pSize=0;
					Player.sequenceFrame=60;
					Player.shield=100;
					if (permaDeath){
						Player.sequence=0;
						Player.sequenceFrame=0;
						Player.shield=0;
						Mario.instEffects.push(new DeadMario(Player.pX,Player.pY-21));
						playerControllable=false;
						layerFore.removeChild(Player.GFX2);
						if (scrolling){
							scrollX=Math.min(200-Player.pX,-scrollEdge)
							layerBack.x=scrollX;
							layerHide.x=scrollX
							layerWall.x=scrollX
							layerFore.x=scrollX
							layerEffects.x=scrollX
						}
						Mario.classSFX.Play(-1)
						if (Mario.sounds){Player.SFXDeath.play();}
					} else {
						if (Mario.sounds){Player.SFXPowerdown.play();}
					}
				} else {
					Mario.instEffects.push(new DeadMario(Player.pX,Player.pY-21));
					playerControllable=false;
					layerFore.removeChild(Player.GFX2);
					if (scrolling){
						scrollX=Math.min(200-Player.pX,-scrollEdge)
						layerBack.x=scrollX;
						layerHide.x=scrollX;
						layerWall.x=scrollX;
						layerFore.x=scrollX;
						layerEffects.x=scrollX;
					}
					Mario.classSFX.Play(-1)
					if (Mario.sounds){Player.SFXDeath.play();}
				}
			}
		}
		public static function playerBonus(type:uint):void{
			Player.pSize=1;
			Player.sequence=1;
			Player.sequenceFrame=60;
			if (Mario.sounds){Player.SFXPowerup.play();}
		}
		public static function stompSetDistance(enemyID:uint,eX:int):void{
			if (Math.abs(eX-Player.pX)<Mario.stompDistance){
				Mario.stompID=enemyID;
				Mario.stompDistance=Math.abs(eX-Player.pX);
			}
		}
		public static function headbuttSetDistance(objectID:uint,oX:int):void{
			if (Math.abs(oX-Player.pX)<Mario.headbuttDistance){
				Mario.headbuttID=objectID;
				Mario.headbuttDistance=Math.abs(oX-Player.pX);
			}
		}
		public static function givePointShell(numb:uint):String{
			switch(numb){
				case(0):return("100");
				case(1):return("200");
				case(2):return("500");
				case(3):return("1000");
				case(4):return("2000");
				case(5):return("5000");
				case(6):return("8000");
				case(7):return("1up");
			}
			return "100";
		}
		public static function generateBackground(dako:uint):void{
			gradient.graphics.clear()
			var fillType:String
			var colors:Array=new Array(2)
			var alphas:Array=new Array(2)
			var ratios:Array=new Array(2)
			var matr:Matrix = new Matrix()
			var spreadMethod:String
			switch (dako){
				case 0:
					fillType = GradientType.LINEAR;
					colors = [0x0099CC,0x11FFFF];
					alphas = [100, 100];
					ratios = [60, 120];
					matr = new Matrix();
					matr.createGradientBox(400,375,Math.PI/2);
					spreadMethod = SpreadMethod.PAD;
					gradient.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);
					gradient.graphics.drawRect(0,0,400,375);
					break;
				case 1:
					fillType = GradientType.LINEAR;
					colors = [0x204070,0x112142];
					alphas = [100, 100];
					ratios = [60, 120];
					matr = new Matrix();
					matr.createGradientBox(400,375,Math.PI/2);
					spreadMethod = SpreadMethod.PAD;
					gradient.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);
					gradient.graphics.drawRect(0,0,400,375);
					break;
			}
		}
		public static function clearLevel(make:Boolean=true):void{
			stepping=false
				instEnemies=new Array()
				instEffects=new Array();
				instObjects=new Array()
				instBlocks=new Array()
			while (layerBack.numChildren>0){
				layerBack.removeChildAt(0);
			}
			while (layerFore.numChildren>0){
				layerFore.removeChildAt(0);
			}
			while (layerHide.numChildren>0){
				layerHide.removeChildAt(0);
			}
			while (layerWall.numChildren>0){
				layerWall.removeChildAt(0);
			}
			while (layerBack2.numChildren>0){
				layerBack2.removeChildAt(0);
			}
			while (layerEffects.numChildren>0){
				layerEffects.removeChildAt(0);
			}
			while (layerGover.numChildren>0){
				layerGover.removeChildAt(0);
			}
			Player.starred=0
			Player.shield=0
			if (make){
				var sharx:SharedObject=SharedObject.getLocal("MarioForeverFlash")
				var lev:uint=Math.floor(levelid/4)*4
				sharx.data.level=lev
				sharx.flush(128)
				playerControllable=true;
				scrolling=true
				scrollEdge=0
				MakeLevel(levelid);
			}
		}
		public static function centerScreen(kX:int):void{
			scrollX=Math.min(200-kX,-scrollEdge)
			layerBack.x=scrollX;
			layerHide.x=scrollX;
			layerWall.x=scrollX;
			layerFore.x=scrollX;
			layerEffects.x=scrollX;
			for (var i:int=instEffects.length-1;i>=0;i--){
				if (instEffects[i] is Background){
					instEffects[i].Reset(kX);
				}
			}
		}
		public static function togglePause():void{
			if (sequence!=12 && sequence!=1 || musika==13 || GameOver.isGO){return;}
			if (pause==null){
				sequence=12;
				pause=new Pauser;
			} else {
				sequence=1;
				pause.kill();
				pause=null;
			}
		}
		public static function toggleSound():void{
			if (sounds==true){
				sounds=false;
			} else {
				sounds=true;
			}
		}
		public static function toggleMusic():void{
			if (music==true){
				music=false;
			} else {
				music=true;
			}
			if (music==false){
				classSFX.Play();
			} else {
				if (sequence==4){
					classSFX.Play(6);
				}else if (Player.starred>0){
					classSFX.Play(3);
				} else if (sequence==1){
					if (musika!=13){
						classSFX.Play(musika);
					}
				}
			}
		}
	}
}
