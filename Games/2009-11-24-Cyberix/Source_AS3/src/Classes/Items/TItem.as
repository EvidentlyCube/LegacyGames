package Classes.Items{
	import Classes.Interactivers.TItemAppear;
	import Classes.Interactivers.TObject;

	import flash.display.Sprite;
	public class TItem extends Sprite{
		public var app:TItemAppear
		public function TItem(){}
		public function Hit(who:TObject):void{}
		public function Stomp(who:TObject):void{}
		public function Bullet(who:TObject):void{}
		public function Remove():void{}
		public function Fold(first:Boolean = false):void{
			if (first){
				alpha = 0
				return;
			}
			//Game.layerItems.removeChild(this)
			if (app != null){app.Remove()}

			app = new TItemAppear(this,-1)

		}
		public function Unfold():void{
			Game.layerItems.addChild(this)
			if (app != null){app.Remove()}
			app = new TItemAppear(this,1)
		}
	}
}