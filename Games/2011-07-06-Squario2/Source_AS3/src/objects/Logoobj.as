package objects
{
   import flash.display.Sprite;
   import mx.core.BitmapAsset;
   
   public class Logoobj extends Sprite
   {
       
      
      public var a:Number = 0;
      
      public var gfx:BitmapAsset;
      
      public var black:Sprite;
      
      public function Logoobj()
      {
         black = new Sprite();
         super();
      }
      
      public function Step() : void
      {
      }
   }
}
