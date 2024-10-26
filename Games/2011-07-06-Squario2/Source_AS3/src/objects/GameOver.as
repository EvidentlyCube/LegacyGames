package objects
{
   import flash.media.Sound;
   import mx.core.BitmapAsset;

   public class GameOver extends Obj
   {

      public static var isGO:Boolean = false;


      private var timer:uint = 0;

      private var gfx1:BitmapAsset;

      private var SFXOver:Sound;

      public function GameOver()
      {
         SFXOver = new (Mario.classSFX.accessSFX("gameover"))();
         super();
         isGO = true;
         gfx1 = new (Mario.classGFX.AccessGFX("gameover"))();
         gfx1.x = 400 / 2 - gfx1.width / 2;
         gfx1.y = 80;
         Mario.layerGover.addChild(gfx1);
         if(Mario.music)
         {
            SFXOver.play();
         }
      }

      override public function Update(param1:uint) : void
      {
         var myID:uint = param1;
         ++timer;
         if(timer == 180)
         {
            closiawa();
         }
      }

      public function closiawa() : void
      {
         Mario.Hud.Lives = 2;
         Mario.Hud.Pnts = 0;
         Mario.checkPoint = 0;
         Mario.Hud.RedrawPnts();
         Mario.levelid = Math.max(Mario.levelid - 1,Math.floor(Mario.levelid / 4) * 4);
         Mario.clearLevel();
         Mario.decreaseI = 1;
         isGO = false;
      }
   }
}
