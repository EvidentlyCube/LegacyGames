package {
	import net.retrocade.helpers.RetrocamelUrlLoader;

	import net.retrocade.signal.Signal;
	import net.retrocade.signal.SignalTimer;

	public class RetrocadeInterface {
		private static var _urlLoader:RetrocamelUrlLoader;

		private static var _timeoutTimer:SignalTimer;
		private static var _version:String;
		private static var _changelog:String;

		public static var onInitialized:Signal = new Signal();

		public static function init():void {
			_timeoutTimer = new SignalTimer(5000, 1);
			_timeoutTimer.onTimerFinished.add(timeoutFinishedHandler);
			_timeoutTimer.start();

			_urlLoader = new RetrocamelUrlLoader("http://data.retrocade.net/net.retrocade.game.MonstroBattleTactics.json", null, onSuccess, onFailure);
		}

		private static function timeoutFinishedHandler():void {
			_version = null;
			_changelog = null;

			close();
		}

		private static function onSuccess(data:String):void {
			_l("Loaded Version file");
			_timeoutTimer.stop();

			try {
				_l("Version file contents: " + data);
				var jsonObject:Object = JSON.parse(data);
				_version = jsonObject.latestVersion;
				_changelog = jsonObject.changelog;

			} catch (error:Error){
				_e("Failed to parse version file", error);
				_version = null;
				_changelog = null;
			}

			close();
		}

		private static function onFailure():void {
			_l("Version file failed to load");
			close();
		}

		private static function close():void{
			_urlLoader.close();
			_timeoutTimer.dispose();
			onInitialized.call();
			_urlLoader = null;
		}

		public static function get version():String {
			return _version;
		}

		public static function get changelog():String {
			return _changelog;
		}
	}
}
