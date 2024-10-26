package objects
{
   import mx.core.BitmapAsset;
   
   public class Elevator extends Obj
   {
       
      
      protected var wid:uint = 25;
      
      protected var holds:Boolean = false;
      
      protected var GFX:BitmapAsset;
      
      public function Elevator(param1:uint, param2:uint, param3:uint, param4:String)
      {
         super();
         oX = param1;
         oY = param2;
         this.wid = param3;
         GFX = new (Mario.classGFX.AccessGFX(param4))();
         GFX.x = oX;
         GFX.y = oY;
         Mario.layerWall.addChild(GFX);
      }
      
      override public function Update(param1:uint) : void
      {
         Act();
         if(!holds)
         {
            if(Player.gravity > 0 && Player.pY + Player.pHei - Player.gravity < oY && Mario.playerCollide(oX,oY - 2,wid,2))
            {
               Player.elev = this;
               holds = true;
               Player.gravity = 0;
               Player.pY = oY - Player.pHei;
               Player.ResetGraphic();
            }
         }
         else if(Mario.playerCollide(oX,oY - 2,wid,2))
         {
            Player.gravity = 0;
            Player.pY = oY - Player.pHei;
            Player.ResetGraphic();
         }
         else
         {
            this.free();
         }
      }
      
      protected function Act() : void
      {
      }
      
      public function free() : void
      {
         holds = false;
         Player.elev = null;
      }
   }
}
