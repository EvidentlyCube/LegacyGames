package game.global {
	import net.retrocade.constants.KeyConst;
	import net.retrocade.helpers.RetrocamelScrollAssist;
	import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
	import net.retrocade.retrocamel.core.RetrocamelDisplayManager;
	import net.retrocade.retrocamel.core.RetrocamelInputManager;
	import net.retrocade.retrocamel.core.RetrocamelSoundManager;
	import net.retrocade.retrocamel.core.RetrocamelWindowsManager;
	import net.retrocade.retrocamel.display.flash.RetrocamelBitmapFont;
	import net.retrocade.retrocamel.display.flash.RetrocamelPreciseGrid9;
	import net.retrocade.retrocamel.display.global.RetrocamelTooltip;
	import net.retrocade.retrocamel.display.layers.RetrocamelLayerFlashSprite;
	import net.retrocade.retrocamel.global.RetrocamelSimpleSave;
	import net.retrocade.retrocamel.locale.RetrocamelLocaleParserRetrocadeProperties;

	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.display.StageQuality;

	public class Pre {
		[Embed(source='../../../assets/i18n/en.txt', mimeType='application/octet-stream')] private static var _lang_en:Class;
		[Embed(source='../../../assets/i18n/pl.txt', mimeType='application/octet-stream')] private static var _lang_pl:Class;

		[Embed(source="../../../assets/gfx/by_maurycy/font.png")] public static var _font:Class;
		[Embed(source='../../../assets/gfx/by_cage/bgs/buttonSystem.png')] private static var _buttonBgSystem_:Class;
		[Embed(source='../../../assets/gfx/by_cage/bgs/tooltipSystem.png')] private static var _tooltipBgSystem_:Class;

		public static var font:RetrocamelBitmapFont;

		public static function preCoreInit():void {
			loadFont();
		}

		public static function init():void {
			loadLanguages();
			loadGrid();
			loadOptions();

			RetrocamelScrollAssist.instance.displayWidth = S().levelWidth;
			RetrocamelScrollAssist.instance.displayHeight = S().levelHeight;

			RetrocamelWindowsManager.hookFlashLayer(new RetrocamelLayerFlashSprite());
			RetrocamelTooltip.init();
			RetrocamelTooltip.setBackground(RetrocamelPreciseGrid9.getGrid("tooltip"));
			RetrocamelTooltip.setPadding(0, 2, 0, 3);

			RetrocamelDisplayManager.scaleToFit = RetrocamelSimpleSave.read('scaleToFit', "1") === "1";
			RetrocamelDisplayManager.scaleToInteger = RetrocamelSimpleSave.read('scaleToInteger', "0") === "1";

			initKeyboardShortcuts();
		}

		private static function initKeyboardShortcuts():void {
			RetrocamelDisplayManager.flashStage.addEventListener(KeyboardEvent.KEY_DOWN, function(event: KeyboardEvent): void {
				switch (event.keyCode) {
					case(KeyConst.F4):
						if (RetrocamelDisplayManager.scaleToFit && RetrocamelDisplayManager.scaleToInteger) {
							RetrocamelDisplayManager.scaleToFit = true;
							RetrocamelDisplayManager.scaleToInteger = false;

						} else if (RetrocamelDisplayManager.scaleToFit && !RetrocamelDisplayManager.scaleToInteger) {
							RetrocamelDisplayManager.scaleToFit = false;
							RetrocamelDisplayManager.scaleToInteger = false;

						} else {
							RetrocamelDisplayManager.scaleToFit = true;
							RetrocamelDisplayManager.scaleToInteger = true;
						}
						RetrocamelSimpleSave.write('scaleToFit', RetrocamelDisplayManager.scaleToFit ? "1" : "0");
						RetrocamelSimpleSave.write('scaleToInteger', RetrocamelDisplayManager.scaleToInteger ? "1" : "0");
						RetrocamelSimpleSave.flush();
						break;
					case(Keyboard.F9):
						if (RetrocamelDisplayManager.quality === StageQuality.HIGH) {
							RetrocamelDisplayManager.quality = StageQuality.LOW;
						} else if (RetrocamelDisplayManager.quality === StageQuality.LOW) {
							RetrocamelDisplayManager.quality = StageQuality.MEDIUM;
						} else {
							RetrocamelDisplayManager.quality = StageQuality.HIGH;
						}
						break;
					// Disabled because it's built-in into Ruffle
					// case(KeyConst.F11):
						// RetrocamelDisplayManager.toggleFullScreen();
						// break;
					case(Keyboard.ENTER):
						if (event.altKey) {
							RetrocamelDisplayManager.toggleFullScreen();
						}
						break;
				}
			});
		}

		private static function loadOptions():void {
			RetrocamelSimpleSave.setStorage('kulkis15_regular');

			RetrocamelSoundManager.musicVolume = RetrocamelSimpleSave.read('optVolumeMusic', 1.0);
			RetrocamelSoundManager.soundVolume = RetrocamelSimpleSave.read('optVolumeSound', 1.0);
		}

		private static function loadFont():void {
			var characters:String = String.fromCharCode.apply(null, [
				32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51,
				52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71,
				72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91,
				92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111,
				112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 180, 196, 201, 214, 220,
				223, 225, 226, 227, 228, 231, 233, 234, 237, 243, 245, 246, 250, 252, 261, 263, 281, 321, 322, 324,
				346, 347, 378, 380, 8212, 8217, 8230, 12290, 19968, 19975, 19978, 19979, 19981, 19982, 19988, 20010, 20013, 20026, 20037, 20043,
				20048, 20102, 20110, 20154, 20171, 20174, 20182, 20197, 20204, 20247, 20250, 20294, 20303, 20307, 20316, 20320, 20351, 20415, 20572, 20687,
				20799, 20811, 20837, 20840, 20851, 20854, 20889, 20943, 20986, 20987, 20998, 20999, 21040, 21046, 21069, 21147, 21152, 21160, 21315, 21333,
				21345, 21361, 21364, 21435, 21453, 21464, 21475, 21487, 21491, 21516, 21518, 21521, 21592, 21629, 21644, 21862, 21916, 22235, 22238, 22312,
				22320, 22353, 22359, 22604, 22768, 22810, 22823, 22825, 22833, 22855, 22914, 22987, 23089, 23376, 23383, 23384, 23433, 23436, 23450, 23460,
				23494, 23547, 23558, 23567, 23601, 23613, 23621, 23679, 23707, 24038, 24050, 24102, 24180, 24182, 24207, 24211, 24213, 24320, 24377, 24378,
				24403, 24425, 24448, 24456, 24471, 24494, 24515, 24555, 24597, 24598, 24656, 24685, 24744, 24930, 25103, 25104, 25110, 25151, 25152, 25163,
				25165, 25171, 25214, 25226, 25321, 25351, 25353, 25442, 25481, 25484, 25490, 25509, 25511, 25913, 25928, 25968, 26031, 26032, 26041, 26102,
				26126, 26159, 26174, 26242, 26263, 26368, 26377, 26463, 26465, 26469, 26524, 26631, 26679, 26684, 27036, 27425, 27454, 27809, 27833, 27934,
				28034, 28040, 28145, 28165, 28216, 28304, 28459, 28857, 29289, 29609, 29616, 29983, 29992, 30011, 30028, 30340, 30424, 30456, 30475, 30528,
				30896, 31070, 31163, 31181, 31227, 31243, 31348, 31354, 31505, 32456, 32461, 32463, 32467, 32472, 32487, 32493, 32763, 32773, 32791, 32930,
				33021, 33394, 33756, 33853, 34892, 34987, 35201, 35328, 35768, 35793, 35821, 35831, 35874, 36133, 36164, 36182, 36215, 36335, 36339, 36523,
				36710, 36731, 36807, 36814, 36820, 36825, 36827, 36864, 36873, 36895, 37027, 37096, 37324, 37325, 37327, 38025, 38145, 38190, 38271, 38381,
				38383, 38388, 38500, 38505, 38754, 38899, 39033, 39068, 40657, 40736, 21457, 27491, 31245, 31561, 36830, 36865, 25991, 21734, 22269, 24230,
				25758, 27492, 27861, 35299, 377, 260, 262, 280, 323, 379, 8734, 211, 20027, 20123, 20132, 20219, 20877, 20915, 21033, 21161,
				21449, 21543, 21561, 22418, 22836, 23427, 23545, 23614, 24039, 24049, 24110, 24444, 24452, 24819, 24847, 24935, 25216, 25773, 25910, 25918,
				26080, 26234, 29255, 30097, 30422, 30495, 30742, 32447, 32852, 32988, 33258, 33719, 35206, 35760, 36733, 36793, 36816, 36890, 36947, 37117,
				38062, 38169, 38386, 38480, 38543, 38590, 39029, 65281, 65292, 224, 232, 244, 238, 249, 239, 1040, 1042, 1043, 1045, 1046,
				1047, 1048, 1050, 1051, 1052, 1053, 1054, 1055, 1056, 1057, 1058, 1059, 1063, 1065, 1069, 1071, 1072, 1073, 1074, 1075,
				1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1088, 1089, 1090, 1091, 1092, 1093, 1094, 1095,
				1096, 1097, 1099, 1100, 1101, 1102, 1103, 1105, 8211]);

			font = new RetrocamelBitmapFont(_font, 15, 13, false, 5, characters);
		}

		private static function loadGrid():void {
			RetrocamelPreciseGrid9.make('buttonBG', RetrocamelBitmapManager.getBD(_buttonBgSystem_), 8, 12, 2, 2);
			RetrocamelPreciseGrid9.make('tooltip', RetrocamelBitmapManager.getBD(_tooltipBgSystem_), 2, 3, 2, 2);
		}

		private static function loadLanguages():void {
			RetrocamelLocaleParserRetrocadeProperties.parse(_lang_en, 'en');
			RetrocamelLocaleParserRetrocadeProperties.parse(_lang_pl, 'pl');
		}
	}
}