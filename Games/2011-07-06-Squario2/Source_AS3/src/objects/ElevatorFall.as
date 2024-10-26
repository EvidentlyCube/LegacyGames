package objects
{
   public class ElevatorFall extends Elevator
   {
       
      
      private var grav:Number = 0;
      
      private var timer:uint = 0;
      
      public function ElevatorFall(param1:uint, param2:uint, param3:uint, param4:String)
      {
         super(param1,param2,param3,param4);
      }
      
      override protected function Act() : void
      {
         if(holds || timer > 0)
         {
            ++timer;
         }
         if(timer > 30)
         {
            grav += 0.2;
         }
         if(holds)
         {
            Player.pY += Math.round(grav);
         }
         oY += Math.round(grav);
         GFX.y = oY;
      }
      
      override public function free() : void
      {
         super.free();
         Player.gravity = grav;
      }
   }
}
