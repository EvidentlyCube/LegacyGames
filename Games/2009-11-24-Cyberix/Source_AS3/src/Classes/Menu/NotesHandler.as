package Classes.Menu{
	import Classes.GFX;

	import flash.display.Sprite;

	import mx.core.BitmapAsset;
	public class NotesHandler{
		private static var notesList:Array = new Array()
		public function NotesHandler(){}
		public static function update():void{
			for(var i:uint = 0;i < notesList.length;i++){
				notesList[i].update()
			}
		}
	}
}