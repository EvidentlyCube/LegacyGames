package objects
{
   public class ElevatorBounce extends Elevator
   {
       
      
      private var dir:int;
      
      public function ElevatorBounce(param1:uint, param2:uint, param3:uint, param4:String, param5:int = 1)
      {
         super(param1,param2,param3,param4);
         dir = param5;
      }
      
      override protected function Act() : void
      {
         if(Mario.levelid == 16)
         {
            if(Mario.levelColl(oX + dir * 25,oY) || Mario.levelColl(oX + wid - 1 + dir * 25,oY))
            {
               dir *= -1;
            }
         }
         else if(Mario.levelColl(oX + dir,oY) || Mario.levelColl(oX + wid - 1 + dir,oY))
         {
            dir *= -1;
         }
         if(holds)
         {
            Player.pX += dir;
         }
         oX += dir;
         GFX.x = oX;
      }
      
      override public function free() : void
      {
         super.free();
      }
   }
}
