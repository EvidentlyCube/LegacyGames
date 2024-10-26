package objects
{
   import flash.display.*;
   import flash.media.Sound;
   
   public class Coin extends Obj
   {
       
      
      public var wait:uint = 0;
      
      private var SFXCoin:Sound;
      
      private var GFX:Array;
      
      public var frame:uint = 0;
      
      public function Coin(param1:Number, param2:Number)
      {
         GFX = new Array(3);
         SFXCoin = new (Mario.classSFX.accessSFX("coin"))();
         super();
         oX = param1 + 4;
         oY = param2 + 2;
         GFX[0] = new (Mario.classGFX.AccessGFX("object_coin_1"))();
         GFX[1] = new (Mario.classGFX.AccessGFX("object_coin_2"))();
         GFX[2] = new (Mario.classGFX.AccessGFX("object_coin_3"))();
         GFX[3] = new (Mario.classGFX.AccessGFX("object_coin_4"))();
         GFX[4] = new (Mario.classGFX.AccessGFX("object_coin_5"))();
         GFX[5] = new (Mario.classGFX.AccessGFX("object_coin_6"))();
         GFX[0].x = GFX[1].x = GFX[2].x = GFX[3].x = GFX[4].x = GFX[5].x = oX - 4;
         GFX[0].y = GFX[1].y = GFX[2].y = GFX[3].y = GFX[4].y = GFX[5].y = oY - 2;
         Mario.layerFore.addChild(GFX[0]);
      }
      
      override public function Update(param1:uint) : void
      {
         ++wait;
         if(wait == 4)
         {
            Mario.layerFore.removeChild(GFX[frame]);
            frame = (frame + 1) % 6;
            Mario.layerFore.addChildAt(GFX[frame],0);
            wait = 0;
         }
         if(Mario.playerCollide(oX,oY,16,22))
         {
            ++Mario.Hud.Coins;
            Mario.Hud.RedrawCoins();
            Mario.layerFore.removeChild(GFX[frame]);
            Mario.removeObject(param1);
            if(Mario.sounds)
            {
               SFXCoin.play();
            }
         }
      }
   }
}
