package Classes.Items{
	import flash.display.Sprite;

	public class TItem extends Sprite{
		public function TItem(){}
		public function JumpOff(): void{}
		public function CanLand(): Boolean{return false;}
		public function Remove(): void{}
		public function Undo(): void{}
		public function Boom(): void{}
		public function Land(): void{}
	}
}