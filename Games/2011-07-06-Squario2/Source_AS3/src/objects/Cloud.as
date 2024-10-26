package objects
{
   public class Cloud extends Effect
   {
       
      
      private var GFX:Array;
      
      private var frame:uint = 0;
      
      public function Cloud(param1:uint, param2:uint)
      {
         GFX = new Array(10);
         super();
         GFX[0] = new (Mario.classGFX.AccessGFX("back_cloud_0"))();
         GFX[1] = new (Mario.classGFX.AccessGFX("back_cloud_1"))();
         GFX[2] = new (Mario.classGFX.AccessGFX("back_cloud_2"))();
         GFX[3] = new (Mario.classGFX.AccessGFX("back_cloud_3"))();
         GFX[4] = new (Mario.classGFX.AccessGFX("back_cloud_4"))();
         GFX[5] = new (Mario.classGFX.AccessGFX("back_cloud_5"))();
         GFX[6] = new (Mario.classGFX.AccessGFX("back_cloud_6"))();
         GFX[7] = new (Mario.classGFX.AccessGFX("back_cloud_7"))();
         GFX[8] = new (Mario.classGFX.AccessGFX("back_cloud_8"))();
         GFX[9] = new (Mario.classGFX.AccessGFX("back_cloud_9"))();
         var _loc3_:int = 0;
         while(_loc3_ < 10)
         {
            GFX[_loc3_].x = param1;
            GFX[_loc3_].y = param2;
            _loc3_++;
         }
         frame = Math.floor(Math.random() * 10);
         timer = Math.floor(Math.random() * 6);
         Mario.layerEffects.addChild(GFX[frame]);
      }
      
      override public function Update(param1:uint) : void
      {
         ++timer;
         if(timer == 6)
         {
            Mario.layerEffects.removeChild(GFX[frame]);
            frame = (frame + 1) % 10;
            Mario.layerEffects.addChild(GFX[frame]);
            timer = 0;
         }
      }
   }
}
