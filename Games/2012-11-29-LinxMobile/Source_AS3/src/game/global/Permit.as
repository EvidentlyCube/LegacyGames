package game.global{
    import game.data.TConnectorManager;

	public class Permit{
		private static var _permissions:Array = [null, true, true, true, true, true, true, true];
		
		public static function setPermission(permission:Array):void{
			for each(var permit:* in permission){
				if (permit is Array)
					setPermission(permit);
				else if (permit is int)
					setSinglePermission(permit);
				else
					throw new ArgumentError("Invalid param!");
			}
		}
		
		private static function setSinglePermission(permission:int):void{
			var allow:Boolean = (permission > 0);
			permission = permission < 0 ? -permission : permission;
			
			_permissions[permission] = allow;
            
            if (permission == C.allowConnectBase && allow)
                TConnectorManager.recheckAllColors();
		}
		
		public static function canDrawPath():Boolean{
			return _permissions[1];
		}
		
		public static function canGetColor():Boolean{
			return _permissions[2];
		}
		
		public static function canUndo():Boolean{
			return _permissions[3];
		}
		
		public static function canConnectBase():Boolean{
			return _permissions[4];
		}
		
		public static function canRemovePath():Boolean{
			return _permissions[5];
		}
		
		public static function canHud():Boolean{
			return _permissions[6];
		}
        
        public static function canClearColor():Boolean{
            return _permissions[7];
        }
	}
}