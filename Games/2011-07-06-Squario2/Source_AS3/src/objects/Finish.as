package objects
{
   import flash.media.Sound;
   import mx.core.BitmapAsset;
   
   public class Finish
   {
       
      
      public var GFXBack:BitmapAsset;
      
      public var GFXBar:BitmapAsset;
      
      public var GFXArr:BitmapAsset;
      
      public var collected:Boolean = false;
      
      public var dir:int = 2;
      
      public var fY:int;
      
      public var GFXFore:BitmapAsset;
      
      public var bX:int;
      
      public var bY:int;
      
      public var fX:int;
      
      public var SFXComplete:Sound;
      
      public function Finish(param1:int, param2:int)
      {
         SFXComplete = new (Mario.classSFX.accessSFX("level_complete"))();
         super();
         fX = param1;
         fY = param2;
         bX = param1 + 114;
         bY = 0;
         GFXArr = new (Mario.classGFX.AccessGFX("finish_4"))();
         GFXArr.x = fX;
         GFXArr.y = fY;
         Mario.layerEffects.addChild(GFXArr);
      }
      
      private function Swap() : void
      {
         Mario.playerControllable = false;
         Mario.layerFore.removeChild(Player.GFX2);
         Mario.instEffects.unshift(new PlayerFinish(Player.pX,Player.pY,Player.gravity,Player.speed,Player.frame));
         Mario.classSFX.Play(-1);
         if(Mario.music)
         {
            SFXComplete.play();
         }
      }
      
      public function Update(param1:uint) : void
      {
         if(!collected)
         {
            if(Mario.playerCollide(fX + 20,fY + 20,500,5))
            {
               collected = true;
               Swap();
            }
         }
      }
   }
}
