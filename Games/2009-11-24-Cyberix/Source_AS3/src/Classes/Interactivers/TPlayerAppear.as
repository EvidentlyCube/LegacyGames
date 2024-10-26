package Classes.Interactivers{
	import Classes.Items.TItem;

	import flash.display.Shape;

	public class TPlayerAppear extends TObject{
		private var p:TPlayer
		private var hor:Shape = new Shape
		private var ver:Shape = new Shape
		public function TPlayerAppear(i:TPlayer){
			p = i
			hor.graphics.beginFill(0xFFFFFF)
			hor.graphics.drawRect(0,-12,600,24)
			hor.graphics.endFill()
			ver.graphics.beginFill(0xFFFFFF)
			ver.graphics.drawRect(-12,0,24,600)
			ver.graphics.endFill()

			alpha = 0.5

			addChild(hor)
			addChild(ver)

			Game.layerEffects.addChild(this)
		}
		override public function Update():void{
			ver.x = p.x + 12
			hor.y = p.y + 12
			alpha -= 0.02
			hor.scaleY *= 0.95
			ver.scaleX *= 0.95
			if (alpha <= 0){
				Remove()
			}
		}
		override public function Remove():void{
			if (Game.layerEffects.contains(this)){Game.layerEffects.removeChild(this)}
		}
	}
}