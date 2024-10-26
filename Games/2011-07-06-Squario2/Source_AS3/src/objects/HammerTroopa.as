package objects
{
   import flash.display.*;
   import flash.media.Sound;
   
   public class HammerTroopa extends Enemy
   {
       
      
      private var attacking:uint = 0;
      
      public var dead:Boolean;
      
      public var frame:uint = 0;
      
      private var jump:uint = 0;
      
      private var gotox:uint = 0;
      
      private var startx:uint = 0;
      
      private var GFX:Array;
      
      private var SFXStomp:Sound;
      
      private var wait:uint = 0;
      
      private var radisher:Boolean;
      
      public function HammerTroopa(param1:uint, param2:uint, param3:Boolean = false)
      {
         GFX = new Array(2);
         SFXStomp = new (Mario.classSFX.accessSFX("stomp"))();
         super();
         eX = param1;
         eY = param2;
         startx = param1;
         gotox = param1;
         radisher = param3;
         eWid = 21;
         dir = Player.pX > eX ? 1 : -1;
         eHei = 35;
         dir = 1;
         GFX[0] = new (Mario.classGFX.AccessGFX("enemy_hammer_1"))();
         GFX[1] = new (Mario.classGFX.AccessGFX("enemy_hammer_2"))();
         GFX[0].x = eX - 2 + (dir > 0 ? 0 : 25);
         GFX[0].y = eY - 4;
         Mario.layerFore.addChild(GFX[0]);
      }
      
      override public function Stomp(param1:uint) : void
      {
         Mario.instEffects.push(new Points(eX + 10,eY - 5,"100"));
         Player.hitStomp = true;
         dead = true;
         Player.Bounce(eY);
         Mario.layerFore.removeChild(GFX[frame]);
         Mario.removeEnemy(param1);
         Mario.instEffects.push(new Enemy_Fall(eX - 4,eY - 3,dir,GFX[frame]));
         if(Mario.sounds)
         {
            SFXStomp.play();
         }
      }
      
      override public function Fire(param1:uint, param2:int) : Boolean
      {
         Mario.layerFore.removeChild(GFX[frame]);
         Mario.removeEnemy(param1);
         dead = true;
         Mario.instEffects.push(new Enemy_Fire(eX - 2,eY - 4,Mario.Sign(param2) * 3,Mario.classGFX.AccessGFX("enemy_hammer_1")));
         return true;
      }
      
      override public function Update(param1:uint) : void
      {
         if(active)
         {
            if(jump == 0 && gravity == 0)
            {
               switch(Math.floor(Math.random() * 50))
               {
                  case 0:
                     gravity = -2;
                     if(eY < 275)
                     {
                        jump = 40;
                     }
                     break;
                  case 25:
                     gravity = -6;
               }
            }
            if(eX == gotox)
            {
               if(Math.floor(Math.random() * 20) == 0)
               {
                  gotox = Math.round(startx + 150 * (Math.random() - 0.5));
               }
            }
            if(attacking > 0)
            {
               --attacking;
            }
            else if(Math.random() < 0.03)
            {
               if(!radisher)
               {
                  attacking = 40;
                  Mario.instObjects.push(new Hammer(this));
               }
            }
            eX += Mario.Sign(gotox - eX);
            stomped = false;
            gravity += Mario.gravity / 3;
            if(gravity > 10)
            {
               gravity = 10;
            }
            eY += Math.round(gravity);
            if(jump > 0)
            {
               --jump;
            }
            if(gravity > 0 && jump == 0)
            {
               if(Mario.levelColl(eX,eY + eHei - 1) || Mario.levelColl(eX + eWid - 1,eY + eHei - 1))
               {
                  gravity = 0;
                  eY = Math.floor((eY + eHei - 1) / 25) * 25 - 35;
               }
            }
            if(Mario.playerCollide(eX,eY,eWid,eHei))
            {
               if(Player.pY - Player.gravity + Player.pHei <= eY + 5 - gravity)
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
            ++wait;
            if(wait == 15)
            {
               Mario.layerFore.removeChild(GFX[frame]);
               frame = 1 - frame;
               Mario.layerFore.addChild(GFX[frame]);
               dir = Player.pX > eX ? 1 : -1;
               GFX[frame].scaleX = dir;
               wait = 0;
               if(frame == 0)
               {
                  if(radisher && attacking == 0 && Math.random() < 0.4 && Math.abs(gravity) < 1)
                  {
                     attacking = 5;
                     Mario.instObjects.push(new Fireball(eX + 10,eY + 10,dir / 2,true));
                     Mario.instObjects.push(new Fireball(eX + 10,eY + 10,dir / 2,true));
                     Mario.instObjects.push(new Fireball(eX + 10,eY + 10,dir / 2,true));
                  }
               }
            }
            GFX[frame].x = eX - 4 + (dir > 0 ? 0 : 25);
            GFX[frame].y = eY - 3;
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
   }
}
