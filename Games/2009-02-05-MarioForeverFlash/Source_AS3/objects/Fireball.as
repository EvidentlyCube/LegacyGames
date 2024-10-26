/**
* ...
* @author Default
* @version 0.1
*/

package objects {
	import flash.display.*;
	import flash.media.Sound;
	import mx.core.BitmapAsset;
	public class Fireball extends Obj{
		public var dir:int;
		public var gravity:Number=0;
		public var oWid:uint=10;
		public var oHei:uint=10;
		public var GFX:Sprite;
		public var hostile:Boolean;
		private var SFXBump:Sound=new (Mario.classSFX.accessSFX("bump"));
		public function Fireball(typeX:int,typeY:int,obDir:Number,isHostile:Boolean=false){
			oX=typeX;
			oY=typeY;
			dir=obDir*6;
			hostile=isHostile
			var GFXclass:Class=Mario.classGFX.AccessGFX("object_radish");
			var GFX2:BitmapAsset = new GFXclass;
			GFX2.x=-6;
			GFX2.y=-6;
			GFX=new Sprite();
			GFX.x=oX;
			GFX.y=oY;
			GFX.addChild(GFX2);
			Mario.layerFore.addChild(GFX);
		}
		override public function Update(myID:uint):void{
			if (hostile){
				if (Mario.playerCollide(oX-4,oY-4,9,9)){Mario.hitPlayer();destroy(myID);}
			} else if (Mario.enemyHitFireball(oX-4,oY-4,9,9,dir)){
				destroy(myID);
				return;
			}
		
			oX+=dir;
			if (Mario.levelColl(oX+4*Mario.Sign(dir),oY-4) || Mario.levelColl(oX+4*Mario.Sign(dir),oY+4) || oY>Mario.levelHei*25+100){
				destroy(myID);
				return
				if (Mario.sounds){SFXBump.play();}
			}
			gravity+=Mario.gravity;
			oY+=gravity;
			if (Mario.levelColl(oX-4,oY+4) || Mario.levelColl(oX+4,oY+4)){
				gravity=-5;
				oY=Math.floor((oY+5)/25)*25-5;
			}
			GFX.x=oX;
			GFX.y=oY;
			GFX.rotation+=10;
		}
		public function destroy(myID:uint):void{
			Mario.layerFore.removeChild(GFX);
			Mario.removeObject(myID);
			if (!hostile){Mario.radishNO--;}
			Mario.instEffects.push(new Fire_Boom(oX,oY));
		}
	}
}