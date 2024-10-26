package objects
{
   import flash.display.Sprite;
   import mx.core.BitmapAsset;
   
   public class Gamend_Fire extends Effect
   {
       
      
      public var fX:Number;
      
      public var fY:Number;
      
      public var moveX:Number;
      
      public var moveY:Number;
      
      public var GFX:Sprite;
      
      public function Gamend_Fire(param1:Number, param2:Number, param3:int, param4:String)
      {
         var _loc5_:BitmapAsset = null;
         super();
         moveX = param3;
         moveY = -6 - Math.random() * 5;
         _loc5_ = new (Mario.classGFX.AccessGFX(param4))();
         _loc5_.x = -_loc5_.width / 2;
         _loc5_.y = -_loc5_.height / 2;
         fX = param1 + _loc5_.width / 2;
         fY = param2 + _loc5_.width / 2;
         GFX = new Sprite();
         GFX.x = fX;
         GFX.y = fY;
         GFX.addChild(_loc5_);
         Mario.layerHide.addChildAt(GFX,0);
      }
      
      override public function Update(param1:uint) : void
      {
         fX += moveX;
         moveY += Mario.gravity;
         fY += moveY;
         GFX.x = fX;
         GFX.y = fY;
         GFX.rotation += moveX * 4;
         if(fY > Mario.levelHei * 25 + 20)
         {
            Mario.layerHide.removeChild(GFX);
            Mario.removeEffect(param1);
         }
      }
   }
}
