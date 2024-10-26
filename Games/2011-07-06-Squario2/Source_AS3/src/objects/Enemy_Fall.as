package objects
{
   import mx.core.BitmapAsset;
   
   public class Enemy_Fall extends Effect
   {
       
      
      public var fX:Number;
      
      public var fY:Number;
      
      public var moveY:Number = 0;
      
      public var GFX:BitmapAsset;
      
      public function Enemy_Fall(param1:Number, param2:Number, param3:int, param4:BitmapAsset)
      {
         super();
         GFX = param4;
         fX = param1 - (param3 == -1 ? -GFX.width : 0);
         fY = param2 + GFX.height;
         GFX.x = fX;
         GFX.y = fY;
         GFX.scaleY = -1;
         GFX.scaleX = param3;
         Mario.layerFore.addChild(GFX);
      }
      
      override public function Update(param1:uint) : void
      {
         moveY += Mario.gravity;
         fY += moveY;
         GFX.x = fX;
         GFX.y = fY;
         if(fY > Mario.levelHei * 25 + 20)
         {
            Mario.layerFore.removeChild(GFX);
            Mario.removeEffect(param1);
         }
      }
   }
}
