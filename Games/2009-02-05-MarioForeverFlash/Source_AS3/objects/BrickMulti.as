/**[Embed(source='../GFX_BON_BONUS.png')]
* ...
* @author Default
* @version 0.1
*/
package objects {
	import flash.display.*;
	import flash.media.Sound;
	import mx.core.BitmapAsset;
	public class BrickMulti extends Block{
		private var seq:Number=0;
		private var coins:uint=0
		private var GFX:BitmapAsset;
		private var SFXCoin:Sound=new (Mario.classSFX.accessSFX("coin"));
		public function BrickMulti(Xpos:uint, Ypos:uint, coins:uint=5):void{
			bX = Xpos;
			bY = Ypos;
			this.coins=coins;
			var GFXclass:Class;
			GFXclass=Mario.classGFX.AccessGFX("bonus_brick");
			GFX = new GFXclass;
			GFX.x=bX;
			GFX.y=bY;
			Mario.layerWall.addChild(GFX);
			Mario.changeLevel(bX/25, bY/25, "x");
		}
		override public function Update(myID:uint):void{
			if (coins>0 && Player.hitHead){
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
			seq=Math.PI;
			if (coins>0){
				Mario.enemyHitFireball(bX,bY-2,25,2,Player.dir)
				Mario.Hud.Coins++;
				Mario.Hud.RedrawCoins();
				Mario.instEffects.push(new Coin_Jump(bX+5,bY-22));
				coins-=1
				if (Mario.sounds){SFXCoin.play();}
				if(coins==0){
					Mario.layerWall.removeChild(GFX);
					var GFXclass:Class=Mario.classGFX.AccessGFX("bonus_used");
					GFX = new GFXclass;
					GFX.x=bX;
					GFX.y=bY;
					Mario.layerWall.addChild(GFX);
				}
			}
		}
	}
}