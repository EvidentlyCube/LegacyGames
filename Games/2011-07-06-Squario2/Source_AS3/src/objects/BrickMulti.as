package objects
{
   import flash.media.Sound;
   import mx.core.BitmapAsset;
   
   public class BrickMulti extends Block
   {
       
      
      private var coins:uint = 0;
      
      private var SFXCoin:Sound;
      
      private var GFX:BitmapAsset;
      
      private var seq:Number = 0;
      
      public function BrickMulti(param1:uint, param2:uint, param3:uint = 5)
      {
         var _loc4_:Class = null;
         SFXCoin = new (Mario.classSFX.accessSFX("coin"))();
         super();
         bX = param1;
         bY = param2;
         this.coins = param3;
         _loc4_ = Mario.classGFX.AccessGFX("bonus_brick");
         GFX = new _loc4_();
         GFX.x = bX;
         GFX.y = bY;
         Mario.layerWall.addChild(GFX);
         Mario.changeLevel(bX / 25,bY / 25,"x");
      }
      
      override public function Update(param1:uint) : void
      {
         if(coins > 0 && Player.hitHead)
         {
            if(Mario.playerCollide(bX,bY,25,26))
            {
               Mario.headbuttSetDistance(param1,bX);
            }
         }
         if(seq > 0)
         {
            GFX.y = bY - Math.sin(seq) * 10;
            seq -= Math.PI / 10;
         }
         else
         {
            GFX.y = bY;
         }
      }
      
      override public function Headbutt(param1:uint) : void
      {
         var _loc2_:Class = null;
         seq = Math.PI;
         if(coins > 0)
         {
            Mario.enemyHitFireball(bX,bY - 2,25,2,Player.dir);
            ++Mario.Hud.Coins;
            Mario.Hud.RedrawCoins();
            Mario.instEffects.push(new Coin_Jump(bX + 5,bY - 22));
            --coins;
            if(Mario.sounds)
            {
               SFXCoin.play();
            }
            if(coins == 0)
            {
               Mario.layerWall.removeChild(GFX);
               _loc2_ = Mario.classGFX.AccessGFX("bonus_used");
               GFX = new _loc2_();
               GFX.x = bX;
               GFX.y = bY;
               Mario.layerWall.addChild(GFX);
            }
         }
      }
   }
}
