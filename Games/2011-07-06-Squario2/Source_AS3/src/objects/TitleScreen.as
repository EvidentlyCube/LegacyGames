package objects
{
   import flash.display.Sprite;
   import mx.core.BitmapAsset;

   public class TitleScreen
   {

      [Embed(source="../../assets/gfx/ui/TitleScreen_Text1.png")] private var Text1:Class;
      [Embed(source="../../assets/gfx/ui/TitleScreen_Logo.png")] private var Logo:Class;
      [Embed(source="../../assets/gfx/ui/TitleScreen_Text2.png")] private var Text2:Class;
      [Embed(source="../../assets/gfx/ui/TitleScreen_Keys.png")] private var Keys:Class;

      private var timer:uint = 0;

      private var GFXK:BitmapAsset;

      private var GFXL:BitmapAsset;
      private var Cloud:BitmapAsset;
      private var GFXP:BitmapAsset;
      private var Hill:BitmapAsset;
      private var GFXfloor:Sprite;
      private var pX:uint = 600;
      public var sel:uint = 1;
      private var frame:uint = 0;
      private var GFXT1:BitmapAsset;
      private var GFXT2:BitmapAsset;

      public function TitleScreen()
      {
         var _loc2_:BitmapAsset = null;
         var _loc3_:uint = 0;
         var _loc4_:BitmapAsset = null;
         GFXfloor = new Sprite();
         Hill = new (Mario.classGFX.AccessGFX("back_hill_big"))();
         Cloud = new (Mario.classGFX.AccessGFX("back_clouds_8"))();
         GFXP = new (Mario.classGFX.AccessGFX("object_mario0_walk_1"))();
         super();
         GFXL = new Logo();
         GFXK = new Keys();
         GFXT1 = new Text1();
         GFXT2 = new Text2();
         Mario.generateBackground(0);
         Mario.layerGover.addChild(Hill);
         Mario.layerGover.addChild(Cloud);
         Mario.layerGover.addChild(GFXfloor);
         Mario.layerGover.addChild(GFXL);
         Mario.layerGover.addChild(GFXK);
         Mario.layerGover.addChild(GFXT1);
         Mario.layerGover.addChild(GFXT2);
         Mario.layerGover.addChild(GFXP);
         GFXP.x = pX;
         GFXL.x = 420;
         GFXL.y = 20;
         GFXK.x = 400 - GFXK.width;
         GFXK.y = 375 - GFXK.height;
         GFXK.alpha = 0;
         GFXT1.alpha = 0;
         GFXT2.alpha = 0;
         GFXT1.y = 280;
         GFXT2.y = 320;
         Hill.x = 200;
         Cloud.x = -200;
         Cloud.y = 200;
         var _loc1_:uint = 0;
         while (_loc1_ < 18)
         {
            _loc2_ = new (Mario.classGFX.AccessGFX("Wall_d"))();
            _loc2_.y = 11 * 25;
            _loc2_.x = _loc1_ * 25;
            GFXfloor.addChild(_loc2_);
            _loc3_ = 12;
            while (_loc3_ < 15)
            {
               (_loc4_ = new (Mario.classGFX.AccessGFX("Wall_g"))()).y = _loc3_ * 25;
               _loc4_.x = _loc1_ * 25;
               GFXfloor.addChild(_loc4_);
               _loc3_++;
            }
            _loc1_++;
         }
         Mario.classSFX.Play(6);
      }

      public function Update():void
      {
         GFXfloor.x = (25 + GFXfloor.x - 3) % 25 - 25;
         Hill.x -= 0.08;
         Cloud.x -= 0.12;
         if (Hill.x < -Hill.width)
         {
            Hill.x += Hill.width + 400;
         }
         if (Cloud.x < -Cloud.width)
         {
            Cloud.x += Cloud.width + 400;
         }
         ++ timer;
         if (timer % 4 == 0)
         {
            Mario.layerGover.removeChild(GFXP);
            frame = (frame + 1) % 16;
            GFXP = new (Mario.classGFX.AccessGFX("object_mario0_walk_" + frame))();
            Mario.layerGover.addChild(GFXP);
         }
         GFXP.x = pX;
         GFXP.y = 228;
         pX = Math.max(190, pX - 1);
         GFXL.x = Math.max(200 - GFXL.width / 2, GFXL.x - 1);
         if (timer > 350 && timer < 400)
         {
            GFXK.alpha = Math.min(1, GFXK.alpha + 0.05);
            GFXT1.alpha = Math.min(0.5, GFXT1.alpha + 0.05);
            GFXT2.alpha = Math.min(1, GFXT2.alpha + 0.025);
         }
         if (timer < 400)
         {
            if (Mario.isKeyPressed(4) || Mario.isKeyPressed(6) || Mario.isKeyPressed(7))
            {
               pX = 190;
               GFXL.x = 200 - GFXL.width / 2;
               GFXK.alpha = 1;
               GFXT1.alpha = 0.5;
               GFXT2.alpha = 1;
               timer = 400;
            }
         }
         else
         {
            if (Mario.isKeyPressed(1) || Mario.isKeyPressed(3))
            {
               sel = 1 - sel;
               if (sel == 0)
               {
                  GFXT1.alpha = 1;
                  GFXT2.alpha = 0.5;
               }
               else
               {
                  GFXT1.alpha = 0.5;
                  GFXT2.alpha = 1;
               }
            }
            if (Mario.isKeyPressed(4) || Mario.isKeyPressed(6) || Mario.isKeyPressed(7))
            {
               Mario.Hud.Pnts = 0;
               Mario.Hud.RedrawPnts();
               Mario.checkPoint = 0;
               if (sel == 0)
               {
                  sel = 10;
               }
               else
               {
                  sel = 11;
               }
            }
         }
      }
   }
}
