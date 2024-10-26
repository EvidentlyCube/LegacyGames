package Obs
{
	import flash.media.Sound;
	import mx.core.BitmapAsset;
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class Block {
		[Embed(source = "/../assets/gfx/gfx1.png")] private var GF1:Class;
		[Embed(source = "/../assets/gfx/gfx2.png")] private var GF2:Class;
		[Embed(source = "/../assets/gfx/gfx3.png")] private var GF3:Class;
		[Embed(source = "/../assets/gfx/gfx6.png")] private var GF4:Class;
		[Embed(source = "/../assets/gfx/gfx9.png")] private var GF5:Class;
		[Embed(source = "/../assets/sfx/hit.mp3")] private var S1:Class;
		[Embed(source = "/../assets/sfx/hit2.mp3")] private var S2:Class;
		public var x:uint
		public var y:uint
		public var type:uint
		public var GFX:BitmapAsset;
		public var SFX1:Sound
		public var SFX2:Sound
		public static var count:uint=0
		public function Block(ix:uint, iy:uint, typ:uint) {
			SFX1 = new S1
			SFX2= new S2
			x = ix
			y = iy
			type = typ
			switch(type) {
				case 0:
					GFX = new GF1;
					count++;
					break;
				case 1:
					GFX = new GF2;
					count++;
					break;
				case 2:
					GFX = new GF3;
					count++;
					break;
				case 3:
					GFX = new GF4;
					break;
				case 4:
					GFX = new GF5;
					break;
			}
			GFX.x = x * 30
			GFX.y = y * 30
			Game.layerblos.addChild(GFX)
		}
		public function Hit():void{
			switch(type) {
				case 0:
					CheckSides()
					Drop();
					break;
				case 1:
					removeGFX()
					GFX = new GF1;
					Game.layerblos.addChild(GFX)
					GFX.x = x * 30
					GFX.y = y * 30
					type = 0
					if (Sounder.on){SFX2.play()}
					break;
			}
		}
		public function removeGFX():void {
			if (removeGFX!=null){
				Game.layerblos.removeChild(GFX)
				GFX=null
			}
		}
		public function Drop():void {
			if (Sounder.on){SFX1.play()}
			if (type<3){count--;}
			Game.level[x][y] = null;
			removeGFX()
			new BloEff(x*30,y*30,new GF1)
		}
		public function Damage():void {
			if (Sounder.on){SFX2.play()}
			if (type == 2) {
				removeGFX()
				GFX = new GF1;
				Game.layerblos.addChild(GFX)
				GFX.x = x * 30
				GFX.y = y * 30
				type=0
			}
		}
		public function CheckSides():void {
			var blo:Block;
			blo = Game.At(x, y - 1);
			if (blo != null) { blo.Damage(); }
			blo = Game.At(x - 1, y);
			if (blo != null) { blo.Damage(); }
			blo = Game.At(x + 1, y);
			if (blo != null) { blo.Damage(); }
			blo = Game.At(x, y + 1);
			if (blo != null) { blo.Damage(); }
		}
	}

}