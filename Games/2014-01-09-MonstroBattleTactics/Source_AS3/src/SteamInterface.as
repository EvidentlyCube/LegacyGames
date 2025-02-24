package {
	import com.amanitadesign.steam.FRESteamWorks;
	import com.amanitadesign.steam.SteamConstants;
	import com.amanitadesign.steam.SteamEvent;

	import net.retrocade.signal.Signal;

	public class SteamInterface {
		private static var _steamworks:FRESteamWorks;

		private static var _isInitialized:Boolean;

		public static var onSteamworksInitialized:Signal = new Signal();

		public static function init():void {
			try {
				_steamworks = new FRESteamWorks();
				_steamworks.addEventListener(SteamEvent.STEAM_RESPONSE, onSteamResponse);
				_isInitialized = _steamworks.init();

			} catch (error:Error){
				_isInitialized = false;
			}

			if (!_isInitialized){
				onSteamworksInitialized.call(false);
			}
		}

		private static function onSteamResponse(event:SteamEvent):void {
			switch(event.req_type){
				case SteamConstants.RESPONSE_OnUserStatsReceived:
					onSteamworksInitialized.call(true);
					break;
			}
		}

		public static function awardAchievement(achievementId:String):void {
			if (!_isInitialized){
				return;
			}

			if (CF::debug){
				try{
					_steamworks.setAchievement(achievementId);
				} catch (error:Error){
					trace(error.message);
				}

			} else {
				_steamworks.setAchievement(achievementId);

			}
		}

		public static function clearAchievement(achievementId:String):void {
			if (!_isInitialized){
				return;
			}

			try{
				_steamworks.clearAchievement(achievementId);

			} catch (error:Error){
				_e("Awarding achievement in steam: " + achievementId, error);
				trace(error.message);
			}
		}
	}
}
