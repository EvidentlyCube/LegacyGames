package objects
{
   import flash.display.Shape;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   
   public class Pauser
   {
       
      
      private var shade:Shape;
      
      public function Pauser()
      {
         shade = new Shape();
         super();
         shade.graphics.beginFill(0,0.5);
         shade.graphics.drawRect(0,0,400,375);
         shade.graphics.endFill();
         Mario.layerGover.addChild(shade);
         SoundMixer.soundTransform = new SoundTransform(0.3,0);
      }
      
      public function kill() : void
      {
         Mario.layerGover.removeChild(shade);
         SoundMixer.soundTransform = new SoundTransform(1,0);
      }
   }
}
