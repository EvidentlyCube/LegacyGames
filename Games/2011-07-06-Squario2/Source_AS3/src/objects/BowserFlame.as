package objects
{
   public class BowserFlame extends Effect
   {
       
      
      public var GFX:Array;
      
      public var frame:uint = 0;
      
      public var eX:uint;
      
      public var eY:uint;
      
      public var newy:uint;
      
      public var dir:Number;
      
      public function BowserFlame(param1:uint, param2:uint, param3:Number, param4:uint)
      {
         GFX = new Array(9);
         super();
         GFX[0] = new (Mario.classGFX.AccessGFX("bowser_flame_1"))();
         GFX[1] = new (Mario.classGFX.AccessGFX("bowser_flame_2"))();
         GFX[2] = new (Mario.classGFX.AccessGFX("bowser_flame_3"))();
         GFX[3] = new (Mario.classGFX.AccessGFX("bowser_flame_4"))();
         GFX[4] = new (Mario.classGFX.AccessGFX("bowser_flame_5"))();
         GFX[5] = new (Mario.classGFX.AccessGFX("bowser_flame_6"))();
         GFX[6] = new (Mario.classGFX.AccessGFX("bowser_flame_7"))();
         GFX[7] = new (Mario.classGFX.AccessGFX("bowser_flame_8"))();
         GFX[8] = new (Mario.classGFX.AccessGFX("bowser_flame_9"))();
         eX = param1;
         eY = param2;
         dir = param3;
         newy = param4;
         GFX[0].scaleX = dir;
         GFX[1].scaleX = dir;
         GFX[2].scaleX = dir;
         GFX[3].scaleX = dir;
         GFX[4].scaleX = dir;
         GFX[5].scaleX = dir;
         GFX[6].scaleX = dir;
         GFX[7].scaleX = dir;
         GFX[8].scaleX = dir;
         GFX[frame].x = eX + (dir == -1 ? 41 : -16);
         GFX[frame].y = eY - 3;
         Mario.layerFore.addChildAt(GFX[0],0);
      }
      
      override public function Update(param1:uint) : void
      {
         ++timer;
         if(timer == 2)
         {
            Mario.layerFore.removeChild(GFX[frame]);
            frame = (frame + 1) % 9;
            Mario.layerFore.addChildAt(GFX[frame],0);
            timer = 0;
         }
         eX += dir * 3;
         if(eY != newy)
         {
            eY += Mario.Sign(newy - eY) * Math.min(2,Math.abs(newy - eY));
         }
         GFX[frame].x = eX + (dir == -1 ? 41 : -16);
         GFX[frame].y = eY - 3;
         if(Math.abs(eX - Player.pX) > 500)
         {
            Mario.layerFore.removeChild(GFX[frame]);
            Mario.removeEffect(param1);
         }
         if(Mario.playerCollide(eX,eY,25,17))
         {
            Mario.hitPlayer();
         }
      }
   }
}
