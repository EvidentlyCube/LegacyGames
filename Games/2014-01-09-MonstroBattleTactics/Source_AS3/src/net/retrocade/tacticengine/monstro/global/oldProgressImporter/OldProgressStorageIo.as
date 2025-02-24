package net.retrocade.tacticengine.monstro.global.oldProgressImporter {
	import avmplus.getQualifiedClassName;

	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;

	import net.retrocade.functions.printf;

	import net.retrocade.utils.UtilsBase64;

	public class OldProgressStorageIo {
		private static const SCRAMBLE_KEY:int = 634937;
		private static var _storagePath:File;

		public static function init():Boolean{
			for each(var path:String in arrayOfPaths){
				_storagePath = new File(path);
				if (_storagePath.exists){
					break;
				}
			}

			return _storagePath.exists;
		}

		public static function read():Object{
			try{
				if (_storagePath.exists){
					var fileStream:FileStream = new FileStream();
					fileStream.open(_storagePath, FileMode.READ);

					var byteArray:ByteArray = fromHexString(fileStream.readUTFBytes(fileStream.bytesAvailable));
					fileStream.close();

					unscrambleByteArray(byteArray, SCRAMBLE_KEY);

					byteArray = UtilsBase64.decodeByteArrayByteArray(byteArray);
					var result:Object = byteArray.readObject();

					var className:String = getQualifiedClassName(result);
					if (className != "Object"){
						return {};
					} else {
						return result;
					}
				} else {
					return {};
				}
			} catch (error:Error){
				return {};
			}

			return {};
		}

		/**
		 * Predictively unscrambles a ByteArray using a preset seed.
		 * @param byteArray ByteArray to unscramble, it is modified
		 * @param seed Seed which was previously used to scramble the string
		 * @return Unscrambled string
		 */
		public static function unscrambleByteArray(byteArray:ByteArray, seed:uint):void {
			var randomEngine:OldRandomEngine = new OldRandomEngine();
			randomEngine.setSeed(seed.toString());

			for (var i:uint = 0, l:uint = byteArray.length; i < l; i++) {
				byteArray[i] = (byteArray[i] + 256 - randomEngine.getUintRange(0, 256)) % 256;
			}
		}

		public static function fromHexString(hexString:String):ByteArray {
			var bytesCount:uint = (hexString.length + 1) / 3;
			var byteArray:ByteArray = new ByteArray();
			for (var i:int = 0; i < bytesCount; i++){
				byteArray.writeByte(parseInt(hexString.substr(i * 3, 2), 16));
			}

			byteArray.position = 0;
			return byteArray;
		}

		private static function get arrayOfPaths():Array{
			var fileNames:Array = [
				"import.dat",
				printf("%%", "monstro_1.0.1.dat"),
				printf("full_%%", "monstro_1.0.1.dat")
//				printf("%%", "monstro_1.0.1.dat.sol"),
//				printf("full_%%", "monstro_1.0.1.dat.sol")
			];

			var path:String = File.applicationStorageDirectory.resolvePath(fileNames[0]).nativePath;
			var pathRoot:String = path.substr(0, path.indexOf("net.retrocade"));

			var basePaths:Array = [
					File.applicationDirectory.nativePath + "/",
					pathRoot + "net.retrocade.games.TacticMonstro/Local Store/#SharedObjects/Monstro.swf/",
					pathRoot + "net.retrocade.games.TacticMonstro/Local Store/#SharedObjects/",
					pathRoot + "net.retrocade.games.TacticMonstro/Local Store/"

			];

			var pathsToCheck:Array = [];
			for each(var fileName:String in fileNames){
				for each(var basePath:String in basePaths){
					pathsToCheck.push(basePath + fileName);
				}
			}

			return pathsToCheck;
		}
	}
}
