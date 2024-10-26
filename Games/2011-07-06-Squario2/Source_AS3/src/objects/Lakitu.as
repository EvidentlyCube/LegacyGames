package objects
{
   import flash.display.*;
   import flash.media.Sound;
   
   public class Lakitu extends Enemy
   {
       
      
      private var moveX:Number = 0;
      
      private var SFXStomp:Sound;
      
      private var frame:uint = 0;
      
      private var gfxF:uint = 0;
      
      private var wait:uint = 0;
      
      private var GFX:Array;
      
      private var gfxW:uint = 1;
      
      public function Lakitu(param1:uint, param2:uint)
      {
         GFX = new Array(4);
         SFXStomp = new (Mario.classSFX.accessSFX("stomp"))();
         super();
         bounce = false;
         eX = param1;
         eY = param2;
         eWid = 22;
         eHei = 22;
         gravity = -4;
         GFX[0] = new (Mario.classGFX.AccessGFX("enemy_lakitu_1"))();
         GFX[1] = GFX[3] = new (Mario.classGFX.AccessGFX("enemy_lakitu_2"))();
         GFX[2] = new (Mario.classGFX.AccessGFX("enemy_lakitu_3"))();
         GFX[0].x = eX - 2;
         GFX[0].y = eY - 12;
         wait = 50 + Math.random() * 150;
         Mario.layerFore.addChild(GFX[0]);
      }
      
      override public function Update(param1:uint) : void
      {
         var _loc2_:Class = null;
         if(Player.pX + Player.speed / 10 > eX)
         {
            moveX = Math.min(moveX + 0.3,6);
         }
         else
         {
            moveX = Math.max(moveX - 0.3,-6);
         }
         eX += Math.round(moveX);
         if(wait < 250)
         {
            ++wait;
         }
         if(wait == 250)
         {
            if(Mario.levelColl(eX,eY - 10) == false && Mario.levelColl(eX,eY + 10) == false && Mario.levelColl(eX + 20,eY - 10) == false && Mario.levelColl(eX + 20,eY + 10) == false)
            {
               frame = 0;
               wait = 0;
               wait = 50 + Math.random() * 150;
               Mario.instEnemies.push(new SpinyShell(eX,eY - 10));
            }
         }
         if(!gfxW--)
         {
            Mario.layerFore.removeChild(GFX[gfxF]);
            gfxF = (gfxF + 1) % 4;
            Mario.layerFore.addChild(GFX[gfxF]);
            gfxW = 5;
         }
         GFX[gfxF].x = eX - 2;
         GFX[gfxF].y = eY - 2;
         if(Mario.playerControllable && Mario.Collide(eX,eY,eWid,eHei,Player.pX,Player.pY + Player.pHei - 1,Player.pWid,1))
         {
            if(Player.Falls())
            {
               if(Player.hitStomp == false)
               {
                  Mario.stompSetDistance(param1,eX);
               }
            }
         }
      }
      
      override public function Stomp(param1:uint) : void
      {
         Mario.instEffects.push(new Points(eX + 10,eY - 5,"1000"));
         Player.hitStomp = true;
         Player.Bounce(eY);
         Mario.instEffects.push(new Lakitu_Stomped(eX,eY));
         eX += 3000;
         if(Mario.sounds)
         {
            SFXStomp.play();
         }
      }
      
      override public function Fire(param1:uint, param2:int) : Boolean
      {
         eX += 3000;
         Mario.instEffects.push(new Enemy_Fire(eX - 2,eY - 12,Mario.Sign(param2) * 3,Mario.classGFX.AccessGFX("enemy_lakitu_1")));
         return true;
      }
   }
}
