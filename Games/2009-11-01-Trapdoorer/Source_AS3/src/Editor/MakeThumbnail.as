// ActionScript file
package Editor{
	import Classes.BGHandler;
	import Classes.Items.*;
	import Classes.TLevel;

	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.display.BitmapData;
	public function MakeThumbnail(data: String, small: Boolean = false, onlyValidate: Boolean = false): BitmapData{
		TLevel.Clear();

		var x: int
		var y: int
		var dataLength: uint
		var tileType: uint
		//TRAPDOORER LEVEL DATA
		if (data.substr(0, 6) == "TPDBEG"){
			data = data.substring(6)
		} else {
			throw new Error(data)
		}

		//LEVEL AUTHOR
		dataLength = TextToNum(data.substr(0, 1))
		TLevel.authorName = data.substr(1, dataLength)
		data = data.substring(dataLength+1)

		//LEVEL NAME
		dataLength = TextToNum(data.substr(0, 1))
		TLevel.levelName = data.substr(1, dataLength)
		data = data.substring(dataLength+1)

		//PLAYER POS
		x = TextToNum(data.substr(0, 1))-1
		y = TextToNum(data.substr(1, 1))-1
		data = data.substring(2)

		//TILES DATA
		while(true){
			x = TextToNum(data.substr(0, 1))-1
			if (x == -1){break}
			y = TextToNum(data.substr(1, 1))-1
			tileType = TextToNum(data.substr(2, 1))
			data = data.substring(3)
			switch (tileType){
				case(1): new TNormal(x*25, y*25);break;
				case(2): new TStrong(x*25, y*25);break;
				case(3): new TSteel(x*25, y*25);break;
				case(4): new TBlank(x*25, y*25);break;
				case(5): new TExit(x*25, y*25);break;
				case(6): new TBoom(x*25, y*25);break;
				case(7): new THori(x*25, y*25);break;
				case(8): new TDiag(x*25, y*25);break;
				case(9): new TDirt(x*25, y*25);break;
				case(10): new TDirtBlank(x*25, y*25);break;
				case(11): new TGate(x*25, y*25, 0,0);break;
				case(12): new TGate(x*25, y*25, 0,1);break;
				case(13): new TGate(x*25, y*25, 1,0);break;
				case(14): new TGate(x*25, y*25, 1,1);break;
				case(15): new TGate(x*25, y*25, 2,0);break;
				case(16): new TGate(x*25, y*25, 2,1);break;
				case(17): new TGate(x*25, y*25, 3,0);break;
				case(18): new TGate(x*25, y*25, 3,1);break;
				case(19): new TGate(x*25, y*25, 4,0);break;
				case(20): new TGate(x*25, y*25, 4,1);break;
				case(21): new TGate(x*25, y*25, 5,0);break;
				case(22): new TGate(x*25, y*25, 5,1);break;
				case(23): new TButton(x*25, y*25, 0,0);break;
				case(24): new TButton(x*25, y*25, 0,1);break;
				case(25): new TButton(x*25, y*25, 1,0);break;
				case(26): new TButton(x*25, y*25, 1,1);break;
				case(27): new TButton(x*25, y*25, 2,0);break;
				case(28): new TButton(x*25, y*25, 2,1);break;
				case(29): new TButton(x*25, y*25, 3,0);break;
				case(30): new TButton(x*25, y*25, 3,1);break;
				case(31): new TButton(x*25, y*25, 4,0);break;
				case(32): new TButton(x*25, y*25, 4,1);break;
				case(33): new TButton(x*25, y*25, 5,0);break;
				case(34): new TButton(x*25, y*25, 5,1);break;
				case(35): new TStronger(x*25, y*25);break;
				case(36): new TDire(x*25, y*25);break;
				case(37): new TFragileButton(x*25, y*25, 0,0);break;
				case(38): new TFragileButton(x*25, y*25, 0,1);break;
				case(39): new TFragileButton(x*25, y*25, 1,0);break;
				case(40): new TFragileButton(x*25, y*25, 1,1);break;
				case(41): new TFragileButton(x*25, y*25, 2,0);break;
				case(42): new TFragileButton(x*25, y*25, 2,1);break;
				case(43): new TFragileButton(x*25, y*25, 3,0);break;
				case(44): new TFragileButton(x*25, y*25, 3,1);break;
				case(45): new TFragileButton(x*25, y*25, 4,0);break;
				case(46): new TFragileButton(x*25, y*25, 4,1);break;
				case(47): new TFragileButton(x*25, y*25, 5,0);break;
				case(48): new TFragileButton(x*25, y*25, 5,1);break;
			}
		}
		data = data.substring(1)
		if (data != "TPDEND"){
			TLevel.Clear();
			throw new Error(data+" - That was left")
		}
		if (onlyValidate) {
			TLevel.Clear();
			return null;
		}
		var b: BitmapData
		var mBG: Matrix = new Matrix
		var mLEV: Matrix = new Matrix
		var shap: Shape = new Shape
		if (small){
			b = new BitmapData(76, 76)
			shap.graphics.beginFill(0)
			shap.graphics.drawRect(0, 0,76, 76)
			shap.graphics.endFill()
			mBG.scale(76/BGHandler.Graphic.width, 76/BGHandler.Graphic.height)
			mLEV.scale(0.0608, 0.0608)
		} else {
			b = new BitmapData(440, 330)
			shap.graphics.beginFill(0)
			shap.graphics.drawRect(0, 0,440, 330)
			shap.graphics.endFill()
			mBG.scale(330/BGHandler.Graphic.width, 330/BGHandler.Graphic.height)
			mLEV.scale(0.264, 0.264)
			mBG.translate(55, 0)
			mLEV.translate(55, 0)
		}

		b.draw(shap)
		b.draw(BGHandler.Graphic, mBG)
		b.draw(TD.layerBlocks, mLEV)

		TLevel.Clear()
		return b;
	}
}