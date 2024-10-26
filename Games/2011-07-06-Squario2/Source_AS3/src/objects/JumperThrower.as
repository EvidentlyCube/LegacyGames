package objects
{
   public class JumperThrower extends Enemy
   {
       
      
      private var waiter:uint;
      
      private var amounter:uint;
      
      private var sizeh:Number;
      
      private var sizev:Number;
      
      private var wait:uint;
      
      private var pause:uint;
      
      private var pauser:uint;
      
      private var amount:uint;
      
      public function JumperThrower(param1:uint, param2:uint, param3:Number, param4:Number, param5:uint, param6:uint, param7:uint)
      {
         super();
         eX = param1;
         eY = param2;
         sizeh = param4;
         sizev = param3;
         wait = waiter = param5;
         amount = amounter = param6;
         pause = pauser = param7;
      }
      
      override public function Update(param1:uint) : void
      {
         if(waiter > 0)
         {
            --waiter;
         }
         else if(pauser > 0)
         {
            --pauser;
         }
         else
         {
            --amounter;
            pauser = pause;
            Mario.instEnemies.push(new Jumper(eX,eY,(Math.random() - 0.5) * 2 * sizeh,sizev - Math.random() + Math.random()));
            if(amounter == 0)
            {
               amounter = amount;
               waiter = wait;
            }
         }
      }
   }
}
