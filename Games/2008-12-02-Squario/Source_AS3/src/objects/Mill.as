package objects{
	import flash.display.Sprite;
	import mx.core.BitmapAsset;
	/**
	* ...
	* @author $(DefaultUser)
	*/
	public class Mill extends Obj{
		public var dist:uint
		public var moment:Number
		public var speed:Number
		public var GFX:Sprite=new Sprite
		public var millX:Number
		public var millY:Number
		private static const PI:Number=Math.PI
		public function Mill(x:uint,y:uint,dis:uint,spd:Number,mom:Number=0){
			oX=x+12
			oY=y+12
			dist=dis
			speed=(PI/240)*spd
			moment=mom
			setPos()
			var wall:BitmapAsset=new (Mario.classGFX.AccessGFX("Wall_P"));
			wall.x=x
			wall.y=y
			Mario.layerWall.addChild(wall);
			var GFX2:BitmapAsset=new (Mario.classGFX.AccessGFX("enemy_mill"));
			GFX2.x=-12.5
			GFX2.y=-12.5
			GFX.addChild(GFX2)
			GFX.x=millX+11
			GFX.y=millY+11
			Mario.layerEffects.addChild(GFX)
			Mario.changeLevel(x/25,y/25,"x")
		}
		override public function Update(myID:uint):void{
			moment+=speed
			setPos()
			GFX.rotation+=speed*200
			GFX.x=millX+11
			GFX.y=millY+11
			if (Mario.playerCollide(millX,millY,23,23)){
				Mario.hitPlayer();
			}
		}
		private function setPos():void{
			millX=oX+Math.cos(moment)*dist-11
			millY=oY+Math.sin(moment)*dist-11
		}
	}
	
}