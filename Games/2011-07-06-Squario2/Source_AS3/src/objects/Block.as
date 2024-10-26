package objects
{
   import flash.media.Sound;
   
   public class Block
   {
       
      
      internal var bX:Number;
      
      internal var bY:Number;
      
      internal var SFXBrick:Sound;
      
      public function Block()
      {
         SFXBrick = new (Mario.classSFX.accessSFX("brick"))();
         super();
      }
      
      public function Headbutt(param1:uint) : void
      {
      }
      
      public function Update(param1:uint) : void
      {
      }
   }
}
