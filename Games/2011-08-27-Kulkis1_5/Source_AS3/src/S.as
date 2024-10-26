package {
	public function S():SettingsClass {
		return SettingsClass.instance;
	}
}

import net.retrocade.retrocamel.interfaces.IRetrocamelSettings;

class SettingsClass implements IRetrocamelSettings {

	public static var instance:SettingsClass = new SettingsClass();


	public function get eventsCount():uint {
		return 2;
	}

	public function get languages():Array {
		return ['en', 'pl'];
	}

	public function get languagesNames():Array {
		return ['English', 'Polski'];
	}

	public function get gameWidth():uint {
		return 512;
	}

	public function get gameHeight():uint {
		return 448;
	}

	public function get levelWidth():uint {
		return 256;
	}

	public function get levelHeight():uint {
		return 224;
	}

	public function get tileWidth():uint {
		return 16;
	}

	public function get tileHeight():uint {
		return 16;
	}
}