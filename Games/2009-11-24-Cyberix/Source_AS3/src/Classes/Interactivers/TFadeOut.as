package Classes.Interactivers{
	import flash.display.DisplayObject;

	public class TFadeOut extends TObject{
		private var s:Number
		public function TFadeOut(_x:uint,_y:uint,_c:DisplayObject,_s:Number = 0.1,_mx:int = 0,_my:int = 0){
			_c.x=_x
			_c.y=_y
			s=_s
			moveX=_mx
			moveY=_my
			addChild(_c)
			Game.layerEffects.addChild(this)
		}
		override public function Update():void{
			alpha -= s
			x += moveX
			y += moveY
			if (alpha <= 0){
				Remove()
			}
		}
		override public function Remove():void{
			Game.layerEffects.removeChild(this)
		}
	}
}