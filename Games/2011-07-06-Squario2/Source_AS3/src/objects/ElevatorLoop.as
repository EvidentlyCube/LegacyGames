package objects
{
   public class ElevatorLoop extends Elevator
   {
       
      
      private var grav:int = 0;
      
      public function ElevatorLoop(param1:uint, param2:uint, param3:uint, param4:String, param5:int)
      {
         super(param1,param2,param3,param4);
         grav = param5;
      }
      
      override protected function Act() : void
      {
         if(holds)
         {
            Player.pY += Math.round(grav);
         }
         oY += Math.round(grav);
         GFX.y = oY;
         if(oY > 385)
         {
            oY -= 400;
            free();
         }
         else if(oY < -25)
         {
            oY += 400;
            free();
         }
      }
      
      override public function free() : void
      {
         if(holds)
         {
            super.free();
            Player.gravity = grav;
         }
      }
   }
}
