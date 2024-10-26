
package objects {
	import flash.display.Sprite;
	import mx.core.BitmapAsset;
	public class Enemy_Fall extends Effect{
		public var GFX:BitmapAsset;
		public var fX:Number;
		public var fY:Number;
		public var moveY:Number=0;
		public function Enemy_Fall(oX:Number,oY:Number,dir:int,GFXclass:BitmapAsset) {
			GFX=GFXclass
			fX=oX-(dir==-1?-GFX.width:0)
			fY=oY+GFX.height
			GFX.x=fX;
			GFX.y=fY;
			GFX.scaleY=-1
			GFX.scaleX=dir
			Mario.layerFore.addChild(GFX);
		}
		override public function Update(myID:uint):void {
			moveY+=Mario.gravity;
			fY+=moveY;
			GFX.x=fX;
			GFX.y=fY;
			if (fY>Mario.levelHei*25+20){
				Mario.layerFore.removeChild(GFX);
				Mario.removeEffect(myID);
			}
		}
	}
}