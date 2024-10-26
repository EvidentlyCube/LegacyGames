package objects
{
   import flash.display.Sprite;
   import flash.media.Sound;
   import flash.text.TextField;
   import mx.core.BitmapAsset;

   public class TypeHud
   {


      public var debugtext:TextField;

      public var SFXLife:Sound;

      private var GFXP3:BitmapAsset;

      private var GFXP4:BitmapAsset;

      private var GFXP5:BitmapAsset;

      private var GFXP6:BitmapAsset;

      private var wait:uint = 0;

      public var Pnts:int = 0;

      private var GFXX:BitmapAsset;

      private var GFXTIME:BitmapAsset;

      public var SFXHurry:Sound;

      private var GFXMARIO:BitmapAsset;

      private var GFXWORLD:BitmapAsset;

      private var GFXW1:BitmapAsset;

      private var GFXW2:BitmapAsset;

      public var GFX:Sprite;

      private var GFXW3:BitmapAsset;

      public var Coins:int = 0;

      public var Interval:int = 20;

      public var Lives:int = 2;

      private var GFXC2:BitmapAsset;

      private var GFXCOIN:BitmapAsset;

      public var Time:int = 320;

      private var GFXC1:BitmapAsset;

      private var GFXT1:BitmapAsset;

      private var GFXT2:BitmapAsset;

      private var GFXT3:BitmapAsset;

      private var GFXP1:BitmapAsset;

      private var GFXP2:BitmapAsset;

      public function TypeHud()
      {
         var _loc1_:Class = null;
         SFXLife = new (Mario.classSFX.accessSFX("life"))();
         GFX = new Sprite();
         debugtext = new TextField();
         SFXHurry = new (Mario.classSFX.accessSFX("hurry"))();
         super();
         Mario.layerWall.addChild(debugtext);
         _loc1_ = Mario.classGFX.AccessGFX("font_1");
         GFXC1 = new _loc1_();
         GFXC1.x = 0;
         GFXC1.y = 0;
         GFX.addChild(GFXC1);
         _loc1_ = Mario.classGFX.AccessGFX("font_1");
         GFXC2 = new _loc1_();
         GFXC2.x = 1;
         GFXC2.y = 1;
         GFX.addChild(GFXC2);
         _loc1_ = Mario.classGFX.AccessGFX("font_1");
         GFXP1 = new _loc1_();
         GFXP1.x = 1;
         GFXP1.y = 1;
         GFX.addChild(GFXP1);
         _loc1_ = Mario.classGFX.AccessGFX("font_1");
         GFXP2 = new _loc1_();
         GFXP2.x = 1;
         GFXP2.y = 1;
         GFX.addChild(GFXP2);
         _loc1_ = Mario.classGFX.AccessGFX("font_1");
         GFXP3 = new _loc1_();
         GFXP3.x = 1;
         GFXP3.y = 1;
         GFX.addChild(GFXP3);
         _loc1_ = Mario.classGFX.AccessGFX("font_1");
         GFXP4 = new _loc1_();
         GFXP4.x = 1;
         GFXP4.y = 1;
         GFX.addChild(GFXP4);
         _loc1_ = Mario.classGFX.AccessGFX("font_1");
         GFXP5 = new _loc1_();
         GFXP5.x = 1;
         GFXP5.y = 1;
         GFX.addChild(GFXP5);
         _loc1_ = Mario.classGFX.AccessGFX("font_1");
         GFXP6 = new _loc1_();
         GFXP6.x = 1;
         GFXP6.y = 1;
         GFX.addChild(GFXP6);
         _loc1_ = Mario.classGFX.AccessGFX("font_1");
         GFXT1 = new _loc1_();
         GFXT1.x = 1;
         GFXT1.y = 1;
         GFX.addChild(GFXT1);
         _loc1_ = Mario.classGFX.AccessGFX("font_1");
         GFXT2 = new _loc1_();
         GFXT2.x = 1;
         GFXT2.y = 1;
         GFX.addChild(GFXT2);
         _loc1_ = Mario.classGFX.AccessGFX("font_1");
         GFXT3 = new _loc1_();
         GFXT3.x = 1;
         GFXT3.y = 1;
         GFX.addChild(GFXT3);
         _loc1_ = Mario.classGFX.AccessGFX("font_time");
         GFXTIME = new _loc1_();
         GFXTIME.x = 325;
         GFXTIME.y = 20;
         GFX.addChild(GFXTIME);
         _loc1_ = Mario.classGFX.AccessGFX("font_world");
         GFXWORLD = new _loc1_();
         GFXWORLD.x = 200;
         GFXWORLD.y = 20;
         GFX.addChild(GFXWORLD);
         _loc1_ = Mario.classGFX.AccessGFX("font_mario");
         GFXMARIO = new _loc1_();
         GFXMARIO.x = 25;
         GFXMARIO.y = 20;
         GFX.addChild(GFXMARIO);
         _loc1_ = Mario.classGFX.AccessGFX("font_coin_1");
         GFXCOIN = new _loc1_();
         GFXCOIN.x = 120;
         GFXCOIN.y = 35;
         GFX.addChild(GFXCOIN);
         _loc1_ = Mario.classGFX.AccessGFX("font_x");
         GFXX = new _loc1_();
         GFXX.x = 130;
         GFXX.y = 36;
         GFX.addChild(GFXX);
         _loc1_ = Mario.classGFX.AccessGFX("font_1");
         GFXW1 = new _loc1_();
         GFXW1.x = 214;
         GFXW1.y = 35;
         GFX.addChild(GFXW1);
         _loc1_ = Mario.classGFX.AccessGFX("font_-");
         GFXW2 = new _loc1_();
         GFXW2.x = 225;
         GFXW2.y = 35;
         GFX.addChild(GFXW2);
         _loc1_ = Mario.classGFX.AccessGFX("font_1");
         GFXW3 = new _loc1_();
         GFXW3.x = 238;
         GFXW3.y = 35;
         GFX.addChild(GFXW3);
         RedrawWorld();
         RedrawCoins();
         RedrawTime();
         RedrawPnts();
      }

      public function RedrawTime() : void
      {
         GFX.removeChild(GFXT1);
         GFX.removeChild(GFXT2);
         GFX.removeChild(GFXT3);
         var _loc1_:Class = Mario.classGFX.AccessGFX("font_" + Math.floor(Time / 100));
         GFXT1 = new _loc1_();
         _loc1_ = Mario.classGFX.AccessGFX("font_" + Math.floor(Time / 10) % 10);
         GFXT2 = new _loc1_();
         _loc1_ = Mario.classGFX.AccessGFX("font_" + Time % 10);
         GFXT3 = new _loc1_();
         GFXT1.x = 340 + (Time > 99 ? 0 : 1000);
         GFXT1.y = 35;
         GFXT2.x = 352 + (Time > 9 ? 0 : 1000);
         GFXT2.y = 35;
         GFXT3.x = 364;
         GFXT3.y = 35;
         GFX.addChild(GFXT1);
         GFX.addChild(GFXT2);
         GFX.addChild(GFXT3);
      }

      public function RedrawPnts() : void
      {
         GFX.removeChild(GFXP1);
         GFX.removeChild(GFXP2);
         GFX.removeChild(GFXP3);
         GFX.removeChild(GFXP4);
         GFX.removeChild(GFXP5);
         GFX.removeChild(GFXP6);
         var _loc1_:Class = Mario.classGFX.AccessGFX("font_" + Math.floor(Pnts / 100000));
         GFXP1 = new _loc1_();
         _loc1_ = Mario.classGFX.AccessGFX("font_" + Math.floor(Pnts / 10000) % 10);
         GFXP2 = new _loc1_();
         _loc1_ = Mario.classGFX.AccessGFX("font_" + Math.floor(Pnts / 1000) % 10);
         GFXP3 = new _loc1_();
         _loc1_ = Mario.classGFX.AccessGFX("font_" + Math.floor(Pnts / 100) % 10);
         GFXP4 = new _loc1_();
         _loc1_ = Mario.classGFX.AccessGFX("font_" + Math.floor(Pnts / 10) % 10);
         GFXP5 = new _loc1_();
         _loc1_ = Mario.classGFX.AccessGFX("font_" + Pnts % 10);
         GFXP6 = new _loc1_();
         GFXP1.x = 25 + (Pnts > 99999 ? 0 : 1000);
         GFXP1.y = 35;
         GFXP2.x = 37 + (Pnts > 9999 ? 0 : 1000);
         GFXP2.y = 35;
         GFXP3.x = 49 + (Pnts > 999 ? 0 : 1000);
         GFXP3.y = 35;
         GFXP4.x = 61 + (Pnts > 99 ? 0 : 1000);
         GFXP4.y = 35;
         GFXP5.x = 73 + (Pnts > 9 ? 0 : 1000);
         GFXP5.y = 35;
         GFXP6.x = 85;
         GFXP6.y = 35;
         GFX.addChild(GFXP1);
         GFX.addChild(GFXP2);
         GFX.addChild(GFXP3);
         GFX.addChild(GFXP4);
         GFX.addChild(GFXP5);
         GFX.addChild(GFXP6);
      }

      public function RedrawWorld() : void
      {
         var _loc2_:Class = null;
         GFX.removeChild(GFXW1);
         GFX.removeChild(GFXW3);
         var _loc1_:uint = Mario.levelid < 16 ? uint(Math.floor(Mario.levelid / 4) + 1) : 4;
         _loc2_ = Mario.classGFX.AccessGFX("font_" + _loc1_);
         GFXW1 = new _loc2_();
         GFXW1.x = 214;
         GFXW1.y = 35;
         GFX.addChild(GFXW1);
         _loc1_ = Mario.levelid < 16 ? uint(Mario.levelid % 4 + 1) : 5;
         _loc2_ = Mario.classGFX.AccessGFX("font_" + _loc1_);
         GFXW3 = new _loc2_();
         GFXW3.x = 238;
         GFXW3.y = 35;
         GFX.addChild(GFXW3);
      }

      public function RedrawCoins() : void
      {
         GFX.removeChild(GFXC1);
         GFX.removeChild(GFXC2);
         while(Coins > 99)
         {
            Coins -= 100;
            Mario.instEffects.push(new Points(Player.pX,Player.pY,"1up"));
            if(Mario.sounds)
            {
               SFXLife.play();
            }
         }
         var _loc1_:Class = Mario.classGFX.AccessGFX("font_" + Math.floor(Coins / 10));
         GFXC1 = new _loc1_();
         _loc1_ = Mario.classGFX.AccessGFX("font_" + Coins % 10);
         GFXC2 = new _loc1_();
         GFXC1.x = 142;
         GFXC1.y = 35;
         GFXC2.x = 154;
         GFXC2.y = 35;
         GFX.addChild(GFXC1);
         GFX.addChild(GFXC2);
      }

      public function Hud() : Sprite
      {
         return GFX;
      }

      public function Update() : void
      {
         var _loc1_:Class = null;
         if(Mario.playerControllable)
         {
            --Interval;
            if(Interval == 0)
            {
               Interval = 25;
               --Time;
               RedrawTime();
               if(Time == 100)
               {
                  SFXHurry.play();
               }
            }
            if(Time == 0)
            {
               Mario.hitPlayer(true, true);
            }
         }
         wait = (wait + 1) % 30 + 1;
         if(wait % 10 == 2)
         {
            GFX.removeChild(GFXCOIN);
            _loc1_ = Mario.classGFX.AccessGFX("font_coin_" + Math.ceil(wait / 10));
            GFXCOIN = new _loc1_();
            GFXCOIN.x = 115;
            GFXCOIN.y = 35;
            GFX.addChild(GFXCOIN);
         }
      }
   }
}
