package objects 
{
	import mx.core.BitmapAsset;
	public function AddGraphic(x:uint,y:uint,txt:String):BitmapAsset{
		var gfx:BitmapAsset=new (Mario.classGFX.AccessGFX(txt));
		gfx.x=x
		gfx.y=y
		return gfx;
	}
	
}