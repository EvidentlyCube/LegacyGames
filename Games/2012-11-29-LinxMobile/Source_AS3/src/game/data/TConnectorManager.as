package game.data{
    import net.retrocade.camel.effects.rEffFadeScreen;
    
    import game.global.Level;
    import game.global.Permit;
    import game.global.Sfx;
    import game.objects.TConnector;

    public class TConnectorManager{
        private static var _instance:TConnectorManager = new TConnectorManager();
        public static function parseForPath(path:TPath):void{
            _instance.checkColor(path.tileColor);
        }
        
        public static function checkCompletion():void{
            if (_instance._isCompleted){
                _instance._isCompleted = false;
                Level.levelCompleted();
                return;
            }
        }
        
        public static function recheckAllColors():void{
            _instance._isCompleted = false;
            
            _instance.checkColor(0);
            _instance.checkColor(1);
            _instance.checkColor(2);
            _instance.checkColor(3);
            _instance.checkColor(4);
            _instance.checkColor(5);
            _instance.checkColor(6);
            _instance.checkColor(7);
            _instance.checkColor(8);
        }
        
        
        private var _isCompleted:Boolean = false;
        private var _color:uint;
        private var _connectors:Array = [];
        private var _totalBases:uint;
        private var _foundBases:uint;
        
        private var _singleBaseConfirmed:Boolean = false
        
        private function checkColor(tileColor:int):void{
			if (!Permit.canConnectBase())
				return;
			
            _color             = tileColor;
            _foundBases        = 0;
            _totalBases        = Level.countBasesByColor(_color);
            _connectors.length = 0;
            
            _singleBaseConfirmed = false;
            
            parse(Level.getFirstBase(_color));
            
            if (!_connectors[0])
                return;
            
            var hadAll:Boolean = TBase(_connectors[0]).allConnected;
            
            var t:TConnector;
            
            if ((_totalBases > 1 || _singleBaseConfirmed) && _totalBases == _foundBases){
                for each(t in Level.getAllByColor(_color)){
                    t.allConnected = true;
                    t.update();
                }
                if (!hadAll){
                    Sfx.sfxGotMatch.play();
                    new rEffFadeScreen(0.8, 1, 0xFFFFFF, 500);
                }
            } else {
                for each(t in Level.getAllByColor(_color)){
                    t.allConnected = false;
                    t.update();
                }
            }
            
            // Check if level is completed
            for each(t in Level.groupBases.getAll()){
                if (!t.allConnected)
                    return;
            }
            
            _isCompleted = true;
        }
        
        private function parse(connector:TConnector, step:uint = 0):void{
            if (connector && connector.colorMatches(_color) && _connectors.indexOf(connector) == -1){
                _connectors.push(connector);
                
                if (connector is TBase)
                    _foundBases++;
                
                parse(Level.level.getTile(connector.tileX + 1, connector.tileY)  as TConnector, step + 1);
                parse(Level.level.getTile(connector.tileX - 1, connector.tileY)  as TConnector, step + 1);
                parse(Level.level.getTile(connector.tileX, connector.tileY + 1) as TConnector, step + 1);
                parse(Level.level.getTile(connector.tileX, connector.tileY - 1) as TConnector, step + 1);
                
            } else if (_totalBases == 1 && _connectors[0] == connector && step > 2)
                _singleBaseConfirmed = true;
        }
    }
}