package objects
{
   import mx.core.BitmapAsset;
   
   public class DeadMario extends Effect
   {
       
      
      private var grav:Number = -5;
      
      private var fX:int;
      
      private var fY:int;
      
      private var GFX:BitmapAsset;
      
      public function DeadMario(param1:int, param2:int)
      {
         super();
         fX = param1;
         fY = param2;
         timer = 0;
         GFX = new (Mario.classGFX.AccessGFX("object_mario_dead"))();
         GFX.x = fX;
         GFX.y = fY;
         Mario.layerEffects.addChild(GFX);
      }
      
      override public function Update(param1:uint) : void
      {
         ++timer;
         if(timer > 40)
         {
            fY += grav;
            if(timer > 60)
            {
               grav = Math.min(grav + Mario.gravity,5);
            }
            GFX.y = fY;
            if(fY > Mario.levelHei * 25 + 150)
            {
               Mario.removeEffect(param1);
               Mario.layerEffects.removeChild(GFX);
               if(Mario.Hud.Lives == 0)
               {
                  Mario.instObjects.push(new GameOver());
               }
               else
               {
                  --Mario.Hud.Lives;
                  Mario.clearLevel();
                  Mario.decreaseI = 1;
               }
            }
         }
      }
   }
}
