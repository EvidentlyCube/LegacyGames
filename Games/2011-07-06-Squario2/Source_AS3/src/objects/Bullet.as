package objects
{
   import flash.media.Sound;
   
   public class Bullet extends Enemy
   {
       
      
      private var wait:uint = 0;
      
      private var GFX:Array;
      
      private var SFXStomp:Sound;
      
      private var frame:uint = 0;
      
      public function Bullet(param1:uint, param2:uint)
      {
         GFX = new Array(3);
         SFXStomp = new (Mario.classSFX.accessSFX("stomp"))();
         super();
         eX = param1;
         eY = param2;
         dir = Player.pX > eX ? 3 : -3;
         frame = Math.abs(-(wait / 8) + 2);
         GFX[0] = new (Mario.classGFX.AccessGFX("enemy_bullet_1"))();
         GFX[1] = new (Mario.classGFX.AccessGFX("enemy_bullet_2"))();
         GFX[2] = new (Mario.classGFX.AccessGFX("enemy_bullet_3"))();
         GFX[frame].scaleX = dir / 3;
         GFX[frame].x = eX - 2 + (dir > 0 ? 0 : 25);
         GFX[frame].y = eY - 2;
         Mario.layerFore.addChild(GFX[frame]);
      }
      
      override public function Update(param1:uint) : void
      {
         ++wait;
         if(wait % 8 == 0)
         {
            Mario.layerFore.removeChild(GFX[frame]);
            frame = Math.abs(-(wait / 8) + 2);
            Mario.layerFore.addChild(GFX[frame]);
            if(wait == 32)
            {
               wait = 0;
            }
         }
         eX += dir;
         GFX[frame].scaleX = dir / 3;
         GFX[frame].x = eX - 2 + (dir > 0 ? 0 : 25);
         GFX[frame].y = eY - 2;
         if(Mario.playerCollide(eX,eY,21,21))
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
         if(eX > Player.pX + 300 || eX < Player.pX - 300)
         {
            Mario.layerFore.removeChild(GFX[frame]);
            Mario.removeEnemy(param1);
         }
      }
      
      override public function FireballHit(param1:uint, param2:int) : Boolean
      {
         return false;
      }
      
      override public function Stomp(param1:uint) : void
      {
         Mario.layerFore.removeChild(GFX[frame]);
         Mario.removeEnemy(param1);
         alive = false;
         Player.hitStomp = true;
         Player.Bounce(eY);
         Mario.instEffects.push(new Enemy_Fall(eX,eY,Mario.Sign(dir),GFX[frame]));
         if(Mario.sounds)
         {
            SFXStomp.play();
         }
      }
   }
}
