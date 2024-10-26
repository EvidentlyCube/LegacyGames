package objects 
{
	import mx.core.BitmapAsset;
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class Grass extends Effect{
		private var GFX:Array=new Array(3);
		private var frame:uint=0;
		public function Grass(x:uint,y:uint,pos:String="l") {
			frame=Math.abs(-(timer/20)+2)
			GFX[0]=new (Mario.classGFX.AccessGFX("back_grass_"+pos+"1"));
			GFX[1]=new (Mario.classGFX.AccessGFX("back_grass_"+pos+"2"));
			GFX[2]=new (Mario.classGFX.AccessGFX("back_grass_"+pos+"3"));
			GFX[0].x=GFX[1].x=GFX[2].x=x;
			GFX[0].y=GFX[1].y=GFX[2].y=y;
			Mario.layerWall.addChild(GFX[frame]);
		}
		override public function Update(myID:uint):void{
			timer++;
			if (timer%20==0){
				Mario.layerWall.removeChild(GFX[frame])
				frame=Math.abs(-(timer/20)+2)
				if (timer==80) {timer=0;}
				Mario.layerWall.addChild(GFX[frame])
			}
		}
	}
	
}