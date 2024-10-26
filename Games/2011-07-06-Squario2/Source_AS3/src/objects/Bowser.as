package objects
{
   import flash.media.Sound;

   public class Bowser extends Enemy
   {


      public var damageWait:uint = 0;

      public var hp:int;

      private var SFXRadish:Sound;

      public var hampau:uint;

      public var ham:uint;

      public var hammerer1:uint = 0;

      public var hammerer2:uint = 0;

      public var musicFundo:uint = 0;

      public var border:uint;

      public var action:uint = 0;

      private var SFXBump:Sound;

      public var firehp:uint = 6;

      public var fl:uint;

      public var scroll:uint = 0;

      public var moveTo:uint;

      private var SFXGrowl:Sound;

      public var hamno:uint;

      public var GFX:Array;

      public var frameTime:uint = 0;

      public var waiter:uint;

      private var SFXKill:Sound;

      public var moveWait:uint = 0;

      private var SFXStomp:Sound;

      public var frame:uint = 0;

      public function Bowser(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint, param8:uint)
      {
         GFX = new Array(15);
         SFXBump = new (Mario.classSFX.accessSFX("bump"))();
         SFXStomp = new (Mario.classSFX.accessSFX("bowser_hit"))();
         SFXGrowl = new (Mario.classSFX.accessSFX("growl"))();
         SFXKill = new (Mario.classSFX.accessSFX("bowser_kill"))();
         SFXRadish = new (Mario.classSFX.accessSFX("radish"))();
         super();
         GFX[0] = new (Mario.classGFX.AccessGFX("bowser_0"))();
         GFX[1] = new (Mario.classGFX.AccessGFX("bowser_1"))();
         GFX[2] = new (Mario.classGFX.AccessGFX("bowser_2"))();
         GFX[3] = new (Mario.classGFX.AccessGFX("bowser_3"))();
         GFX[4] = new (Mario.classGFX.AccessGFX("bowser_4"))();
         GFX[5] = new (Mario.classGFX.AccessGFX("bowser_5"))();
         GFX[6] = new (Mario.classGFX.AccessGFX("bowser_6"))();
         GFX[7] = new (Mario.classGFX.AccessGFX("bowser_7"))();
         GFX[8] = new (Mario.classGFX.AccessGFX("bowser_8"))();
         GFX[9] = new (Mario.classGFX.AccessGFX("bowser_9"))();
         GFX[10] = new (Mario.classGFX.AccessGFX("bowser_10"))();
         GFX[11] = new (Mario.classGFX.AccessGFX("bowser_11"))();
         GFX[12] = new (Mario.classGFX.AccessGFX("bowser_12"))();
         GFX[13] = new (Mario.classGFX.AccessGFX("bowser_13"))();
         GFX[14] = new (Mario.classGFX.AccessGFX("bowser_14"))();
         fl = param5;
         ham = param6;
         hamno = param7;
         hampau = param8;
         border = param3;
         moveTo = eX = param1;
         eWid = 40;
         eHei = 46;
         eY = param2;
         hp = param4;
         Mario.layerFore.addChild(GFX[frame]);
      }

      private function changeFrame(param1:uint) : void
      {
         Mario.layerFore.removeChild(GFX[frame]);
         frame = param1;
         Mario.layerFore.addChild(GFX[frame]);
      }

      override public function Stomp(param1:uint) : void
      {
         Player.Bounce(eY - 3);
         if(damageWait == 0)
         {
            --hp;
            damageWait = 120;
            firehp = 6;
            if(Mario.sounds)
            {
               SFXStomp.play();
            }
         }
      }

      private function gfxPosition() : void
      {
         dir = Player.pX > eX ? 1 : -1;
         GFX[frame].scaleX = dir;
         GFX[frame].x = eX - 5 + (dir == -1 ? 50 : 0);
         GFX[frame].y = eY - 10;
         GFX[frame].alpha = Math.abs(Math.cos(damageWait * Math.PI / 30));
      }

      override public function Fire(param1:uint, param2:int) : Boolean
      {
         return false;
      }

      override public function Update(param1:uint) : void
      {
         var _loc2_:Fireball = null;
         if(hp <= 0)
         {
            Mario.layerFore.removeChild(GFX[frame]);
            Mario.removeEnemy(param1);
            Mario.instEffects.push(new Enemy_Fall(eX - 5,eY - 10,dir,GFX[frame]));
            Mario.instObjects.push(new BowserKilled());
            if(Mario.sounds)
            {
               SFXKill.play();
            }
            Mario.classSFX.Play(-1);
            return;
         }
         if(musicFundo > 0)
         {
            ++musicFundo;
            Mario.checkPoint = Mario.levelid;
         }
         if(scroll == 0)
         {
            if(Player.pX > border - 200)
            {
               scroll = 1;
               if(Mario.music)
               {
                  musicFundo = 1;
                  Mario.classSFX.Play(5);
                  Mario.musika = 5;
               }
               Mario.scrollEdge = Player.pX - 200;
               Mario.centerScreen(Player.pX);
               Mario.scrolling = false;
            }
         }
         else if(scroll == 1)
         {
            if(Mario.scrollEdge < border)
            {
               ++Mario.scrollEdge;
               Mario.centerScreen(Mario.scrollEdge + 200);
               if(Player.pX + Math.round(Player.speed / 100) < Mario.scrollEdge + 2)
               {
                  Player.pX = Mario.scrollEdge + 2;
                  Player.speed = Math.max(0,Player.speed);
                  if(Mario.playerControllable && (Mario.levelColl(Player.pX + Player.pWid - 1,Player.pY) || Mario.levelColl(Player.pX + Player.pWid - 1,Player.pY + Player.pHei - 1)))
                  {
                     Mario.hitPlayer(true, true);
                  }
               }
            }
            else
            {
               scroll = 2;
            }
         }
         gravity += Mario.gravity / 3;
         eY += Math.round(gravity);
         if(gravity > 0)
         {
            if(Mario.levelColl(eX,eY + eHei - 1) || Mario.levelColl(eX + eWid - 1,eY + eHei - 1))
            {
               gravity = 0;
               eY = Math.floor(eY / 25) * 25 + 4;
               if(Math.random() < 0.05)
               {
                  gravity = (Mario.levelid == 16 ? -Math.random() * 3 : 0) - 2.5;
               }
            }
         }
         if(moveTo == eX)
         {
            if(Mario.levelid != 16 || Math.random() < 0.1)
            {
               moveTo = border + 25 + Math.floor(Math.random() * 310);
            }
         }
         else if(action == 0 || Mario.levelid == 16)
         {
            eX += Mario.Sign(moveTo - eX) * Math.min(2,Math.abs(moveTo - eX)) * (Mario.levelid == 16 ? 0.8 : 1);
         }
         if(Mario.playerCollide(eX,eY,eWid,eHei))
         {
            if(Player.pY - Player.gravity + Player.pHei <= eY + 5)
            {
               if(Player.hitStomp == false)
               {
                  Mario.stompSetDistance(param1,eX);
               }
            }
            else
            {
               Mario.hitPlayer();
            }
         }
         if(action == 0 || Mario.levelid == 16)
         {
            ++frameTime;
            if(frameTime > 2)
            {
               frameTime = 0;
               if(frame == 14)
               {
                  changeFrame(0);
               }
               else
               {
                  changeFrame(frame + 1);
               }
               if(action == 0 && Math.random() * 50 < fl + ham)
               {
                  if(Math.random() * fl >= Math.random() * ham)
                  {
                     action = 1;
                     waiter = 0;
                  }
                  else
                  {
                     action = 2;
                     waiter = 0;
                     hammerer1 = hamno;
                  }
               }
            }
         }
         if(action == 1)
         {
            if(waiter < 60)
            {
               ++waiter;
            }
            else if(waiter == 60)
            {
               ++waiter;
               if(Mario.sounds)
               {
                  SFXGrowl.play();
               }
               Mario.instEffects.push(new BowserFlame(eX + 5 + 20 * dir,eY + 10,dir,Player.pY + 30 - Player.pHei));
               if(Mario.levelid == 16)
               {
                  Mario.instEffects.push(new BowserFlame(eX + 5 + 20 * dir,eY + 10,dir,Player.pY + 60 - Player.pHei));
                  Mario.instEffects.push(new BowserFlame(eX + 5 + 20 * dir,eY + 10,dir,Player.pY - Player.pHei));
               }
               action = 0;
            }
         }
         else if(action == 2)
         {
            if(waiter < 80)
            {
               ++waiter;
            }
            else if(waiter == 80)
            {
               if(hammerer2 == 0)
               {
                  if(hammerer1 > 0)
                  {
                     if(Math.abs(eX - Player.pX) < 500)
                     {
                        _loc2_ = new Fireball(eX + 5 + (dir == 1 ? 30 : 0),eY + 20,dir,true,Mario.levelid == 16 ? 5 : 3);
                        _loc2_.dir = dir * 3;
                        Mario.instObjects.push(_loc2_);
                        if(Mario.sounds)
                        {
                           SFXRadish.play();
                        }
                     }
                     --hammerer1;
                  }
                  else
                  {
                     action = 0;
                  }
                  hammerer2 = hampau;
               }
               else
               {
                  --hammerer2;
               }
            }
            else if(waiter < 100)
            {
               ++waiter;
            }
            else if(waiter == 100)
            {
               action = 0;
            }
         }
         if(damageWait > 0)
         {
            --damageWait;
         }
         gfxPosition();
      }

      override public function FireballHit(param1:uint, param2:int) : Boolean
      {
         if(damageWait == 0)
         {
            --firehp;
            if(firehp == 0)
            {
               --hp;
               damageWait = 120;
               firehp = 6;
            }
         }
         if(Mario.sounds)
         {
            SFXBump.play();
         }
         return true;
      }
   }
}
