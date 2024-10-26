package objects 
{
	import flash.display.Shape;
	import mx.core.BitmapAsset
	import flash.display.*;
	import flash.geom.*

	/**
	* ...
	* @author $(DefaultUser)
	*/
	public class Lantern extends Effect{
		public var gfx1:BitmapAsset
		public var gfx2:Shape=new Shape
		public var eX:uint
		public function Lantern(x:uint,y:uint){
			gfx1=new (Mario.classGFX.AccessGFX("back_lantern"))
			var fillType:String = GradientType.RADIAL;
			var colors:Array = [0xFFFFFF,0xFFFFFF];
			var alphas:Array = [0.8, 0];
			var ratios:Array = [100, 255];
			var matr:Matrix = new Matrix();
			matr.createGradientBox(100, 100, 0, -50, -50);
			var spreadMethod:String = SpreadMethod.PAD;
			gfx2.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);  
			gfx2.graphics.drawCircle(0,0,50)
			gfx2.graphics.endFill()
			gfx1.x=eX-((-Mario.scrollX+200)-eX)*0.2;
			gfx1.y=y;
			gfx2.x=eX-((-Mario.scrollX+200)-eX)*0.2+9;
			gfx2.y=y+22
			gfx2.blendMode=BlendMode.ADD
			Mario.layerBack2.addChildAt(gfx1,0)
			Mario.layerBack2.addChild(gfx2)
			eX=x
		}
		override public function Update(myID:uint):void{
			gfx1.x=eX-((-Mario.scrollX+200)-eX)*0.2;
			gfx2.x=eX-((-Mario.scrollX+200)-eX)*0.2+9;
			if (Math.random()<0.4){
				gfx2.alpha=0.8+Math.random()/5
				gfx2.scaleX=0.95+gfx2.alpha/5
				gfx2.scaleY=gfx2.scaleX
			}
		}
		
	}
	
}