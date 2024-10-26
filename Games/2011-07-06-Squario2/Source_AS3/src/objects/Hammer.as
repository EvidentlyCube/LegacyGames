package objects
{
   import flash.display.Sprite;
   import mx.core.BitmapAsset;
   
   public class Hammer extends Obj
   {
       
      
      private var waiter:uint = 0;
      
      private var movY:Number = 0;
      
      private var movX:Number = 0;
      
      private var Troopa:HammerTroopa;
      
      private var GFX:Sprite;
      
      public function Hammer(param1:HammerTroopa)
      {
         GFX = new Sprite();
         super();
         Troopa = param1;
         var _loc2_:BitmapAsset = new (Mario.classGFX.AccessGFX("effect_hammer"))();
         _loc2_.x = -10;
         _loc2_.y = -6;
         GFX.addChild(_loc2_);
         oY = 0;
         oX = 0;
         Mario.layerEffects.addChild(GFX);
      }
      
      public function SetPos() : void
      {
         if(Troopa.dir == 1)
         {
            if(Troopa.frame == 0)
            {
               GFX.rotation = 0;
               GFX.x = Troopa.eX + 16;
               GFX.y = Troopa.eY - 2;
            }
            else
            {
               GFX.rotation = 90;
               GFX.x = Troopa.eX + 28;
               GFX.y = Troopa.eY + 22;
            }
         }
         else if(Troopa.frame == 0)
         {
            GFX.rotation = 0;
            GFX.x = Troopa.eX + 2;
            GFX.y = Troopa.eY - 2;
         }
         else
         {
            GFX.rotation = -90;
            GFX.x = Troopa.eX - 8;
            GFX.y = Troopa.eY + 22;
         }
      }
      
      override public function Update(param1:uint) : void
      {
         ++waiter;
         if(waiter < 30)
         {
            SetPos();
         }
         else if(waiter == 30)
         {
            SetPos();
            oX = GFX.x - 4;
            oY = GFX.y - 4;
            movX = Troopa.dir * (Math.random() + 1) * 2;
            movY = -(Math.random() + 1 * 6);
         }
         else
         {
            oX += movX;
            oY += movY;
            GFX.rotation += movX / 2;
            GFX.x = oX + 4;
            GFX.y = oY + 4;
            movY += Mario.gravity;
            if(Mario.playerCollide(oX,oY,8,8))
            {
               Mario.hitPlayer();
            }
         }
         if(oY > Mario.levelHei * 25 + 250 || oY < -200 || Troopa.dead == true && waiter < 100)
         {
            Mario.removeObject(param1);
            Mario.layerEffects.removeChild(GFX);
         }
      }
   }
}
