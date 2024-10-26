package objects
{
   import flash.display.*;
   import flash.media.Sound;
   
   public class Goomba extends Enemy
   {
       
      
      private var timer:int = 0;
      
      private var GFX:Array;
      
      private var SFXStomp:Sound;
      
      private var frame:uint = 0;
      
      public function Goomba(param1:uint, param2:uint)
      {
         GFX = new Array(8);
         SFXStomp = new (Mario.classSFX.accessSFX("stomp"))();
         super();
         eX = param1;
         eY = param2;
         eWid = 21;
         dir = Player.pX > eX ? 1.5 : -1.5;
         eHei = 21;
         GFX[0] = new (Mario.classGFX.AccessGFX("enemy_goomba_0"))();
         GFX[1] = new (Mario.classGFX.AccessGFX("enemy_goomba_1"))();
         GFX[2] = new (Mario.classGFX.AccessGFX("enemy_goomba_2"))();
         GFX[3] = new (Mario.classGFX.AccessGFX("enemy_goomba_3"))();
         GFX[4] = new (Mario.classGFX.AccessGFX("enemy_goomba_4"))();
         GFX[5] = new (Mario.classGFX.AccessGFX("enemy_goomba_5"))();
         GFX[6] = new (Mario.classGFX.AccessGFX("enemy_goomba_6"))();
         GFX[7] = new (Mario.classGFX.AccessGFX("enemy_goomba_7"))();
         GFX[0].x = eX - 2 + (frame > 15 ? 25 : 0);
         GFX[0].y = eY - 4;
         Mario.layerFore.addChild(GFX[0]);
      }
      
      override public function Update(param1:uint) : void
      {
         if(active)
         {
            stomped = false;
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
               }
               else
               {
                  dir *= -1;
                  eX += dir;
               }
            }
            else if(Mario.enemyBounce(param1,eX,eY,2,eHei) == false)
            {
               if(Mario.levelColl(eX,eY) || Mario.levelColl(eX,eY + eHei - 1))
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
            if(gravity > 0)
            {
               if(Mario.levelColl(eX,eY + eHei - 1) || Mario.levelColl(eX + eWid - 1,eY + eHei - 1))
               {
                  gravity = 0;
                  eY = Math.floor(eY / 25) * 25 + 4;
               }
            }
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
            if(!timer--)
            {
               timer = 5;
               Mario.layerFore.removeChild(GFX[frame]);
               frame = (frame + 1) % 8;
               Mario.layerFore.addChild(GFX[frame]);
            }
            GFX[frame].x = eX - 2 + (frame > 15 ? 25 : 0);
            GFX[frame].y = eY - 4;
         }
         else if(Player.pX + 250 > eX && Player.pX - 250 < eX || Mario.scrollEdge + 400 > eX)
         {
            active = true;
         }
         if(eY > Mario.levelHei * 25 + 250)
         {
            Fire(param1,1);
         }
      }
      
      override public function Fire(param1:uint, param2:int) : Boolean
      {
         Mario.layerFore.removeChild(GFX[frame]);
         Mario.removeEnemy(param1);
         Mario.instEffects.push(new Enemy_Fire(eX - 2,eY - 4,Mario.Sign(param2) * 3,Mario.classGFX.AccessGFX("enemy_goomba_0")));
         return true;
      }
      
      override public function Stomp(param1:uint) : void
      {
         Mario.instEffects.push(new Points(eX + 10,eY - 5,"100"));
         Player.hitStomp = true;
         Player.Bounce(eY);
         Mario.layerFore.removeChild(GFX[frame]);
         Mario.removeEnemy(param1);
         Mario.instEffects.push(new Goomba_Stomped(eX,eY));
         if(Mario.sounds)
         {
            SFXStomp.play();
         }
      }
   }
}
