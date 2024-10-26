package objects 
{
	import mx.core.BitmapAsset
	import flash.display.Shape;
	
	/**
	* ...
	* @author $(DefaultUser)
	*/
	public class BowserFlame extends Effect{
		public var eX:uint
		public var eY:uint
		public var dir:int
		public var GFX:Array=new Array(3)
		public var frame:uint=0
		public var newy:uint
		
		public function BowserFlame(x:uint,y:uint,dire:int,ny:uint){
			GFX[0]=new (Mario.classGFX.AccessGFX("bowser_flame_1"));
			GFX[1]=new (Mario.classGFX.AccessGFX("bowser_flame_2"));
			GFX[2]=new (Mario.classGFX.AccessGFX("bowser_flame_3"));
			eX=x
			eY=y
			dir=dire
			newy=ny
			GFX[0].scaleX=dir
			GFX[1].scaleX=dir
			GFX[2].scaleX=dir
			GFX[frame].x=eX+(dir==-1?41:-16)
			GFX[frame].y=eY-3
			Mario.layerFore.addChildAt(GFX[0],0)
		}
		override public function Update(myID:uint):void{
			timer++;
			if (timer==6){
				Mario.layerFore.removeChild(GFX[frame])
				frame=(frame+1)%3
				Mario.layerFore.addChildAt(GFX[frame],0)
				timer=0
			}
			eX+=dir*3
			if (eY!=newy){
				eY+=Mario.Sign(newy-eY)*Math.min(2,Math.abs(newy-eY))
			}
			GFX[frame].x=eX+(dir==-1?41:-16)
			GFX[frame].y=eY-3
			if (Math.abs(eX-Player.pX)>500){
				Mario.layerFore.removeChild(GFX[frame])
				Mario.removeEffect(myID)
			}
			if (Mario.playerCollide(eX,eY,25,17)){
				Mario.hitPlayer();
			}
		}
	}
	
}