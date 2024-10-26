/**
* ...
* @author Default
* @version 0.1
*/
package objects {
	import flash.display.*;
	import mx.core.BitmapAsset;
	public class SpinyShell extends Enemy{
		private var GFX:Sprite=new Sprite();
		public function SpinyShell(Xpos:uint,Ypos:uint) {
			eX = Xpos;
			eY = Ypos;
			eWid = 21;
			eHei = 21;
			gravity=0;
			var GFX2:BitmapAsset=new (Mario.classGFX.AccessGFX("enemy_spiny_shell_1"));	
			GFX2.x=-GFX2.width/2;
			GFX2.y=-GFX2.height/2;
			GFX.addChild(GFX2)
			GFX.x=eX+10;
			GFX.y=eY+10;
			Mario.layerFore.addChild(GFX);
		}
		override public function Update(myID:uint):void{
			gravity+=Mario.gravity/2;
			eY+=gravity;
			gravity=Math.min(20,gravity);
			GFX.rotation+=6;
			GFX.x=eX+10;
			GFX.y=eY+10;
			if (Mario.levelColl(eX,eY+eHei) || Mario.levelColl(eX+eWid-1,eY+eHei)){
				eY=Math.floor((eY+eHei)/25-1)*25+5;
				gravity=0;
				Mario.removeEnemy(myID);
				Mario.layerFore.removeChild(GFX);
				Mario.instEnemies.push(new Spiny(eX,Math.floor(eY/25)*25+4));
				alive=false;
			}
			if (Mario.playerCollide(eX, eY, eWid, eHei)){
				Mario.hitPlayer();
			}
			if (eY>Mario.levelHei*25+250){Fire(myID,1);}
		}
		override public function Fire(myID:uint,dir:int):Boolean {
			Mario.layerFore.removeChild(GFX);
			Mario.removeEnemy(myID);
			Mario.instEffects.push(new Enemy_Fire(eX,eY-4,Mario.Sign(dir)*3,Mario.classGFX.AccessGFX("enemy_spiny_shell_1")));
			return true
		}
	}
}
