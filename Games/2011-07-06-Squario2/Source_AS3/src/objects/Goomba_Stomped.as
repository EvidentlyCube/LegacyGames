package objects
{
   import mx.core.BitmapAsset;
   
   public class Goomba_Stomped extends Effect
   {
       
      
      public var fX:Number;
      
      public var fY:Number;
      
      public var GFX:BitmapAsset;
      
      public var gravity:Number = 0;
      
      public function Goomba_Stomped(param1:Number, param2:Number)
      {
         super();
         timer = 50;
         fX = param1;
         fY = param2;
         var _loc3_:Class = Mario.classGFX.AccessGFX("effect_goomba_stomped");
         GFX = new _loc3_();
         GFX.x = param1 - 2;
         GFX.y = param2 - 4;
         Mario.layerFore.addChild(GFX);
      }
      
      override public function Update(param1:uint) : void
      {
         --timer;
         GFX.alpha = timer / 25;
         gravity += Mario.gravity;
         fY += Math.floor(gravity);
         if(Mario.levelColl(fX,fY + 20) || Mario.levelColl(fX + 20,fY + 20))
         {
            gravity = 0;
            fY = Math.floor(fY / 25) * 25 + 4;
         }
         GFX.x = fX - 2;
         GFX.y = fY - 4;
         if(timer == 0)
         {
            Mario.layerFore.removeChild(GFX);
            Mario.removeEffect(param1);
         }
      }
   }
}
