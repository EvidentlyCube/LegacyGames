package game.global.levels {
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	import game.global.Level;

	public class LevelListRegular implements ILevelList{

		[Embed(source='../../../../assets/levels/regular/000.oel', mimeType="application/octet-stream")] private static var _level_1_:Class;
		[Embed(source='../../../../assets/levels/regular/001.oel', mimeType="application/octet-stream")] private static var _level_2_:Class;
		[Embed(source='../../../../assets/levels/regular/002.oel', mimeType="application/octet-stream")] private static var _level_3_:Class;
		[Embed(source='../../../../assets/levels/regular/003.oel', mimeType="application/octet-stream")] private static var _level_4_:Class;
		[Embed(source='../../../../assets/levels/regular/004.oel', mimeType="application/octet-stream")] private static var _level_5_:Class;
		[Embed(source='../../../../assets/levels/regular/005.oel', mimeType="application/octet-stream")] private static var _level_6_:Class;
		[Embed(source='../../../../assets/levels/regular/006.oel', mimeType="application/octet-stream")] private static var _level_7_:Class;
		[Embed(source='../../../../assets/levels/regular/007.oel', mimeType="application/octet-stream")] private static var _level_8_:Class;
		[Embed(source='../../../../assets/levels/regular/008.oel', mimeType="application/octet-stream")] private static var _level_9_:Class;
		[Embed(source='../../../../assets/levels/regular/009.oel', mimeType="application/octet-stream")] private static var _level_10_:Class;
		[Embed(source='../../../../assets/levels/regular/010.oel', mimeType="application/octet-stream")] private static var _level_11_:Class;
		[Embed(source='../../../../assets/levels/regular/011.oel', mimeType="application/octet-stream")] private static var _level_12_:Class;
		[Embed(source='../../../../assets/levels/regular/012.oel', mimeType="application/octet-stream")] private static var _level_13_:Class;
		[Embed(source='../../../../assets/levels/regular/013.oel', mimeType="application/octet-stream")] private static var _level_14_:Class;
		[Embed(source='../../../../assets/levels/regular/014.oel', mimeType="application/octet-stream")] private static var _level_15_:Class;
		[Embed(source='../../../../assets/levels/regular/015.oel', mimeType="application/octet-stream")] private static var _level_16_:Class;
		[Embed(source='../../../../assets/levels/regular/016.oel', mimeType="application/octet-stream")] private static var _level_17_:Class;
		[Embed(source='../../../../assets/levels/regular/017.oel', mimeType="application/octet-stream")] private static var _level_18_:Class;
		[Embed(source='../../../../assets/levels/regular/018.oel', mimeType="application/octet-stream")] private static var _level_19_:Class;
		[Embed(source='../../../../assets/levels/regular/019.oel', mimeType="application/octet-stream")] private static var _level_20_:Class;
		[Embed(source='../../../../assets/levels/regular/020.oel', mimeType="application/octet-stream")] private static var _level_21_:Class;
		[Embed(source='../../../../assets/levels/regular/021.oel', mimeType="application/octet-stream")] private static var _level_22_:Class;
		[Embed(source='../../../../assets/levels/regular/022.oel', mimeType="application/octet-stream")] private static var _level_23_:Class;
		[Embed(source='../../../../assets/levels/regular/023.oel', mimeType="application/octet-stream")] private static var _level_24_:Class;
		[Embed(source='../../../../assets/levels/regular/024.oel', mimeType="application/octet-stream")] private static var _level_25_:Class;
		[Embed(source='../../../../assets/levels/regular/025.oel', mimeType="application/octet-stream")] private static var _level_26_:Class;

		private static var _levels:Dictionary = new Dictionary();


		public function getLevel(id:uint):ByteArray {
			if (!_levels[id])
				_levels[id] = new LevelListRegular['_level_' + id + '_'];

			ByteArray(_levels[id]).position = 0;
			return _levels[id];
		}
	}
}
