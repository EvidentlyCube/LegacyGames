package Classes.Interactivers{
	import Classes.Items.TCannon;

	public class TCanonKill extends TObject{
		private var can:TCannon
		private var wait:uint
		public function TCanonKill(c:TCannon){
			if (c.Kill){return}
			can = c
			wait = 30
			Game.layerEffects.addChild(this)
		}
		override public function Update():void{
			wait--
			if (wait == 0){
				can.Explode()
			}
		}
		override public function Remove():void{
			can = null
			Game.layerEffects.removeChild(this)
		}
		override public function Stop(who:TObject = null):void{
			Remove()
		}

	}
}