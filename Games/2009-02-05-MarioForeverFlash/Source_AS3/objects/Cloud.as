package objects 
{
	import mx.core.BitmapAsset;
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class Cloud extends Effect{
		private var GFX:Array=new Array(3);
		private var frame:uint=0;
		public function Cloud(x:uint,y:uint) {
			GFX[0]=new (Mario.classGFX.AccessGFX("back_cloud_1"));
			GFX[1]=new (Mario.classGFX.AccessGFX("back_cloud_2"));
			GFX[2]=new (Mario.classGFX.AccessGFX("back_cloud_3"));
			GFX[0].x=GFX[1].x=GFX[2].x=x;
			GFX[0].y=GFX[1].y=GFX[2].y=y;
			Mario.layerEffects.addChild(GFX[0]);
		}
		override public function Update(myID:uint):void{
			timer++;
			if (timer==20){
				Mario.layerEffects.removeChild(GFX[frame])
				frame=(frame+1)%3
				Mario.layerEffects.addChild(GFX[frame])
				timer=0
			}
		}
	}
	
}