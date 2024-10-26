
package objects {
	import flash.display.Sprite;
	import mx.core.BitmapAsset;
	public class Enemy_Fire extends Effect{
		public var GFX:Sprite;
		public var fX:Number;
		public var fY:Number;
		public var moveX:Number;
		public var moveY:Number;
		public function Enemy_Fire(oX:Number,oY:Number,dir:int,GFXclass:Class) {
			moveX=dir;
			moveY=-6;
			var GFX2:BitmapAsset=new GFXclass();
			GFX2.x=-GFX2.width/2;
			GFX2.y=-GFX2.height/2;
			fX=oX+GFX2.width/2;
			fY=oY+GFX2.width/2;
			GFX = new Sprite();
			GFX.x=fX;
			GFX.y=fY;
			GFX.addChild(GFX2);
			Mario.layerFore.addChild(GFX);
		}
		override public function Update(myID:uint):void {
			fX+=moveX;
			moveY+=Mario.gravity;
			fY+=moveY;
			GFX.x=fX;
			GFX.y=fY;
			GFX.rotation+=moveX*4;
			if (fY>Mario.levelHei*25+20){
				Mario.layerFore.removeChild(GFX);
				Mario.removeEffect(myID);
			}
		}
	}
}