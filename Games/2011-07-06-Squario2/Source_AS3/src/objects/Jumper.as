package objects
{
   public class Jumper extends Enemy
   {
       
      
      private var wait:uint = 0;
      
      private var horimov:Number;
      
      private var GFX:Array;
      
      private var frame:uint = 0;
      
      public function Jumper(param1:uint, param2:uint, param3:Number = 0, param4:int = -10)
      {
         GFX = new Array(8);
         super();
         eX = param1;
         eY = param2;
         eWid = 19;
         eHei = 21;
         GFX[0] = new (Mario.classGFX.AccessGFX("enemy_jumper_1"))();
         GFX[1] = GFX[7] = new (Mario.classGFX.AccessGFX("enemy_jumper_2"))();
         GFX[2] = GFX[6] = new (Mario.classGFX.AccessGFX("enemy_jumper_3"))();
         GFX[3] = GFX[5] = new (Mario.classGFX.AccessGFX("enemy_jumper_4"))();
         GFX[4] = new (Mario.classGFX.AccessGFX("enemy_jumper_5"))();
         gravity = param4;
         horimov = param3;
         GFX[0].x = eX + 1;
         GFX[0].y = eY + 2;
         Mario.layerFore.addChild(GFX[0]);
      }
      
      override public function Update(param1:uint) : void
      {
         eY += gravity;
         eX += horimov;
         gravity += Mario.gravity / 2;
         ++wait;
         if(wait == 4)
         {
            Mario.layerFore.removeChild(GFX[frame]);
            frame = (frame + 1) % 3;
            Mario.layerFore.addChild(GFX[frame]);
            wait = 0;
         }
         GFX[frame].x = eX + 1;
         GFX[frame].y = eY + 2 + (gravity < 0 ? 0 : 20);
         GFX[frame].scaleY = gravity < 0 ? 1 : -1;
         if(Mario.playerCollide(eX,eY,eWid,eHei))
         {
            Mario.hitPlayer();
         }
         if(eY > Mario.levelHei * 25 + 200)
         {
            Mario.layerFore.removeChild(GFX[frame]);
            Mario.removeEnemy(param1);
         }
      }
   }
}
