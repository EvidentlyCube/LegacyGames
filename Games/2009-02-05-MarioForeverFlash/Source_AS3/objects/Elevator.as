package objects 
{
	import mx.core.BitmapAsset;
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class Elevator extends Obj{
		protected var wid:uint=25;
		protected var holds:Boolean=false;
		protected var GFX:BitmapAsset;
		public function Elevator(x:uint,y:uint,wid:uint,graph:String){
			oX=x;
			oY=y;
			this.wid=wid
			GFX=new (Mario.classGFX.AccessGFX(graph));
			GFX.x=oX;
			GFX.y=oY;
			Mario.layerWall.addChild(GFX);
		}
		override public function Update(myID:uint):void{
			Act();
			if (!holds){
				if (Player.gravity>0 && Player.pY+Player.pHei-Player.gravity<oY && Mario.playerCollide(oX,oY-2,wid,2)) {
					Player.elev=this;
					holds=true;
					Player.gravity=0;
					Player.pY=oY-Player.pHei;
					Player.ResetGraphic()
				}
			} else {
				if (Mario.playerCollide(oX,oY-2,wid,2)){
					Player.gravity=0;
					Player.pY=oY-Player.pHei;
					Player.ResetGraphic()
				} else {
					this.free();
				}
			}
		}
		public function free():void{
			holds=false;
			Player.elev=null;
		}
		protected function Act():void{
			
		}
	}
	
}