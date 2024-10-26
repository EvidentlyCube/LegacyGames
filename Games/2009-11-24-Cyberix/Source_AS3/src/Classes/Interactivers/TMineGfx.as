package Classes.Interactivers{
	import Classes.Items.TMine;

	public class TMineGfx extends TObject{
		private var w:TMine
		public function TMineGfx(who:TMine){
			w = who
			Game.layerEffects.addChild(this)
		}
		override public function Update():void{
			w.Update()
		}
		override public function Remove():void{
			Game.layerEffects.removeChild(this)
		}
	}
}