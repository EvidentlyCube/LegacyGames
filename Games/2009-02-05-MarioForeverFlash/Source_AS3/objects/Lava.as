package objects 
{
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class Lava extends Obj{
		public var GFX:Array=new Array(7);
		public var wait:uint=0
		public var frame:uint=0
		public function Lava(x:uint,y:uint){
			GFX[0]=new (Mario.classGFX.AccessGFX("lava_1"));
			GFX[1]=new (Mario.classGFX.AccessGFX("lava_2"));
			GFX[2]=new (Mario.classGFX.AccessGFX("lava_3"));
			GFX[3]=new (Mario.classGFX.AccessGFX("lava_4"));
			GFX[4]=new (Mario.classGFX.AccessGFX("lava_5"));
			GFX[5]=new (Mario.classGFX.AccessGFX("lava_6"));
			GFX[6]=new (Mario.classGFX.AccessGFX("lava_7"));
			GFX[0].x=GFX[1].x=GFX[2].x=GFX[3].x=GFX[4].x=GFX[5].x=GFX[6].x=x
			GFX[0].y=GFX[1].y=GFX[2].y=GFX[3].y=GFX[4].y=GFX[5].y=GFX[6].y=y
			Mario.layerEffects.addChild(GFX[0])
		}
		override public function Update(myID:uint):void{
			wait++;
			if (wait==12){
				Mario.layerEffects.removeChild(GFX[frame])
				frame=(frame+1)%7
				wait=0
				Mario.layerEffects.addChild(GFX[frame])
			}
		}
		
	}
	
}