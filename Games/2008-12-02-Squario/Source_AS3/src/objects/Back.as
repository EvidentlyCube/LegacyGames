package objects 
{
	import mx.core.BitmapAsset;
	/**
	* ...
	* @author $(DefaultUser)
	*/
	public class Back{
		public var gfx1:BitmapAsset
		public var gfx2:BitmapAsset
		public function Back(bit:uint){
			gfx1=new (Mario.classGFX.AccessGFX("back_"+bit));
			gfx2=new (Mario.classGFX.AccessGFX("back_"+bit));
			Mario.layerBack2.addChildAt(gfx1,0)
			Mario.layerBack2.addChildAt(gfx2,0)
			Update(0)
		}
		public function Update(myID:uint):void{
			if (Player.pX>0){
				gfx1.x=-((-Mario.scrollX+200)/5%400)
				gfx2.x=gfx1.x+400
			} else {
				gfx1.x=-(((-Mario.scrollX+200)/5+4000)%400)
				gfx2.x=gfx1.x+400
			}
		}
		
	}
	
}