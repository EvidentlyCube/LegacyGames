package objects
{
   import flash.display.*;
   import flash.media.Sound;

   public class Bonus extends Block
   {


      private var SFXSprout:Sound;

      private var invisible:Boolean;

      private var wait:uint = 0;

      private var SFXCoin:Sound;

      private var GFX:Array;

      public var type:uint;

      private var frame:uint = 0;

      private var seq:Number = -1;

      public function Bonus(param1:uint, param2:uint, param3:uint, param4:Boolean = false)
      {
         GFX = new Array(3);
         SFXSprout = new (Mario.classSFX.accessSFX("sprout"))();
         SFXCoin = new (Mario.classSFX.accessSFX("coin"))();
         super();
         invisible = param4;
         bX = param1;
         bY = param2;
         type = param3;
         if(type == 0)
         {
            GFX[0] = new (Mario.classGFX.AccessGFX("bonus_used"))();
            GFX[0].x = bX;
            GFX[0].y = bY;
         }
         else
         {
            GFX[0] = new (Mario.classGFX.AccessGFX("bonus_bonus_1"))();
            GFX[1] = new (Mario.classGFX.AccessGFX("bonus_bonus_2"))();
            GFX[2] = new (Mario.classGFX.AccessGFX("bonus_bonus_3"))();
            GFX[3] = new (Mario.classGFX.AccessGFX("bonus_bonus_4"))();
            GFX[4] = GFX[2];
            GFX[5] = GFX[1];
            GFX[0].x = GFX[1].x = GFX[2].x = GFX[3].x = bX;
            GFX[0].y = GFX[1].y = GFX[2].y = GFX[3].y = bY;
         }
         if(!invisible)
         {
            Mario.layerWall.addChild(GFX[0]);
         }
         if(!invisible)
         {
            Mario.changeLevel(bX / 25,bY / 25,"x");
         }
      }

      override public function Headbutt(param1:uint) : void
      {
         if(type == 1)
         {
            ++Mario.Hud.Coins;
            Mario.Hud.RedrawCoins();
            if(Mario.sounds)
            {
               SFXCoin.play();
            }
            Mario.instEffects.push(new Coin_Jump(bX + 5,bY - 22));
         }
         if(invisible)
         {
            Mario.changeLevel(bX / 25,bY / 25,"x");
            Player.pY = Math.floor(bY / 25) * 25 + 25;
         }
         if(!invisible)
         {
            Mario.layerWall.removeChild(GFX[frame]);
         }
         GFX[0] = new (Mario.classGFX.AccessGFX("bonus_used"))();
         GFX[0].x = bX;
         GFX[0].y = bY;
         Mario.layerWall.addChild(GFX[0]);
         frame = 0;
         seq = Math.PI;
         Mario.enemyHitFireball(bX,bY - 2,25,2,Player.dir);
      }

      override public function Update(param1:uint) : void
      {
         if(seq == -1)
         {
            if(type > 0)
            {
               if(Player.hitHead)
               {
                  if(Mario.playerCollide(bX,bY,25,26))
                  {
                     Mario.headbuttSetDistance(param1,bX);
                  }
               }
               else if(invisible && Player.gravity < 0 && Player.pY - Player.gravity > bY + 24 && Mario.playerCollide(bX,bY,25,26))
               {
                  Mario.headbuttSetDistance(param1,bX);
               }
               ++wait;
               if(wait == 4 && !invisible)
               {
                  Mario.layerWall.removeChild(GFX[frame]);
                  frame = (frame + 1) % 6;
                  Mario.layerWall.addChild(GFX[frame]);
                  wait = 0;
               }
            }
         }
         else if(seq > 0)
         {
            GFX[frame].y = bY - Math.sin(seq) * 10;
            seq -= Math.PI / 10;
         }
         else
         {
            GFX[frame].y = bY;
            switch(type)
            {
               case 2:
               case 5:
                  Mario.instObjects.push(new Shroom(bX,bY));
                  if(Mario.sounds)
                  {
                     SFXSprout.play();
                  }
                  break;
               case 3:
                  Mario.instObjects.push(new KillShroom(bX,bY));
                  if(Mario.sounds)
                  {
                     SFXSprout.play();
                  }
                  break;
               case 4:
                  Mario.instObjects.push(new LifeShroom(bX,bY));
                  if(Mario.sounds)
                  {
                     SFXSprout.play();
                  }
            }
            type = 0;
         }
      }
   }
}
