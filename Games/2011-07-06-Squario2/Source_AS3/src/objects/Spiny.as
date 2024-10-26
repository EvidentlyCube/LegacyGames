package objects
{
   import flash.display.*;
   
   public class Spiny extends Enemy
   {
       
      
      private var wait:uint = 0;
      
      private var GFX:Array;
      
      private var fall:Boolean = false;
      
      private var frame:uint = 0;
      
      public function Spiny(param1:uint, param2:int)
      {
         GFX = new Array(8);
         super();
         eX = param1;
         eY = param2;
         eWid = 21;
         dir = Player.pX > eX ? 1 : -1;
         eHei = 21;
         GFX[0] = new (Mario.classGFX.AccessGFX("enemy_spiny_1"))();
         GFX[1] = GFX[7] = new (Mario.classGFX.AccessGFX("enemy_spiny_2"))();
         GFX[2] = GFX[6] = new (Mario.classGFX.AccessGFX("enemy_spiny_3"))();
         GFX[3] = GFX[5] = new (Mario.classGFX.AccessGFX("enemy_spiny_4"))();
         GFX[4] = new (Mario.classGFX.AccessGFX("enemy_spiny_5"))();
         GFX[0].x = eX - 3;
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
            else if(Mario.enemyBounce(param1,eX - 1,eY,2,eHei) == false)
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
            if(Mario.playerCollide(eX,eY,eWid,eHei))
            {
               Mario.hitPlayer();
            }
            ++wait;
            if(wait == 4)
            {
               Mario.layerFore.removeChild(GFX[frame]);
               ++frame;
               if(frame == 8)
               {
                  frame = 0;
               }
               Mario.layerFore.addChild(GFX[frame]);
               wait = 0;
            }
            GFX[frame].scaleX = dir;
            GFX[frame].x = eX - 2 + (dir == -1 ? 25 : 0);
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
         Mario.instEffects.push(new Enemy_Fire(eX - 2,eY - 4,Mario.Sign(param2) * 3,Mario.classGFX.AccessGFX("enemy_spiny_1")));
         return true;
      }
   }
}
