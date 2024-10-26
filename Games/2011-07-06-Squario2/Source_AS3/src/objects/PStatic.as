package objects
{
   public class PStatic extends Enemy
   {
       
      
      private var wait:uint = 0;
      
      private var GFX:Array;
      
      private var frame:uint = 0;
      
      public function PStatic(param1:uint, param2:uint)
      {
         GFX = new Array(3);
         super();
         eX = param1;
         eY = param2;
         frame = Math.abs(-(wait / 4) + 2);
         GFX[0] = new (Mario.classGFX.AccessGFX("enemy_pstatic_1"))();
         GFX[1] = new (Mario.classGFX.AccessGFX("enemy_pstatic_2"))();
         GFX[2] = new (Mario.classGFX.AccessGFX("enemy_pstatic_3"))();
         GFX[0].x = GFX[1].x = GFX[2].x = param1;
         GFX[0].y = GFX[1].y = GFX[2].y = param2;
         Mario.layerWall.addChild(GFX[frame]);
      }
      
      override public function Update(param1:uint) : void
      {
         ++wait;
         if(wait % 4 == 0)
         {
            Mario.layerWall.removeChild(GFX[frame]);
            frame = Math.abs(-(wait / 4) + 2);
            if(wait == 16)
            {
               wait = 0;
            }
            Mario.layerWall.addChild(GFX[frame]);
         }
         if(Mario.playerCollide(eX + 2,eY + 2,21,21))
         {
            Mario.hitPlayer();
         }
      }
      
      override public function FireballHit(param1:uint, param2:int) : Boolean
      {
         return false;
      }
   }
}
