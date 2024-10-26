package {
	public function S():S_Class {
		return S_Class.instance;
	}
}

import net.retrocade.retrocamel.interfaces.IRetrocamelSettings;

class S_Class implements IRetrocamelSettings {
	public static var instance:S_Class = new S_Class();

	public var currentVersion: String = "regular";

	public function get debug():Boolean {
		return false;
	}

	public function get eventsCount():uint {
		return C.EVENTS_COUNT;
	}

	public function get languages():Array {
		return ['en', 'pl'];
	}

	//noinspection JSMethodCanBeStatic
	public function get languagesNames():Array {
		return ['English', 'Polski'];
	}

	public function get gameWidth():uint {
		return 528;
	}

	public function get gameHeight():uint {
		return 448;
	}

	//noinspection JSMethodCanBeStatic
	public function get levelWidth():uint {
		return 264;
	}

	//noinspection JSMethodCanBeStatic
	public function get levelHeight():uint {
		return 224;
	}

	//noinspection JSMethodCanBeStatic
	public function get saveStorageName():String {
		return "rock-rush-101";
	}

	//noinspection JSMethodCanBeStatic
	public function get adventureMode():Boolean {
		return false;
	}

	//noinspection JSMethodCanBeStatic
	public function get tileGridTileWidth():Number {
		return 12;
	}

	//noinspection JSMethodCanBeStatic
	public function get tileGridTileHeight():Number {
		return 12;
	}

	//noinspection JSMethodCanBeStatic
	public function get tileGridWidth():Number {
		return 220;
	}

	//noinspection JSMethodCanBeStatic
	public function get tileGridHeight():Number {
		return 160;
	}
}