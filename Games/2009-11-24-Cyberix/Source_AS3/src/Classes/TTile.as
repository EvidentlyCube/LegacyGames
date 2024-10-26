package Classes{
	import Classes.Interactivers.TObject;
	import Classes.Items.TItem;
	public class TTile{
		public var Item:TItem = null
		public function TTile(){}
		public function Hit(who:TObject):void{
			if (Item != null){
				Item.Hit(who)
			}
		}
		public function Stomp(who:TObject):void{
			if (Item != null){
				Item.Stomp(who)
			}
		}
		public function Bullet(who:TObject):void{
			if (Item != null){
				Item.Bullet(who)
			}
		}
		public function Set(i:TItem,rem:Boolean = true):void{
			if (Item != null && rem == true){
				Item.Remove()
			}
			Item = i
		}
		public function Remove():void{
			if (Item != null){
				Item.Remove()
			}
			Item = null
		}
		public function At():TItem{
			return Item;
		}
	}
}