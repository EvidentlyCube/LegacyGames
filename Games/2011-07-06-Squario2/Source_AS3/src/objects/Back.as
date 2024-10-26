package objects
{
   import mx.core.BitmapAsset;
   
   public class Back
   {
       
      
      public var gfx1:BitmapAsset;
      
      public var gfx2:BitmapAsset;
      
      public function Back(param1:uint)
      {
         super();
         gfx1 = new (Mario.classGFX.AccessGFX("back_" + param1))();
         gfx2 = new (Mario.classGFX.AccessGFX("back_" + param1))();
         Mario.layerBack2.addChildAt(gfx1,0);
         Mario.layerBack2.addChildAt(gfx2,0);
         Update(0);
      }
      
      public function Update(param1:uint) : void
      {
         if(Player.pX > 0)
         {
            gfx1.x = -((-Mario.scrollX + 200) / 5 % 400);
            gfx2.x = gfx1.x + 400;
         }
         else
         {
            gfx1.x = -(((-Mario.scrollX + 200) / 5 + 4000) % 400);
            gfx2.x = gfx1.x + 400;
         }
      }
   }
}
