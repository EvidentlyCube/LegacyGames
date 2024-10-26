package objects
{
   import flash.display.Sprite;
   import flash.media.Sound;
   import mx.core.BitmapAsset;
   
   public class Fireplant extends Obj
   {
       
      
      public var hostile:Boolean;
      
      public var oWid:uint = 10;
      
      public var dir:Number;
      
      public var gravity:Number = 0;
      
      public var GFX:Sprite;
      
      private var SFXBump:Sound;
      
      public var oHei:uint = 10;
      
      public function Fireplant(param1:int, param2:int, param3:Number, param4:Number)
      {
         SFXBump = new (Mario.classSFX.accessSFX("bump"))();
         super();
         oX = param1;
         oY = param2;
         dir = param3;
         gravity = param4;
         var _loc5_:BitmapAsset;
         (_loc5_ = new (Mario.classGFX.AccessGFX("object_radish"))()).x = -6;
         _loc5_.y = -6;
         GFX = new Sprite();
         GFX.x = oX;
         GFX.y = oY;
         GFX.addChild(_loc5_);
         Mario.layerFore.addChild(GFX);
      }
      
      public function destroy(param1:uint) : void
      {
         Mario.layerFore.removeChild(GFX);
         Mario.removeObject(param1);
         Mario.instEffects.push(new Fire_Boom(oX,oY));
      }
      
      override public function Update(param1:uint) : void
      {
         if(Mario.playerCollide(oX - 4,oY - 4,9,9))
         {
            Mario.hitPlayer();
            destroy(param1);
            return;
         }
         oX += dir;
         oY += gravity;
         gravity += Mario.gravity / 2;
         if(Mario.levelColl(oX,oY))
         {
            if(Mario.sounds)
            {
               SFXBump.play();
            }
            destroy(param1);
            return;
         }
         GFX.x = oX;
         GFX.y = oY;
         GFX.rotation += 10;
      }
   }
}
