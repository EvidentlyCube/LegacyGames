// ActionScript file
package Classes.Data{
	import Classes.BGHandler;
	import Classes.Items.*;
	import Classes.TLevel;

	import Editor.TextToNum;
	import Editor.MakeThumbnail;

	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.display.BitmapData;

    public class LocalStorageLevelData {
        public static function parseMany(datas: *): Array {
            var parsedDatas: Array = [];
            for (var i: Number = 0; i < datas.length; i++) {
                try {
                    var data: LocalStorageLevelData = new LocalStorageLevelData(datas[i]);

                    if (data.isValid) {
                        parsedDatas.push(data);
                    } else {
                        trace("Invalid level: " + data);
                    }

                } catch (e: Error) {
                    trace("LocalStorageLevelData::parseMany()->error");
                    trace(e.message);
                    // Do nothing
                }
            }

            trace("LocalStorageLevelData::parseMany()->returnCount");
            trace(parsedDatas.length);
            return parsedDatas;
        }

        public var id:String;
        public var name:String;
        public var author:String;
        public var code:String;
        public var isValid: Boolean = false;

        public function toString(): String {
            return id + code;
        }

        public function LocalStorageLevelData(data: String) {
            try {
                extractData(data);
            } catch (e: Error) {
                trace("LocalStorageLevelData::constructor->Error");
                trace(e.message);
                // It's invalid!
            }
        }

        private function extractData(localStorageData: String): void {
            var halves:Array = localStorageData.split("TPDBEG");
            if (halves.length !== 2) {
                trace("LocalStorageLevelData::extractData->wrongHalvesCount");
                trace(halves.length);
                return;
            }

            this.id = halves[0];

            code = "TPDBEG" + halves[1];

            MakeThumbnail(code, false, true);

            var data: String = code;

            //TRAPDOORER LEVEL DATA
            if (data.substr(0, 6) == "TPDBEG"){
                data = data.substring(6);
            } else {
                trace("LocalStorageLevelData::extractData->invalidDataBit");
                trace(data);
                throw new Error(data);
            }

            //LEVEL AUTHOR
            var authorLength:Number = TextToNum(data.substr(0, 1));
            author = data.substr(1, authorLength);
            data = data.substring(authorLength+1);

            //LEVEL NAME
            var nameLength:Number = TextToNum(data.substr(0, 1));
            name = data.substr(1, nameLength);

            isValid = true;
        }
    }
}
