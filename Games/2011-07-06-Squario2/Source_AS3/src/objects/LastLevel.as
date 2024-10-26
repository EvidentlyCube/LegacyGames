package objects
{
   public class LastLevel extends Obj
   {
       
      
      public var shroom:Boolean = false;
      
      public var waiter:uint = 0;
      
      public function LastLevel()
      {
         super();
      }
      
      override public function Update(param1:uint) : void
      {
         if(shroom == false && waiter % 50 == 25 && Player.pSize == 0)
         {
            shroom = true;
            Mario.instObjects.push(new Shroom(180,-25));
         }
         ++waiter;
         if(waiter == 360)
         {
            waiter = 0;
            if(Player.pX > 200)
            {
               Mario.instEnemies.push(new Spiny(30,-25));
            }
            else
            {
               Mario.instEnemies.push(new Spiny(355,-25));
            }
         }
      }
   }
}
