package objects
{
   import flash.display.Sprite;
   import mx.core.BitmapAsset;
   
   public class Fire_Boom extends Effect
   {
       
      
      public var GFX:Sprite;
      
      public function Fire_Boom(param1:Number, param2:Number)
      {
         var _loc4_:BitmapAsset = null;
         super();
         timer = 0;
         var _loc3_:Class = Mario.classGFX.AccessGFX("effect_fire_boom");
         (_loc4_ = new _loc3_()).x = -12.5;
         _loc4_.y = -12.5;
         GFX = new Sprite();
         GFX.x = param1;
         GFX.y = param2;
         GFX.addChild(_loc4_);
         Mario.layerFore.addChild(GFX);
      }
      
      override public function Update(param1:uint) : void
      {
         ++timer;
         GFX.alpha = 1.5 - timer / 10;
         GFX.scaleX = timer / 10;
         GFX.scaleY = timer / 10;
         if(timer == 10)
         {
            Mario.layerFore.removeChild(GFX);
            Mario.removeEffect(param1);
         }
      }
   }
}
