package Classes.Interactivers{
	import Classes.TLevel;

	import Functions.Sign;

	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	public class TFadeWhite extends TObject{
		private var s:Number
		public function TFadeWhite(_x:uint,_y:uint,_spr:DisplayObject,_s:Number = 0.05,_mx:int = 0,_my:int = 0){
			_spr.x=_x
			_spr.y=_y
			var c:ColorTransform = new ColorTransform(1,1,1,1,255,255,255,0)
			transform.colorTransform = c
			alpha = 1.2
			s=_s
			moveX=_mx
			moveY=_my
			addChild(_spr)
			Game.layerEffects.addChild(this)
		}
		override public function Update():void{
			alpha -= s
			if (x%24 == 0 && y%24 == 0){
				TLevel.checkHit(this,x + Sign(moveX) * 24,y + Sign(moveY) * 24)
			}
			x += moveX
			y += moveY

			if (alpha <= 0){
				Remove()
			}
		}
		override public function Stop(who:TObject = null):void{
			moveX = 0
			moveY = 0
		}
		override public function Remove():void{
			Game.layerEffects.removeChild(this)
		}
	}
}