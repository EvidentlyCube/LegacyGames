package Classes.Interactivers{
	import Classes.Items.TItem;

	public class TItemAppear extends TObject{
		private var item:*
		private var a:Number
		public function TItemAppear(i:*,_a:int){
			item = i
			a=_a
			Game.layerEffects.addChild(this)
		}
		override public function Update():void{
			if (a > 0){
				if (item.alpha < 1 && a < 2){
					item.alpha += 0.1
					a += 0.1
				} else {
					Remove()
				}
			} else {
				if (item.alpha > 0 && a>-2){
					item.alpha -= 0.1
					a -= 0.1
				} else {
					Remove()
				}
			}
		}
		override public function Remove():void{
			if (Game.layerEffects.contains(this)){Game.layerEffects.removeChild(this)}
			if (item as TItem){
				item.app = null
			}
		}
	}
}