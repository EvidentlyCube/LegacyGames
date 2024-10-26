/**
* ...
* @author Default
* @version 0.1
*/

package objects {
	import flash.display.*;
	import flash.media.Sound;
	import mx.core.BitmapAsset;
	public class Fireplant extends Obj{
		public var dir:Number;
		public var gravity:Number=0;
		public var oWid:uint=10;
		public var oHei:uint=10;
		public var GFX:Sprite;
		public var hostile:Boolean;
		private var SFXBump:Sound=new (Mario.classSFX.accessSFX("bump"));
		public function Fireplant(typeX:int,typeY:int,obDir:Number,grav:Number){
			oX=typeX;
			oY=typeY;
			dir=obDir;
			gravity=grav
			var GFX2:BitmapAsset=new (Mario.classGFX.AccessGFX("object_radish"));
			GFX2.x=-6;
			GFX2.y=-6;
			GFX=new Sprite();
			GFX.x=oX;
			GFX.y=oY;
			GFX.addChild(GFX2);
			Mario.layerFore.addChild(GFX);
		}
		override public function Update(myID:uint):void{
			if (Mario.playerCollide(oX-4,oY-4,9,9)){Mario.hitPlayer();destroy(myID);return;}
			oX+=dir
			oY+=gravity
			gravity+=Mario.gravity/2
			if (Mario.levelColl(oX,oY)){
				if (Mario.sounds){SFXBump.play();}
				destroy(myID);
				return;
			}
			GFX.x=oX;
			GFX.y=oY;
			GFX.rotation+=10;
		}
		public function destroy(myID:uint):void{
			Mario.layerFore.removeChild(GFX);
			Mario.removeObject(myID);
			Mario.instEffects.push(new Fire_Boom(oX,oY));
		}
	}
}