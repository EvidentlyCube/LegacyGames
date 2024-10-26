package objects
{
   import flash.media.Sound;
   import mx.core.BitmapAsset;
   
   public class Cannon extends Obj
   {
       
      
      private var wait:uint;
      
      private var GFX:BitmapAsset;
      
      private var SFX:Sound;
      
      public function Cannon(param1:uint, param2:uint)
      {
         SFX = new (Mario.classSFX.accessSFX("cannon"))();
         super();
         oX = param1;
         oY = param2;
         wait = 60 + Math.floor(Math.random() * 100);
         GFX = new (Mario.classGFX.AccessGFX("Wall_T"))();
         GFX.x = oX;
         GFX.y = oY;
         Mario.layerEffects.addChild(GFX);
         Mario.changeLevel(oX / 25,oY / 25,"x");
      }
      
      override public function Update(param1:uint) : void
      {
         var _loc2_:Bullet = null;
         --wait;
         if(wait == 0)
         {
            if(Player.pX < oX - 100 || Player.pX > oX + 100 && Math.abs(Player.pX - oX) < 300)
            {
               _loc2_ = new Bullet(oX + 2,oY + 3);
               Mario.instEnemies.push(_loc2_);
               if(_loc2_.eX < Player.pX + 300 && _loc2_.eX > Player.pX - 300)
               {
                  if(Mario.sounds)
                  {
                     SFX.play();
                  }
               }
            }
            wait = 60 + Math.floor(Math.random() * 100);
         }
      }
   }
}
