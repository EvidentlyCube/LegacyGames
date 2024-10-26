package objects 
{
	import flash.display.Shape;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	/**
	* ...
	* @author $(DefaultUser)
	*/
	public class Pauser {
		private var shade:Shape=new Shape;
		//private var mastah:SoundMixer=new SoundMixer;
		public function Pauser(){
			shade.graphics.beginFill(0,0.5);
			shade.graphics.drawRect(0,0,400,375);
			shade.graphics.endFill();
			Mario.layerGover.addChild(shade);
			SoundMixer.soundTransform=new SoundTransform(0.3,0);
		}
		public function kill():void{
			Mario.layerGover.removeChild(shade);
			SoundMixer.soundTransform=new SoundTransform(1,0);
		}
		
	}
	
}