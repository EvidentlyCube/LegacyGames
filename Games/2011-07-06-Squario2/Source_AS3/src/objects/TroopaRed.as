package objects
{
   import flash.display.*;
   import flash.media.Sound;
   
   public class TroopaRed extends Enemy
   {
       
      
      private var waiter:uint = 0;
      
      private var Mode:uint = 0;
      
      private var frame:uint = 0;
      
      private var SFXStomp:Sound;
      
      private var wait:uint = 0;
      
      private var GFX:Array;
      
      private var fall:Boolean = false;
      
      private var num:uint = 0;
      
      public function TroopaRed(param1:uint, param2:uint)
      {
         GFX = new Array(4);
         SFXStomp = new (Mario.classSFX.accessSFX("stompduck"))();
         super();
         eX = param1;
         eY = param2;
         eWid = 21;
         dir = Player.pX > eX ? 1 : -1;
         eHei = 21;
         GFX[0] = new (Mario.classGFX.AccessGFX("enemy_koopa_red_1"))();
         GFX[1] = GFX[3] = new (Mario.classGFX.AccessGFX("enemy_koopa_red_2"))();
         GFX[2] = new (Mario.classGFX.AccessGFX("enemy_koopa_red_3"))();
         GFX[0].x = eX - 3;
         GFX[0].y = eY - 5;
         Mario.layerFore.addChild(GFX[0]);
      }
      
      override public function Stomp(param1:uint) : void
      {
         Player.hitStomp = true;
         Player.Bounce(eY);
         if(Mario.sounds)
         {
            SFXStomp.play();
         }
      }
      
      override public function Update(param1:uint) : void
      {
         var _loc2_:Class = null;
         if(active)
         {
            if(Mode == 0)
            {
               eX += dir;
               if(dir > 0)
               {
                  if(Mario.enemyBounce(param1,eX + eWid - 1,eY,2,eHei) == false)
                  {
                     if(Mario.levelColl(eX + eWid - 1,eY) || Mario.levelColl(eX + eWid - 1,eY + eHei - 1))
                     {
                        dir *= -1;
                        eX += dir;
                     }
                     else if(gravity < 1 && Mario.levelColl(eX + eWid,eY + eHei) == false)
                     {
                        dir *= -1;
                        eX += dir;
                     }
                  }
                  else
                  {
                     dir *= -1;
                     eX += dir;
                  }
               }
               else if(Mario.enemyBounce(param1,eX - 1,eY,2,eHei) == false)
               {
                  if(Mario.levelColl(eX - 1,eY + eHei) == false || Mario.levelColl(eX,eY) || Mario.levelColl(eX,eY + eHei - 1))
                  {
                     dir *= -1;
                     eX += dir;
                  }
                  else if(gravity > 1 && Mario.levelColl(eX - 1,eY + eHei) == false)
                  {
                     dir *= -1;
                     eX += dir;
                  }
               }
               else
               {
                  dir *= -1;
                  eX += dir;
               }
               gravity += Mario.gravity;
               if(gravity > 10)
               {
                  gravity = 10;
               }
               eY += Math.round(gravity);
               if(gravity > 1)
               {
                  fall = true;
               }
               if(gravity > 0)
               {
                  if(Mario.levelColl(eX,eY + eHei - 1) || Mario.levelColl(eX + eWid - 1,eY + eHei - 1))
                  {
                     gravity = 0;
                     eY = Math.floor(eY / 25) * 25 + 4;
                     if(fall)
                     {
                        dir = Player.pX > eX ? 1 : -1;
                        fall = false;
                     }
                  }
               }
               if(!wait--)
               {
                  Mario.layerFore.removeChild(GFX[frame]);
                  frame = (frame + 1) % 4;
                  Mario.layerFore.addChild(GFX[frame]);
                  wait = 5;
               }
               GFX[frame].scaleX = dir;
               GFX[frame].x = eX - 2 + (dir == 1 ? 0 : 25);
               GFX[frame].y = eY - 16;
               if(Mario.playerCollide(eX,eY,eWid,eHei))
               {
                  if(Player.Falls())
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
            }
         }
         else if(Player.pX + 250 > eX && Player.pX - 250 < eX)
         {
            active = true;
         }
         if(eY > Mario.levelHei * 25 + 250)
         {
            Fire(param1,1);
         }
      }
      
      private function makeShell() : void
      {
         Mario.layerFore.removeChild(GFX[frame]);
         frame = 2;
         GFX[frame].x = eX - 2;
         GFX[frame].y = eY - 1;
         Mario.layerFore.addChild(GFX[frame]);
      }
      
      override public function Fire(param1:uint, param2:int) : Boolean
      {
         Mario.layerFore.removeChild(GFX[frame]);
         Mario.removeEnemy(param1);
         alive = false;
         Mario.instEffects.push(new Enemy_Fire(eX - 2,eY - 1,Mario.Sign(param2) * 3,Mario.classGFX.AccessGFX("enemy_koopa_red_1")));
         return true;
      }
   }
}
