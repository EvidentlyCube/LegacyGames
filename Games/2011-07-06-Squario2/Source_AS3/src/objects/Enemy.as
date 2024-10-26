package objects
{
   import flash.media.Sound;
   
   public class Enemy
   {
       
      
      public var active:Boolean = false;
      
      public var bounce:Boolean = true;
      
      public var SFXKick:Sound;
      
      public var alive:Boolean = true;
      
      public var eX:Number;
      
      public var eY:Number;
      
      public var gravity:Number = 0;
      
      public var dir:Number;
      
      public var eHei:uint;
      
      public var eWid:uint;
      
      public var stomped:Boolean = false;
      
      public var isShell:Boolean = false;
      
      public function Enemy()
      {
         SFXKick = new (Mario.classSFX.accessSFX("kick"))();
         super();
      }
      
      public function Fire(param1:uint, param2:int) : Boolean
      {
         return false;
      }
      
      public function Stomp(param1:uint) : void
      {
      }
      
      public function Update(param1:uint) : void
      {
      }
      
      public function FireballHit(param1:uint, param2:int) : Boolean
      {
         Fire(param1,param2);
         Mario.instEffects.push(new Points(eX + 10,eY - 5,"200"));
         if(Mario.sounds)
         {
            SFXKick.play();
         }
         return true;
      }
   }
}
