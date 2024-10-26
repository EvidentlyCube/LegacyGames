package objects
{
   import mx.core.BitmapAsset;
   
   public class Brick extends Block
   {
       
      
      private var GFX:BitmapAsset;
      
      private var seq:Number = 0;
      
      public function Brick(param1:uint, param2:uint)
      {
         super();
         bX = param1;
         bY = param2;
         var _loc3_:Class = Mario.classGFX.AccessGFX("bonus_brick");
         GFX = new _loc3_();
         GFX.x = bX;
         GFX.y = bY;
         Mario.layerWall.addChild(GFX);
         Mario.changeLevel(bX / 25,bY / 25,"x");
      }
      
      override public function Update(param1:uint) : void
      {
         if(Player.hitHead)
         {
            if(Mario.playerCollide(bX,bY,25,26))
            {
               Mario.headbuttSetDistance(param1,bX);
            }
         }
         if(seq > 0)
         {
            GFX.y = bY - Math.sin(seq) * 10;
            seq -= Math.PI / 10;
         }
         else
         {
            GFX.y = bY;
         }
      }
      
      override public function Headbutt(param1:uint) : void
      {
         Mario.enemyHitFireball(bX,bY - 2,25,2,Player.dir);
         if(Player.pSize >= 0)
         {
            Mario.layerWall.removeChild(GFX);
            Mario.removeBlock(param1);
            Mario.changeLevel(bX / 25,bY / 25," ");
            Mario.instEffects.push(new Enemy_Fire(bX,bY,Player.speed / 100,Mario.classGFX.AccessGFX("bonus_brick")));
            if(Mario.sounds)
            {
               SFXBrick.play();
            }
         }
         else
         {
            seq = Math.PI;
         }
      }
   }
}
