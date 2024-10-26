package objects
{
   import flash.display.Sprite;
   import flash.media.Sound;
   import mx.core.BitmapAsset;
   
   public class Fireball extends Obj
   {
       
      
      public var hostile:Boolean;
      
      public var oWid:uint = 10;
      
      public var dir:int;
      
      public var gravity:Number = 0;
      
      public var GFX:Sprite;
      
      private var SFXBump:Sound;
      
      public var oHei:uint = 10;
      
      public function Fireball(param1:int, param2:int, param3:Number, param4:Boolean = false, param5:Number = 1)
      {
         SFXBump = new (Mario.classSFX.accessSFX("bump"))();
         super();
         oX = param1;
         oY = param2;
         dir = param3 * 6;
         gravity = (Math.random() - Math.random()) * param5;
         hostile = param4;
         var _loc7_:BitmapAsset;
         var _loc6_:Class;
         (_loc7_ = new (_loc6_ = Mario.classGFX.AccessGFX("object_radish"))()).x = -6;
         _loc7_.y = -6;
         GFX = new Sprite();
         GFX.x = oX;
         GFX.y = oY;
         GFX.addChild(_loc7_);
         Mario.layerFore.addChild(GFX);
      }
      
      public function destroy(param1:uint) : void
      {
         Mario.layerFore.removeChild(GFX);
         Mario.removeObject(param1);
         if(!hostile)
         {
            --Mario.radishNO;
         }
         Mario.instEffects.push(new Fire_Boom(oX,oY));
      }
      
      override public function Update(param1:uint) : void
      {
         if(hostile)
         {
            if(Mario.playerCollide(oX - 4,oY - 4,9,9))
            {
               Mario.hitPlayer();
               destroy(param1);
            }
         }
         else if(Mario.enemyHitFireball(oX - 4,oY - 4,9,9,dir) || Math.abs(Player.pX - oX) > 300)
         {
            destroy(param1);
            return;
         }
         oX += dir;
         oY += gravity;
         if(Mario.levelColl(oX + 4 * Mario.Sign(dir),oY - 4) || Mario.levelColl(oX + 4 * Mario.Sign(dir),oY + 4) || oY > Mario.levelHei * 25 + 100)
         {
            destroy(param1);
            return;
         }
         GFX.x = oX;
         GFX.y = oY;
         GFX.rotation += 10;
      }
   }
}
