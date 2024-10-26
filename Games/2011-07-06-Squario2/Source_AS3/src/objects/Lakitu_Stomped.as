package objects
{
   import mx.core.BitmapAsset;
   
   public class Lakitu_Stomped extends Effect
   {
       
      
      public var fY:Number;
      
      public var GFX:BitmapAsset;
      
      public var gravity:Number = 0;
      
      public function Lakitu_Stomped(param1:Number, param2:Number)
      {
         super();
         fY = param2 + 37;
         var _loc3_:Class = Mario.classGFX.AccessGFX("enemy_lakitu_1");
         GFX = new _loc3_();
         GFX.scaleY = -1;
         GFX.x = param1;
         GFX.y = fY;
         Mario.layerFore.addChild(GFX);
      }
      
      override public function Update(param1:uint) : void
      {
         gravity += Mario.gravity;
         fY += gravity;
         GFX.y = fY;
         if(fY > Mario.levelHei * 25 + 80)
         {
            Mario.layerFore.removeChild(GFX);
            Mario.removeEffect(param1);
         }
      }
   }
}
