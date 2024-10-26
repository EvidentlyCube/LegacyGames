package game.global.levels {
	import flash.utils.ByteArray;

	public interface ILevelList {
		function getLevel(id:uint):ByteArray;
	}
}
