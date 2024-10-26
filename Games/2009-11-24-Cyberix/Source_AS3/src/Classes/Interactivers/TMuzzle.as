package Classes.Interactivers{
	import mx.core.BitmapAsset;

	public class TMuzzle extends TObject{
		[Embed("../../../assets/gfx/gameplay/Muzzle.png")] private var g:Class

		public function TMuzzle(_x:uint,_y:uint,_dir:uint){
			x=_x
			y=_y
			var m:BitmapAsset = new g;
			switch(_dir){
				case(0):
					m.x=-12
					m.y=-12
					break;
				case(1):
					m.rotation = 90
					m.x = 36
					m.y=-12
					break
				case(2):
					m.rotation = 180
					m.x = 36
					m.y = 36
					break
				case(3):
					m.rotation=-90
					m.x=-12
					m.y=+36
					break
			}
			blendMode = "add"
			addChild(m)
			Game.layerEffects.addChild(this)
		}
		override public function Update():void{
			alpha -= 0.01
			if (alpha <= 0.98){
				alpha -= 0.1
				if (alpha <= 0){
					Remove()
				}
			}
		}
		override public function Remove():void{
			Game.layerEffects.removeChild(this)
		}
	}
}