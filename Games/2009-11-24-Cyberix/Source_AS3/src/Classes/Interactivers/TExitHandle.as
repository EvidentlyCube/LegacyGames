package Classes.Interactivers{
	import Classes.Items.TExit;
	
	public class TExitHandle extends TObject{
		private var ex:TExit
		public function TExitHandle(_x:TExit){
			ex=_x
		}
		override public function Update():void{
			ex.Update()
		}
		override public function Remove():void{
			Game.layerEffects.removeChild(this)
		}
	}
}