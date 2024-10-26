package objects
{
   import mx.core.BitmapAsset;
   
   public class Points extends Effect
   {
       
      
      private var GFX:BitmapAsset;
      
      private var fY:int;
      
      public function Points(param1:Number, param2:Number, param3:String)
      {
         super();
         fY = param2;
         var _loc4_:Class = Mario.classGFX.AccessGFX("effect_points_" + param3);
         GFX = new _loc4_();
         GFX.x = Math.floor(param1 - GFX.width / 2);
         GFX.y = fY;
         Mario.layerEffects.addChild(GFX);
         timer = 120;
         switch(param3)
         {
            case "100":
               Mario.Hud.Pnts += 100;
               Mario.Hud.RedrawPnts();
               break;
            case "200":
               Mario.Hud.Pnts += 200;
               Mario.Hud.RedrawPnts();
               break;
            case "500":
               Mario.Hud.Pnts += 500;
               Mario.Hud.RedrawPnts();
               break;
            case "1000":
               Mario.Hud.Pnts += 1000;
               Mario.Hud.RedrawPnts();
               break;
            case "2000":
               Mario.Hud.Pnts += 2000;
               Mario.Hud.RedrawPnts();
               break;
            case "5000":
               Mario.Hud.Pnts += 5000;
               Mario.Hud.RedrawPnts();
               break;
            case "8000":
               Mario.Hud.Pnts += 8000;
               Mario.Hud.RedrawPnts();
               break;
            case "1up":
               ++Mario.Hud.Lives;
               Mario.Hud.RedrawPnts();
         }
      }
      
      override public function Update(param1:uint) : void
      {
         --fY;
         --timer;
         GFX.y = fY;
         GFX.alpha = timer / 30;
         if(timer == 0)
         {
            Mario.removeEffect(param1);
            Mario.layerEffects.removeChild(GFX);
         }
      }
   }
}
