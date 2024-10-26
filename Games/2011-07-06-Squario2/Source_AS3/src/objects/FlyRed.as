package objects
{
   import flash.display.*;
   import flash.media.Sound;
   
   public class FlyRed extends Enemy
   {
       
      
      private var SFXStomp:Sound;
      
      private var frame:uint = 0;
      
      private var ydir:Number;
      
      private var wait:uint = 0;
      
      private var starty:uint;
      
      private var GFX:Array;
      
      public function FlyRed(param1:uint, param2:uint)
      {
         GFX = new Array(3);
         SFXStomp = new (Mario.classSFX.accessSFX("stompduck"))();
         super();
         eX = param1;
         eY = param2;
         starty = eY;
         eWid = 21;
         dir = Player.pX > eX ? 1 : -1;
         ydir = 0.1;
         eHei = 21;
         GFX[0] = new (Mario.classGFX.AccessGFX("enemy_fly_red_1"))();
         GFX[1] = new (Mario.classGFX.AccessGFX("enemy_fly_red_2"))();
         GFX[2] = new (Mario.classGFX.AccessGFX("enemy_fly_red_3"))();
         GFX[0].x = eX - 3;
         GFX[0].y = eY - 5;
         Mario.layerFore.addChild(GFX[0]);
      }
      
      override public function Update(param1:uint) : void
      {
         var _loc2_:Class = null;
         if(active)
         {
            dir = Player.pX > eX ? 1 : -1;
            gravity += ydir;
            eY += gravity;
            gravity = gravity > 2 ? 2 : (gravity < -2 ? -2 : gravity);
            if(eY > starty + 100)
            {
               ydir = -0.1;
            }
            if(eY < starty)
            {
               ydir = 0.1;
            }
            ++wait;
            if(wait == 3)
            {
               Mario.layerFore.removeChild(GFX[frame]);
               ++frame;
               if(frame == 3)
               {
                  frame = 0;
               }
               Mario.layerFore.addChild(GFX[frame]);
               wait = 0;
            }
            GFX[frame].scaleX = dir;
            GFX[frame].x = eX - 2 + (dir == 1 ? 0 : 24);
            GFX[frame].y = eY - 16;
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
      
      override public function Stomp(param1:uint) : void
      {
         Mario.layerFore.removeChild(GFX[frame]);
         Mario.removeEnemy(param1);
         alive = false;
         Mario.instEnemies.push(new TroopaRed(eX,eY));
         Player.hitStomp = true;
         Player.Bounce(eY);
         if(Mario.sounds)
         {
            SFXStomp.play();
         }
      }
      
      override public function Fire(param1:uint, param2:int) : Boolean
      {
         Mario.layerFore.removeChild(GFX[frame]);
         Mario.removeEnemy(param1);
         alive = false;
         Mario.instEffects.push(new Enemy_Fire(eX - 2,eY - 1,Mario.Sign(param2) * 3,Mario.classGFX.AccessGFX("enemy_fly_red_1")));
         return true;
      }
   }
}
