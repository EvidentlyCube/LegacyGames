package game.data{
    import game.global.Level;
    import game.global.Score;
    import game.global.Sfx;
    import game.objects.TConnector;
    import game.states.TStateLevelSelect;

    import net.retrocade.camel.effects.rEffFadeScreen;

    public class TConnectorData{
        private static var _instance:TConnectorData = new TConnectorData();
        public static function make(path:TPath):void{
            _instance.clear(path);
        }

        public static function checkCompletion():void{
            if (_instance._isCompleted){
                _instance._isCompleted = false;
                Level.levelCompleted();
                return;
            }
        }


        private var _isCompleted:Boolean = false;
        private var _color:uint;
        private var _connectors:Array = [];
        private var _totalBases:uint;
        private var _foundBases:uint;

        private var _singleBaseConfirmed:Boolean = false

        private function clear(path:TPath):void{
            _color             = path.color;
            _foundBases        = 0;
            _totalBases        = Level.countBasesByColor(_color);
            _connectors.length = 0;

            _singleBaseConfirmed = false;

            parse(Level.getFirstBase(_color));

            var hadAll:Boolean = TBase(_connectors[0]).allConnected;

            var t:TConnector;

            if ((_totalBases > 1 || _singleBaseConfirmed) && _totalBases == _foundBases){
                for each(t in Level.getAllByColor(_color)){
                    t.allConnected = true;
                }
                if (!hadAll){
                    Sfx.sfxGotMatchPlay();
                    new rEffFadeScreen(0.8, 1, 0xFFFFFF, 500);
                }
            } else {
                for each(t in Level.getAllByColor(_color)){
                    t.allConnected = false;
                }
            }

            // Check if level is completed
            for each(t in Level.bases.getAll()){
                if (!t.allConnected)
                    return;
            }

            _isCompleted = true;
        }

        private function parse(connector:TConnector, step:uint = 0):void{
            if (connector && connector.color == _color && _connectors.indexOf(connector) == -1){
                _connectors.push(connector);

                if (connector is TBase)
                    _foundBases++;

                parse(Level.level.get(connector.x + S().TILE_GRID_TILE_WIDTH, connector.y)  as TConnector, step + 1);
                parse(Level.level.get(connector.x - S().TILE_GRID_TILE_WIDTH, connector.y)  as TConnector, step + 1);
                parse(Level.level.get(connector.x, connector.y + S().TILE_GRID_TILE_HEIGHT) as TConnector, step + 1);
                parse(Level.level.get(connector.x, connector.y - S().TILE_GRID_TILE_HEIGHT) as TConnector, step + 1);

            } else if (_totalBases == 1 && _connectors[0] == connector && step > 2)
                _singleBaseConfirmed = true;
        }
    }
}