// ActionScript file
package Editor{
	import Classes.BGHandler;
	import Classes.Interactivers.*;
	import Classes.Items.*;

	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	public function ValidateLevel(data:String):Boolean{
		var space:int
		var arr:Array
		var i:uint
		var j:uint
		var k:uint
		var l:uint
		var tile:TField
		var len:uint
		var temp:uint
		//PACOMIX LEVEL DATA
		if (data.substr(0,6) == "PMLBEG"){
			data = data.substring(6)
		} else {
			return false;
		}

		//LEVEL AUTHOR
		len = TextToNum(data.substr(0,1))
		data = data.substring(len + 1)

		if (data.length < 6 || data.substring(0, 6) === 'PMLEND') {
			throw new Error("Failed after LEVEL AUTHOR");
		}

		//LEVEL NAME
		len = TextToNum(data.substr(0,1))
		data = data.substring(len + 1)

		if (data.length < 6 || data.substring(0, 6) === 'PMLEND') {
			throw new Error("Failed after LEVEL NAME");
		}

		//LEVEL SIZE
		var levelWidth:Number = TextToNum(data.substr(0,1))
		var levelHeight:Number = TextToNum(data.substr(1,1))
		data = data.substring(2)

		//BACKGROUND ID
		//BACKGROUND ANIMATION
		data = data.substring(5)

		//FLOOR DATA
		for (j = 0;j < levelWidth;j++){
			for (i = 0;i < levelHeight;i++){
				data = data.substring(1)
				if (data.length < 6 || data.substring(0, 6) === 'PMLEND') {
					throw new Error("Failed in FLOOR DATA: " + i.toString() + ":" + j.toString());
				}
			}
		}


		//WALL DATA
		while(true){
			temp = TextToNum(data.substr(0,2))
			data = data.substring(2)

			if (data.length < 6 || data.substring(0, 6) === 'PMLEND') {
				throw new Error("Failed in WALL DATA (first)");
			}
			if (temp == 0){break}
			data = data.substring(1)
			if (data.length < 6 || data.substring(0, 6) === 'PMLEND') {
				throw new Error("Failed in WALL DATA (second)");
			}
		}

		//ITEM DATA
		while(true){
			temp = TextToNum(data.substr(0,2))
			data = data.substring(2)
			if (data.length < 6 || data.substring(0, 6) === 'PMLEND') {
				throw new Error("Failed in ITEM DATA (first)");
			}
			if (temp == 0){break}
			temp = TextToNum(data.substr(0,1)) + 140
			data = data.substring(1)

			if (data.length < 6 || data.substring(0, 6) === 'PMLEND') {
				throw new Error("Failed in WALL DATA (second)");
			}
			switch(temp){
				case(173):
					data = data.substring(2)
					break;
				case(174):
					data = data.substring(2)
					break;
				case(175):
					data = data.substring(4)
					break
			}

			if (data.length < 6 || data.substring(0, 6) === 'PMLEND') {
				throw new Error("Failed in ITEM DATA (third)");
			}
		}

		//OBJECT DATA
		while(true){
			temp = TextToNum(data.substr(0,2))
			data = data.substring(2)
			if (temp == 0){break}
			if (data.length < 6 || data.substring(0, 6) === 'PMLEND') {
				throw new Error("Failed in OBJECT DATA");
			}
			data = data.substring(1)
		}

		if (data != "PMLEND"){
			return false;
		}

		return true;
	}
}