package Classes{
	import Classes.Items.TItem;
	import Classes.Items.TSteel;
	public class TTile{
		public var Item: TItem
		public function TTile(){}
		public function JumpOff(): void{
			if (Item!=null){
				Item.JumpOff()
			}
		}
		public function CanLand(): Boolean{
			if (Item!=null){
				return Item.CanLand()
			}
			return false
		}
		public function Set(i: TItem, rem: Boolean = true): void{
			if (Item!=null && rem == true){
				Item.Remove()
			}
			Item = i
		}
		public function Remove(): void{
			if (Item!=null){
				Item.Remove()
			}
			Item = null
		}
		public function At(): TItem{
			return Item;
		}
		public function Strip(): void{
			if (Item!=null){
				var i: TSteel = Item as TSteel
				if (i == null){return}
				i.Strip()
			}
		}
		public function Boom(): void{
			if (Item!=null){
				Item.Boom()
			}
		}
		public function Land(): void{
			if (Item!=null){
				Item.Land()
			}
		}
	}
}