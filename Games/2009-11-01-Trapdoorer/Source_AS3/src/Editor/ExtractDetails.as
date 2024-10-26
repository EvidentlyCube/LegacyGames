// ActionScript file
package Editor{
	import Classes.BGHandler;
	import Classes.Items.*;
	import Classes.TLevel;

	import Editor.TextToNum;

	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.display.BitmapData;
	public function ExtractDetails(idPrefix: String, data: Array): Array {
		var newData: Array = [];
		for (var i: Number = 0; i < data.length; i++) {
			newData[i] = ExtractDetailsOne(idPrefix + i.toString(), data[i]);
		}

		return newData;
	}
}

import Editor.TextToNum;

function ExtractDetailsOne(id: String, data: String): * {
	//TRAPDOORER LEVEL DATA
	if (data.substr(0, 6) == "TPDBEG"){
		data = data.substring(6)
	} else {
		throw new Error(data)
	}

	//LEVEL AUTHOR
	var authorLength:Number = TextToNum(data.substr(0, 1))
	var author: String = data.substr(1, authorLength)
	data = data.substring(authorLength+1)

	//LEVEL NAME
	var nameLength:Number = TextToNum(data.substr(0, 1))
	var name: String = data.substr(1, nameLength)

	return [id, name, author, data];
}