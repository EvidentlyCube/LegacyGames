package objects
{
   import mx.core.BitmapAsset;
   
   public class Background
   {
       
      
      private var bX:Number;
      
      private var bY:Number;
      
      private var GFX:BitmapAsset;
      
      private var parallel:Number;
      
      public function Background(param1:int, param2:int, param3:String, param4:Number = 0)
      {
         super();
         bX = param1;
         bY = param2;
         parallel = param4;
         GFX = new (Mario.classGFX.AccessGFX(param3))();
         GFX.x = bX + (-Mario.scrollX + 200) * parallel;
         GFX.y = bY;
         Mario.layerBack.addChild(GFX);
      }
      
      public function Update(param1:uint) : void
      {
         if(Mario.playerControllable)
         {
            GFX.x = bX + (-Mario.scrollX + 200 - bX) * parallel;
         }
      }
      
      public function Reset(param1:int) : void
      {
         GFX.x = bX + (-Mario.scrollX + 200 - bX) * parallel;
      }
   }
}
