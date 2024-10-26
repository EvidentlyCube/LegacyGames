package objects
{
   import flash.display.*;
   
   public class PFlame extends Enemy
   {
       
      
      private var frameDir:int = 1;
      
      private var timer:uint = 0;
      
      private var frame:uint = 0;
      
      private var wait:uint = 0;
      
      private var GFX:Array;
      
      public function PFlame(param1:uint, param2:uint, param3:int = 1)
      {
         GFX = new Array(2);
         super();
         bounce = false;
         eX = param1 + 14;
         eY = param2;
         eWid = 20;
         dir = param3;
         eHei = 32;
         GFX[0] = new (Mario.classGFX.AccessGFX("enemy_pflame_1"))();
         GFX[1] = new (Mario.classGFX.AccessGFX("enemy_pflame_2"))();
         GFX[2] = new (Mario.classGFX.AccessGFX("enemy_pflame_3"))();
         GFX[3] = new (Mario.classGFX.AccessGFX("enemy_pflame_4"))();
         GFX[0].x = eX - 2;
         GFX[0].y = eY - 2 + (dir == -1 ? 38 : 0);
         GFX[0].scaleY = GFX[1].scaleY = GFX[2].scaleY = GFX[3].scaleY = dir;
         Mario.layerHide.addChild(GFX[0]);
      }
      
      override public function Update(param1:uint) : void
      {
         if(active)
         {
            if(dir == 1)
            {
               if(timer < 100)
               {
                  ++timer;
               }
               else if(timer == 100)
               {
                  if(Player.pX - eX < -72 || Player.pX - eX > 50)
                  {
                     timer = 101;
                  }
               }
               else if(timer == 101)
               {
                  --eY;
                  if(Mario.levelColl(eX,eY + eHei - 1) == false)
                  {
                     timer = 102;
                  }
               }
               else if(timer == 105)
               {
                  ++eY;
                  if(Mario.levelColl(eX,eY - 3))
                  {
                     timer = 0;
                  }
               }
            }
            else if(timer < 100)
            {
               ++timer;
            }
            else if(timer == 100)
            {
               if(Player.pX - eX < -72 || Player.pX - eX > 50)
               {
                  timer = 101;
               }
            }
            else if(timer == 101)
            {
               ++eY;
               if(Mario.levelColl(eX,eY) == false)
               {
                  timer = 102;
               }
            }
            else if(timer == 105)
            {
               --eY;
               if(Mario.levelColl(eX,eY + eHei + 3))
               {
                  timer = 0;
               }
            }
            if(Mario.playerCollide(eX,eY,eWid,eHei))
            {
               Mario.hitPlayer();
            }
            if(!wait--)
            {
               wait = 5;
               Mario.layerHide.removeChild(GFX[frame]);
               frame += frameDir;
               if(frame == 0)
               {
                  if(timer >= 102 && timer < 105)
                  {
                     ++timer;
                     if(Player.pX + 250 > eX && Player.pX - 250 < eX)
                     {
                        if(dir == 1)
                        {
                           Mario.instObjects.push(new Fireplant(eX + 10,eY + 5,Mario.Sign(Player.pX - eX) * 4 * Math.random(),-6));
                        }
                        else
                        {
                           Mario.instObjects.push(new Fireplant(eX + 10,eY + 30,Mario.Sign(Player.pX - eX) * 4 * Math.random(),1));
                        }
                     }
                  }
                  frameDir = 1;
               }
               else if(frame == 3)
               {
                  frameDir = -1;
               }
               Mario.layerHide.addChild(GFX[frame]);
            }
            GFX[frame].x = eX - 2;
            GFX[frame].y = eY - 2 + (dir == -1 ? 38 : 0);
         }
         else if(Player.pX + 250 > eX && Player.pX - 250 < eX)
         {
            active = true;
            timer = 100;
         }
      }
      
      override public function Fire(param1:uint, param2:int) : Boolean
      {
         Mario.layerHide.removeChild(GFX[frame]);
         Mario.removeEnemy(param1);
         return true;
      }
   }
}
