/**[Embed(source='../GFX_BON_BONUS.png')]
* ...
* @author Default
* @version 0.1
*/
package objects {
	import flash.display.*;
	import mx.core.BitmapAsset;
	public class Brick extends Block{
		private var seq:Number=0;
		private var GFX:BitmapAsset;
		public function Brick(Xpos:uint, Ypos:uint):void{
			bX = Xpos;
			bY = Ypos;
			var GFXclass:Class=Mario.classGFX.AccessGFX("bonus_brick");
			GFX = new GFXclass;
			GFX.x=bX;
			GFX.y=bY;
			Mario.layerWall.addChild(GFX);
			Mario.changeLevel(bX/25, bY/25, "x");
		}
		override public function Update(myID:uint):void{
			if (Player.hitHead){
				if (Mario.playerCollide(bX,bY,25,26)){
					Mario.headbuttSetDistance(myID,bX);
				}
			}
			if (seq>0){
				GFX.y=bY-Math.sin(seq)*10;
				seq-=Math.PI/10;
			} else {GFX.y=bY;}
		}
		override public function Headbutt(myID:uint):void{
			Mario.enemyHitFireball(bX,bY-2,25,2,Player.dir)
			if (Player.pSize>=0){
				Mario.layerWall.removeChild(GFX);
				Mario.removeBlock(myID);
				Mario.changeLevel(bX/25, bY/25, " ");
				Mario.instEffects.push(new Enemy_Fire(bX,bY,Player.speed/100,Mario.classGFX.AccessGFX("bonus_brick")))
				if (Mario.sounds){SFXBrick.play();}
			} else {
				seq=Math.PI;
			}
		}
	}
}