package
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.Matrix;
   import flash.net.SharedObject;
   import flash.ui.*;
   import mx.core.BitmapAsset;
   import objects.*;
   import objects.levelMakes.MakeLevel;

   public class Mario extends Sprite
   {
		public static var cheatGuard:Boolean = false;

      public static var instEnemies:Array = new Array();

      public static var Waiter:WaitScreen;

      public static var playerControllable:Boolean = true;

      private static var headbuttDistance:uint = 999;

      public static var mox:Number;

      public static var moy:Number;

      public static var music:Boolean = true;

      public static var scrollEdge:int = 0;

      public static var scrollX:int = 0;

      private static var stompID:int = -1;

      public static var background:Shape = new Shape();

      public static var gradient:Shape = new Shape();

      public static var layerHide:Sprite = new Sprite();

      public static var sounds:Boolean = true;

      public static var self:Mario;

      public static var stepping:Boolean = true;

      public static var gravity:Number = 0.4;

      public static var decreaseStomp:uint = 0;

      private static var headbuttID:int = -1;

      public static var layerBack2:Sprite = new Sprite();

      public static var levelGenre:uint = 0;

      public static var checkPoint:uint = 1;

      public static var decreaseI:uint = 0;

      public static var instBlocks:Array = new Array();

      private static var stompDistance:uint = 999;

      public static var layerEffects:Sprite = new Sprite();

      public static var level:Array = new Array();

      public static var layerPipe:Sprite = new Sprite();

      public static var layerFore:Sprite = new Sprite();

      public static var levelWid:uint;

      private static var keysDown:Array = [false,false,false,false,false,false,false,false];

      public static var levelid:uint = 12;

      public static var layerWall:Sprite = new Sprite();

      public static var sequence:uint = 11;

      public static var Logo1:Logoobj;

      public static var radishNO:uint = 0;

      public static var musika:uint;

      public static var layerBack:Sprite = new Sprite();

      public static var Hud:TypeHud;

      public static var TScreen:TitleScreen;

      public static var classGFX:GFX;

      public static var instEffects:Array = new Array();

      public static var levelHei:uint;

      public static var layerGover:Sprite = new Sprite();

      public static var classSFX:SFX;

      public static var instObjects:Array = new Array();

      public static var scrolling:Boolean = true;

      public static var pause:Pauser;

      private static var keysHit:Array = [0,0,0,0,0,0,0,0];


      private var instPlayer:Player;

      public function Mario()
      {
         super();
         self = this;
         addEventListener(Event.ENTER_FRAME,MainGame);
         generateBackground(1);
         addChildAt(gradient,0);
         addChild(layerBack2);
         addChild(layerBack);
         addChild(layerPipe);
         addChild(layerHide);
         addChild(layerWall);
         addChild(layerFore);
         addChild(layerEffects);
         addChild(layerGover);
         MainGame(null);
         var _tile_:Sprite = new Sprite();
         _tile_.graphics.beginFill(16777215);
         _tile_.graphics.drawRect(0,0,400,375);
         this.mask = _tile_;
         this.addChild(_tile_);

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

      public static function togglePause() : void
      {
         if(sequence != 12 && sequence != 1 || musika == 13 || GameOver.isGO)
         {
            return;
         }
         if(pause == null)
         {
            sequence = 12;
            pause = new Pauser();
         }
         else
         {
            sequence = 1;
            pause.kill();
            pause = null;
         }
      }

      public static function toggleSound() : void
      {
         if(sounds == true)
         {
            sounds = false;
         }
         else
         {
            sounds = true;
         }
      }

      public static function playerCollide(param1:uint, param2:uint, param3:uint, param4:uint) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(playerControllable)
         {
            _loc5_ = Player.pX - param1;
            _loc6_ = Player.pY - param2;
            if(_loc5_ < param3 && _loc5_ > -Player.pWid && _loc6_ < param4 && _loc6_ > -Player.pHei)
            {
               return true;
            }
         }
         return false;
      }

      public static function isKeyDown(param1:uint) : Boolean
      {
         return keysDown[param1];
      }

      public static function centerScreen(param1:int) : void
      {
         scrollX = Math.min(200 - param1,-scrollEdge);
         layerBack.x = scrollX;
         layerHide.x = scrollX;
         layerWall.x = scrollX;
         layerFore.x = scrollX;
         layerEffects.x = scrollX;
         var _tileY:int = int(instEffects.length - 1);
         while(_tileY >= 0)
         {
            if(instEffects[_tileY] is Background)
            {
               instEffects[_tileY].Reset(param1);
            }
            _tileY--;
         }
      }

      public static function Collide(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint, param8:uint) : Boolean
      {
         var _loc9_:int = param5 - param1;
         var _loc10_:int = param6 - param2;
         if(_loc9_ < param3 && _loc9_ > -param7 && _loc10_ < param4 && _loc10_ > -param8)
         {
            return true;
         }
         return false;
      }

      public static function toggleMusic() : void
      {
         if(music == true)
         {
            music = false;
         }
         else
         {
            music = true;
         }
         if(music == false)
         {
            classSFX.Play();
         }
         else if(sequence == 4)
         {
            classSFX.Play(6);
         }
         else if(Player.starred > 0)
         {
            classSFX.Play(3);
         }
         else if(sequence == 1)
         {
            if(musika != 13)
            {
               classSFX.Play(musika);
            }
         }
      }

      public static function enemyBounce(param1:uint, param2:int, param3:int, param4:uint, param5:uint) : Boolean
      {
         var _loc6_:int = int(instEnemies.length - 1);
         while(_loc6_ >= 0)
         {
            if(_loc6_ != param1 && instEnemies[_loc6_].bounce == true && Mario.Collide(param2,param3,param4,param5,instEnemies[_loc6_].eX,instEnemies[_loc6_].eY,instEnemies[_loc6_].eWid,instEnemies[_loc6_].eHei))
            {
               return true;
            }
            _loc6_--;
         }
         return false;
      }

      public static function enemyStarHit(param1:int, param2:int, param3:uint, param4:uint, param5:int) : void
      {
         var _loc7_:Enemy = null;
         var _loc6_:int = int(instEnemies.length - 1);
         while(_loc6_ >= 0)
         {
            if(Mario.Collide(param1,param2,param3,param4,instEnemies[_loc6_].eX,instEnemies[_loc6_].eY,instEnemies[_loc6_].eWid,instEnemies[_loc6_].eHei))
            {
               if((_loc7_ = instEnemies[_loc6_]).Fire(_loc6_,param5))
               {
                  if(Mario.sounds)
                  {
                     _loc7_.SFXKick.play();
                  }
                  Mario.instEffects.push(new Points(param1,param2,"200"));
               }
            }
            _loc6_--;
         }
      }

      public static function removeEffect(param1:uint) : void
      {
         Mario.instEffects.splice(param1,1);
      }

      public static function enemyHitFireball(param1:int, param2:int, param3:uint, param4:uint, param5:int) : Boolean
      {
         var _loc6_:int = int(instEnemies.length - 1);
         while(_loc6_ >= 0)
         {
            if(Mario.Collide(param1,param2,param3,param4,instEnemies[_loc6_].eX,instEnemies[_loc6_].eY,instEnemies[_loc6_].eWid,instEnemies[_loc6_].eHei))
            {
               if(instEnemies[_loc6_].FireballHit(_loc6_,param5))
               {
                  return true;
               }
            }
            _loc6_--;
         }
         return false;
      }

      public static function clearLevel(param1:Boolean = true) : void
      {
         var _tileY:SharedObject = null;
         var _tileX:uint = 0;
         stepping = false;
         instEnemies = new Array();
         instEffects = new Array();
         instObjects = new Array();
         instBlocks = new Array();
         while(layerBack.numChildren > 0)
         {
            layerBack.removeChildAt(0);
         }
         while(layerFore.numChildren > 0)
         {
            layerFore.removeChildAt(0);
         }
         while(layerHide.numChildren > 0)
         {
            layerHide.removeChildAt(0);
         }
         while(layerWall.numChildren > 0)
         {
            layerWall.removeChildAt(0);
         }
         while(layerBack2.numChildren > 0)
         {
            layerBack2.removeChildAt(0);
         }
         while(layerEffects.numChildren > 0)
         {
            layerEffects.removeChildAt(0);
         }
         while(layerGover.numChildren > 0)
         {
            layerGover.removeChildAt(0);
         }
         Player.starred = 0;
         Player.shield = 0;
         if(param1)
         {
            _tileY = SharedObject.getLocal("MarioForeverFlash");
            _tileX = Math.floor(levelid / 4) * 4;
            _tileY.data.level = _tileX;
            _tileY.flush(128);
            playerControllable = true;
            scrolling = true;
            scrollEdge = 0;
            MakeLevel(levelid);
         }
      }

      public static function hitPlayer(param1:Boolean = false, isPitOrTimeout:Boolean = false) : void
      {
         if (cheatGuard && !isPitOrTimeout) {
				return;
			}

         if(Player.shield == 0 && Player.sequence == 0 && Player.starred == 0 || param1)
         {
            if(Player.pSize > 0)
            {
               if(Player.pSize == 1)
               {
                  Player.sequence = 2;
               }
               else
               {
                  Player.sequence = -2;
               }
               Player.pSize = 0;
               Player.sequenceFrame = 60;
               Player.shield = 100;
               if(param1)
               {
                  Player.sequence = 0;
                  Player.sequenceFrame = 0;
                  Player.shield = 0;
                  Mario.instEffects.push(new DeadMario(Player.pX,Player.pY - 21));
                  playerControllable = false;
                  layerFore.removeChild(Player.GFX2);
                  if(scrolling)
                  {
                     scrollX = Math.min(200 - Player.pX,-scrollEdge);
                     layerBack.x = scrollX;
                     layerHide.x = scrollX;
                     layerWall.x = scrollX;
                     layerFore.x = scrollX;
                     layerEffects.x = scrollX;
                  }
                  Mario.classSFX.Play(-1);
                  if(Mario.sounds)
                  {
                     Player.SFXDeath.play();
                  }
               }
               else if(Mario.sounds)
               {
                  Player.SFXPowerdown.play();
               }
            }
            else
            {
               Mario.instEffects.push(new DeadMario(Player.pX,Player.pY - 21));
               playerControllable = false;
               layerFore.removeChild(Player.GFX2);
               if(scrolling)
               {
                  scrollX = Math.min(200 - Player.pX,-scrollEdge);
                  layerBack.x = scrollX;
                  layerHide.x = scrollX;
                  layerWall.x = scrollX;
                  layerFore.x = scrollX;
                  layerEffects.x = scrollX;
               }
               Mario.classSFX.Play(-1);
               if(Mario.sounds)
               {
                  Player.SFXDeath.play();
               }
            }
         }
      }

      public static function removeEnemy(param1:uint) : void
      {
         if(param1 < stompID)
         {
            --stompID;
         }
         Mario.instEnemies.splice(param1,1);
      }

      public static function removeBlock(param1:uint) : void
      {
         Mario.instBlocks.splice(param1,1);
      }

      public static function stompSetDistance(param1:uint, param2:int) : void
      {
         if(Math.abs(param2 - Player.pX) < Mario.stompDistance)
         {
            Mario.stompID = param1;
            Mario.stompDistance = Math.abs(param2 - Player.pX);
         }
      }

      public static function givePointShell(param1:uint) : String
      {
         switch(param1)
         {
            case 0:
               return "100";
            case 1:
               return "200";
            case 2:
               return "500";
            case 3:
               return "1000";
            case 4:
               return "2000";
            case 5:
               return "5000";
            case 6:
               return "8000";
            case 7:
               return "1up";
            default:
               return "100";
         }
      }

      public static function generateBackground(param1:uint) : void
      {
         var _tileY:String = null;
         var _loc7_:String = null;
         gradient.graphics.clear();
         var _tileX:Array = new Array(2);
         var _loc4_:Array = new Array(2);
         var _loc5_:Array = new Array(2);
         var _loc6_:Matrix = new Matrix();
         switch(param1)
         {
            case 0:
               _tileY = GradientType.LINEAR;
               _tileX = [8349395,6663157,16777215];
               _loc4_ = [100,100,100];
               _loc5_ = [0,78,231];
               (_loc6_ = new Matrix()).createGradientBox(400,375,Math.PI / 2);
               _loc7_ = SpreadMethod.PAD;
               gradient.graphics.beginGradientFill(_tileY,_tileX,_loc4_,_loc5_,_loc6_,_loc7_);
               gradient.graphics.drawRect(0,0,400,375);
               break;
            case 1:
               _tileY = GradientType.LINEAR;
               _tileX = [2113648,1122626];
               _loc4_ = [100,100];
               _loc5_ = [60,120];
               (_loc6_ = new Matrix()).createGradientBox(400,375,Math.PI / 2);
               _loc7_ = SpreadMethod.PAD;
               gradient.graphics.beginGradientFill(_tileY,_tileX,_loc4_,_loc5_,_loc6_,_loc7_);
               gradient.graphics.drawRect(0,0,400,375);
         }
      }

      public static function headbuttSetDistance(param1:uint, param2:int) : void
      {
         if(Math.abs(param2 - Player.pX) < Mario.headbuttDistance)
         {
            Mario.headbuttID = param1;
            Mario.headbuttDistance = Math.abs(param2 - Player.pX);
         }
      }

      public static function isKeyPressed(param1:uint) : Boolean
      {
         if(keysHit[param1] == 1)
         {
            return true;
         }
         return false;
      }

      public static function levelColl(param1:Number, param2:Number) : Boolean
      {
         if(param1 < scrollEdge)
         {
            return true;
         }
         param1 = Math.floor(param1 / 25);
         param2 = Math.floor(param2 / 25);
         if(param1 < Mario.levelWid && param1 > -1 && param2 < Mario.levelHei && param2 > -1)
         {
            if(Mario.level[param2].charAt(param1) == "x")
            {
               return true;
            }
         }
         return false;
      }

      public static function drawLevel() : void
      {
         var _tile_:BitmapAsset = null;
         var _tileX:uint = 0;
         var _tileY:uint = 0;
         while(_tileY < Mario.levelHei)
         {
            _tileX = 0;
            while(_tileX < Mario.levelWid)
            {
               switch(Mario.level[_tileY].charAt(_tileX))
               {
                  case " ":
                     break;
                  case "q":
                  case "r":
                  case "s":
                     _tile_ = new (Mario.classGFX.AccessGFX("Wall_" + Mario.level[_tileY].charAt(_tileX)))();
                     _tile_.x = _tileX * 25;
                     _tile_.y = _tileY * 25;
                     Mario.layerHide.addChild(_tile_);
                     changeLevel(_tileX,_tileY," ");
                     break;
                  default:
                     _tile_ = new (Mario.classGFX.AccessGFX("Wall_" + Mario.level[_tileY].charAt(_tileX)))();
                     _tile_.x = _tileX * 25;
                     _tile_.y = _tileY * 25;
                     Mario.layerWall.addChild(_tile_);
                     changeLevel(_tileX,_tileY,"x");
                     break;
               }
               _tileX++;
            }
            _tileY++;
         }
      }

      public static function changeLevel(param1:uint, param2:uint, param3:String) : void
      {
         Mario.level[param2] = Mario.level[param2].substr(0,param1) + param3 + Mario.level[param2].substr(param1 + 1);
      }

      public static function playerBonus(param1:uint) : void
      {
         Player.pSize = 1;
         Player.sequence = 1;
         Player.sequenceFrame = 60;
         if(Mario.sounds)
         {
            Player.SFXPowerup.play();
         }
      }

      public static function Sign(param1:Number) : int
      {
         if(param1 > 0)
         {
            return 1;
         }
         if(param1 < 0)
         {
            return -1;
         }
         return 0;
      }

      public static function enemyShellHit(param1:int, param2:int, param3:int, param4:uint, param5:uint, param6:int) : int
      {
         var _loc10_:Enemy = null;
         var _loc7_:int = 0;
         var _loc8_:int = 1;
         var _loc9_:int = int(instEnemies.length - 1);
         while(_loc9_ >= 0)
         {
            if(_loc9_ != param1 && Mario.Collide(param2,param3,param4,param5,instEnemies[_loc9_].eX,instEnemies[_loc9_].eY,instEnemies[_loc9_].eWid,instEnemies[_loc9_].eHei))
            {
               if(_loc9_ < param1)
               {
                  ++Mario.decreaseI;
               }
               if(stompID < param1)
               {
                  ++Mario.decreaseStomp;
               }
               if(_loc9_ < Mario.stompID)
               {
                  --Mario.stompID;
               }
               if(instEnemies[_loc9_].isShell)
               {
                  _loc8_ = -1;
               }
               if((_loc10_ = instEnemies[_loc9_]).Fire(_loc9_,param6))
               {
                  if(Mario.sounds)
                  {
                     _loc10_.SFXKick.play();
                  }
               }
               _loc7_++;
            }
            _loc9_--;
         }
         return _loc7_ * _loc8_;
      }

      public static function removeObject(param1:uint) : void
      {
         Mario.instObjects.splice(param1,1);
      }

      public function waitScreen() : void
      {
         switch(Waiter.update())
         {
            case 0:
               addChildAt(Waiter.GFX,this.numChildren - 1);
               break;
            case 2:
               removeChild(Waiter.GFX);
               sequence = 1;
         }
         layerBack.x = 0;
         layerHide.x = 0;
         layerWall.x = 0;
         layerFore.x = 0;
      }

      public function Logo() : void
      {
         if(Logo1.a == 0)
         {
            layerGover.addChild(Logo1);
         }
         Logo1.Step();
         if(Logo1.a > 10)
         {
            layerGover.removeChild(Logo1);
            Logo1 = new Logoobj();
            sequence = 4;
         }
      }

      public function ingameStep() : void
      {
         var _tile_:int = 0;
         Hud.Update();
         if(playerControllable)
         {
            instPlayer.Update();
         }
         stompDistance = 99;
         stompID = -1;
         _tile_ = int(instEnemies.length - 1);
         while(_tile_ >= 0)
         {
            instEnemies[_tile_].Update(_tile_);
            _tile_ -= decreaseI;
            stompID -= decreaseStomp;
            decreaseI = 0;
            decreaseStomp = 0;
            _tile_--;
         }
         if(Mario.stompID > -1)
         {
            instEnemies[stompID].Stomp(stompID);
         }
         headbuttID = -1;
         headbuttDistance = 99;
         _tile_ = int(instBlocks.length - 1);
         while(_tile_ >= 0)
         {
            instBlocks[_tile_].Update(_tile_);
            _tile_--;
         }
         if(Mario.headbuttID > -1)
         {
            instBlocks[headbuttID].Headbutt(headbuttID);
         }
         _tile_ = int(instObjects.length - 1);
         while(_tile_ >= 0)
         {
            instObjects[_tile_].Update(_tile_);
            if(decreaseI == 1)
            {
               decreaseI = 0;
               return;
            }
            _tile_--;
         }
         _tile_ = int(instEffects.length - 1);
         while(_tile_ >= 0)
         {
            instEffects[_tile_].Update(_tile_);
            if(decreaseI == 1)
            {
               decreaseI = 0;
               break;
            }
            _tile_--;
         }
         keyHitReset();
         Player.Reset();
         if(playerControllable && scrolling)
         {
            scrollX = Math.min(200 - Player.pX,-scrollEdge);
            layerBack.x = scrollX;
            layerHide.x = scrollX;
            layerWall.x = scrollX;
            layerFore.x = scrollX;
            layerEffects.x = scrollX;
         }
      }

      public function keyDown(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case Keyboard.RIGHT:
               if(keysHit[0] == 0)
               {
                  keysHit[0] = 1;
               }
               keysDown[0] = true;
               break;
            case Keyboard.DOWN:
               keysDown[1] = true;
               if(keysHit[1] == 0)
               {
                  keysHit[1] = 1;
               }
               break;
            case Keyboard.LEFT:
               keysDown[2] = true;
               if(keysHit[2] == 0)
               {
                  keysHit[2] = 1;
               }
               break;
            case Keyboard.UP:
               keysDown[3] = true;
               if(keysHit[3] == 0)
               {
                  keysHit[3] = 1;
               }
               break;
            case 90:
               keysDown[4] = true;
               if(keysHit[4] == 0)
               {
                  keysHit[4] = 1;
               }
               break;
            case 88:
               keysDown[5] = true;
               if(keysHit[5] == 0)
               {
                  keysHit[5] = 1;
               }
               break;
            case Keyboard.ENTER:
               keysDown[6] = true;
               if(keysHit[6] == 0)
               {
                  keysHit[6] = 1;
               }
               break;
            case Keyboard.SPACE:
               keysDown[7] = true;
               if(keysHit[7] == 0)
               {
                  keysHit[7] = 1;
               }
               break;
            case Keyboard.ESCAPE:
               togglePause();
               break;
            case 83:
               if(!GameOver.isGO)
               {
                  toggleSound();
               }
               break;
            case 77:
               if(!GameOver.isGO)
               {
                  toggleMusic();
               }
         }
      }

      public function keyUp(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case Keyboard.RIGHT:
               keysDown[0] = false;
               if(keysHit[0] > 0)
               {
                  keysHit[0] = 0;
               }
               break;
            case Keyboard.DOWN:
               keysDown[1] = false;
               if(keysHit[1] > 0)
               {
                  keysHit[1] = 0;
               }
               break;
            case Keyboard.LEFT:
               keysDown[2] = false;
               if(keysHit[2] > 0)
               {
                  keysHit[2] = 0;
               }
               break;
            case Keyboard.UP:
               keysDown[3] = false;
               if(keysHit[3] > 0)
               {
                  keysHit[3] = 0;
               }
               break;
            case 90:
               keysDown[4] = false;
               if(keysHit[4] > 0)
               {
                  keysHit[4] = 0;
               }
               break;
            case 88:
               keysDown[5] = false;
               if(keysHit[5] > 0)
               {
                  keysHit[5] = 0;
               }
               break;
            case Keyboard.ENTER:
               keysDown[6] = false;
               if(keysHit[6] > 0)
               {
                  keysHit[6] = 0;
               }
               break;
            case Keyboard.SPACE:
               keysDown[7] = false;
               if(keysHit[7] > 0)
               {
                  keysHit[7] = 0;
               }
         }
      }

      public function TitScreen() : void
      {
         var _tile_:SharedObject = null;
         if(TScreen == null)
         {
            TScreen = new TitleScreen();
         }
         TScreen.Update();
         keyHitReset();
         if(TScreen.sel == 10)
         {
            Player.GFX2.alpha = 1;
            levelid = 0;
            Hud.Lives = 2;
            Mario.clearLevel();
            TScreen = null;
            Hud.GFX.alpha = 1;
            waitScreen();
         }
         else if(TScreen.sel == 11)
         {
            Player.GFX2.alpha = 1;
            _tile_ = SharedObject.getLocal("MarioForeverFlash");
            if(_tile_.data.level >= 12)
            {
               levelid = 12;
            }
            else if(_tile_.data.level >= 8)
            {
               levelid = 8;
            }
            else if(_tile_.data.level >= 4)
            {
               levelid = 4;
            }
            else
            {
               levelid = 0;
            }
            Hud.Lives = 2;
            Mario.clearLevel();
            TScreen = null;
            Hud.GFX.alpha = 1;
            waitScreen();
         }
      }

      private function MainGame(param1:Event) : void
      {
         mox = mouseX;
         moy = mouseY;
         if(stepping)
         {
            switch(sequence)
            {
               case 0:
                  waitScreen();
                  break;
               case 1:
                  ingameStep();
                  break;
               case 2:
                  Logo();
                  break;
               case 4:
                  TitScreen();
                  break;
               case 11:
                  classGFX = new GFX();
                  classSFX = new SFX();
                  instPlayer = new Player(25,200);
                  Waiter = new WaitScreen();
                  Logo1 = new Logoobj();
                  Player.GFX2.alpha = 0;
                  Hud = new TypeHud();
                  Hud.GFX.alpha = 0;
                  addChild(Hud.Hud());
                  sequence = 4;
                  break;
               case 12:
            }
         }
      }

      public function LogoZwei() : void
      {
         sequence = 4;
      }

      private function keyHitReset() : void
      {
         if(keysHit[0] == 1)
         {
            keysHit[0] = 2;
         }
         if(keysHit[1] == 1)
         {
            keysHit[1] = 2;
         }
         if(keysHit[2] == 1)
         {
            keysHit[2] = 2;
         }
         if(keysHit[3] == 1)
         {
            keysHit[3] = 2;
         }
         if(keysHit[4] == 1)
         {
            keysHit[4] = 2;
         }
         if(keysHit[5] == 1)
         {
            keysHit[5] = 2;
         }
         if(keysHit[6] == 1)
         {
            keysHit[6] = 2;
         }
         if(keysHit[7] == 1)
         {
            keysHit[7] = 2;
         }
      }
   }
}
