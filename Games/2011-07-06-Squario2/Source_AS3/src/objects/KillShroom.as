package objects
{
   import flash.media.Sound;
   import mx.core.BitmapAsset;
   
   public class KillShroom extends Obj
   {
       
      
      public var oWid:uint = 21;
      
      private var SFX:Sound;
      
      public var dir:int;
      
      public var gravity:Number = 0;
      
      public var GFX:BitmapAsset;
      
      public var oHei:uint = 21;
      
      public var seq:Boolean = false;
      
      public function KillShroom(param1:uint, param2:uint)
      {
         SFX = new (Mario.classSFX.accessSFX("life"))();
         super();
         oX = param1;
         oY = param2;
         var _loc3_:Class = Mario.classGFX.AccessGFX("object_killshroom");
         GFX = new _loc3_();
         GFX.x = oX;
         GFX.y = oY;
         Mario.layerHide.addChild(GFX);
      }
      
      override public function Update(param1:uint) : void
      {
         var _loc2_:Class = null;
         if(seq)
         {
            oX += dir;
            if(dir > 0)
            {
               if(Mario.levelColl(oX + oWid - 1,oY) || Mario.levelColl(oX + oWid - 1,oY + oHei - 1))
               {
                  dir *= -1;
                  oX += dir;
               }
            }
            else if(Mario.levelColl(oX,oY) || Mario.levelColl(oX,oY + oHei - 1))
            {
               dir *= -1;
               oX += dir;
            }
            gravity += Mario.gravity;
            if(gravity > 10)
            {
               gravity = 10;
            }
            oY += Math.round(gravity);
            if(gravity > 0)
            {
               if(Mario.levelColl(oX,oY + oHei - 1) || Mario.levelColl(oX + oWid - 1,oY + oHei - 1))
               {
                  gravity = 0;
                  oY = Math.floor(oY / 25) * 25 + 4;
               }
            }
            if(Mario.playerCollide(oX,oY,oWid,oHei))
            {
               Mario.hitPlayer(true);
               Mario.layerFore.removeChild(GFX);
               Mario.removeObject(param1);
            }
            GFX.x = oX - 2;
            GFX.y = oY - 4;
         }
         else
         {
            oY -= 0.5;
            GFX.x = oX;
            GFX.y = oY;
            if(Mario.levelColl(oX + 12,oY + 24) == false)
            {
               Mario.layerHide.removeChild(GFX);
               oX += 2;
               oY += 4;
               _loc2_ = Mario.classGFX.AccessGFX("object_killshroom");
               GFX = new _loc2_();
               GFX.x = oX - 2;
               GFX.y = oY - 4;
               Mario.layerFore.addChild(GFX);
               dir = Player.pX - oX > 0 ? 1 : -1;
               seq = true;
            }
         }
         if(oY > Mario.levelHei * 25 + 250)
         {
            Mario.layerFore.removeChild(GFX);
            Mario.removeObject(param1);
         }
      }
   }
}
