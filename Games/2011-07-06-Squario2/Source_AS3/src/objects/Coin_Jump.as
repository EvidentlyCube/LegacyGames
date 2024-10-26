package objects
{
   import mx.core.BitmapAsset;
   
   public class Coin_Jump extends Effect
   {
       
      
      public var fX:Number;
      
      public var fY:Number;
      
      public var speed:Number = 10;
      
      public var GFX:BitmapAsset;
      
      public var frame:uint = 1;
      
      public function Coin_Jump(param1:Number, param2:Number)
      {
         super();
         fX = param1 - 5;
         fY = param2;
         var _loc3_:Class = Mario.classGFX.AccessGFX("effect_coin_jump_1");
         GFX = new _loc3_();
         GFX.x = fX;
         GFX.y = fY;
         Mario.layerFore.addChild(GFX);
      }
      
      override public function Update(param1:uint) : void
      {
         frame = (frame + 1) % 12 + 1;
         fY -= speed;
         speed -= Mario.gravity;
         GFX.x = fX;
         GFX.y = fY;
         GFX.alpha = (speed - 2) / 8;
         Mario.layerFore.addChild(GFX);
         if(speed < 2)
         {
            Mario.instEffects.push(new Points(fX + 7,fY + 130,"200"));
            Mario.layerFore.removeChild(GFX);
            Mario.removeEffect(param1);
         }
      }
   }
}
