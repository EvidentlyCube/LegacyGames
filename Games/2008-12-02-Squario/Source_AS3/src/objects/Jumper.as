package objects 
{
	
	/**
	* ...
	* @author $(DefaultUser)
	*/
	public class Jumper extends Enemy{
		private var GFX:Array=new Array(3)
		private var frame:uint=0
		private var wait:uint=0
		private var horimov:Number
		public function Jumper(x:uint,y:uint,hor:Number=0,grav:int=-10){
			eX=x
			eY=y
			eWid=19
			eHei=21
			GFX[0]=new (Mario.classGFX.AccessGFX("enemy_jumper_1"));
			GFX[1]=new (Mario.classGFX.AccessGFX("enemy_jumper_2"));
			GFX[2]=new (Mario.classGFX.AccessGFX("enemy_jumper_3"));
			gravity=grav
			horimov=hor
			GFX[0].x=eX+1
			GFX[0].y=eY+2
			Mario.layerFore.addChild(GFX[0])
		}
		override public function Update(myID:uint):void{
			eY+=gravity
			eX+=horimov
			gravity+=Mario.gravity/2
			wait++;
			if (wait==4){
				Mario.layerFore.removeChild(GFX[frame])
				frame=(frame+1)%3
				Mario.layerFore.addChild(GFX[frame])
				wait=0;
			}
			GFX[frame].x=eX+1
			GFX[frame].y=eY+2+(gravity<0?0:20)
			GFX[frame].scaleY=gravity<0?1:-1
			if (Mario.playerCollide(eX,eY,eWid,eHei)){
				Mario.hitPlayer()
			}
			if (eY>Mario.levelHei*25+200){
				Mario.layerFore.removeChild(GFX[frame])
				Mario.removeEnemy(myID)
			}
		}
	}
	
}