package objects
{
   import flash.display.Shape;
   import flash.display.Sprite;
   import mx.core.BitmapAsset;
   
   public class WaitScreen
   {
       
      
      public var GFX:Sprite;
      
      public var seq:uint = 0;
      
      public var Back:Shape;
      
      public var timer:uint = 0;
      
      public var GFXL2:BitmapAsset;
      
      public var GFXHEAD:BitmapAsset;
      
      public var GFXL1:BitmapAsset;
      
      public var GFXX:BitmapAsset;
      
      public function WaitScreen()
      {
         GFX = new Sprite();
         Back = new Shape();
         super();
         Back.graphics.beginFill(0);
         Back.graphics.drawRect(0,0,400,375);
         GFX.addChild(Back);
      }
      
      public function update() : uint
      {
         var _loc1_:Class = null;
         switch(seq)
         {
            case 0:
               Mario.Hud.RedrawWorld();
               Mario.classSFX.Play();
               _loc1_ = Mario.classGFX.AccessGFX("font_head");
               GFXHEAD = new _loc1_();
               _loc1_ = Mario.classGFX.AccessGFX("font_x");
               GFXX = new _loc1_();
               GFXHEAD.x = 171;
               GFXHEAD.y = 180;
               GFXX.x = 200;
               GFXX.y = 191;
               GFX.addChild(GFXHEAD);
               GFX.addChild(GFXX);
               setVar(Mario.Hud.Lives);
               seq = 1;
               return 0;
            case 1:
               ++timer;
               if(timer == 50)
               {
                  timer = 0;
                  seq = 2;
               }
               return 1;
            case 2:
               clearAll();
               seq = 0;
               if(Mario.music)
               {
                  Mario.classSFX.Play(Mario.musika);
               }
               Mario.self.ingameStep();
               return 2;
            default:
               return 1;
         }
      }
      
      public function setVar(param1:uint) : void
      {
         var _loc2_:Class = Mario.classGFX.AccessGFX("font_" + Math.floor(param1 / 10));
         GFXL1 = new _loc2_();
         _loc2_ = Mario.classGFX.AccessGFX("font_" + param1 % 10);
         GFXL2 = new _loc2_();
         GFXL1.x = 217;
         GFXL1.y = 190;
         GFXL2.x = 229;
         GFXL2.y = 190;
         GFX.addChild(GFXL1);
         GFX.addChild(GFXL2);
      }
      
      public function clearAll() : void
      {
         GFX.removeChild(GFXL1);
         GFX.removeChild(GFXL2);
         GFX.removeChild(GFXHEAD);
         GFX.removeChild(GFXX);
      }
   }
}
