package objects {
	
	/**
	* ...
	* @author Default
	*/
	import mx.core.BitmapAsset;
	public class Background {
		private var GFX:BitmapAsset;
		private var bX:Number;
		private var bY:Number;
		private var parallel:Number;
		public function Background(obX:int,obY:int,grafa:String,Par:Number=0) {
			bX=obX;
			bY=obY;
			parallel=Par;
			GFX=new (Mario.classGFX.AccessGFX(grafa));
			GFX.x=bX+(-Mario.scrollX+200)*parallel;
			GFX.y=bY;
			Mario.layerBack.addChild(GFX);
		}
		public function Update(myID:uint):void{
			if (Mario.playerControllable){
				GFX.x=bX+((-Mario.scrollX+200)-bX)*parallel;
			}
		}
		public function Reset(xX:int):void{
			GFX.x=bX+((-Mario.scrollX+200)-bX)*parallel;
		}
	}
	
}