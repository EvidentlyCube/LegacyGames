package src.PlatformerEngine{
    import com.mauft.DataVault.MiniVault;
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Shape;
    import flash.events.Event;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    import src.GFX;
    import src.Objects.Debug;
    import src.Objects.TPlayer;
    
    public class Level{
        public  static const STATE_NO_PLAY   :int = 0;
        public  static const STATE_READY     :int = 1;
        public  static const STATE_PLAYING   :int = 2;
        public  static const STATE_DEAD      :int = 3; 
        
        private static var _levelColliders   :Array;
        private static var _levelGraphics    :Array;
        
        private static var _buffer       :BitmapData;
        private static var _stepID       :Number  = 0;
        private static var _state        :int     = 0;
        
        /**
         * True if checkpoint has been marked in a level 
         */
        private static var _checkpointed :Boolean = false;
        
        /**
         * ID of the level 
         */
        public  static var ID        :int       = 0;
        
        public  static var time      :MiniVault = new MiniVault();
        public  static var bonuses   :MiniVault = new MiniVault();
        public  static var bonusesMax:MiniVault = new MiniVault();
        public  static var keys      :MiniVault = new MiniVault();
        
        internal static function init():void{
            _levelColliders = new Array(Settings.LEVEL_WIDTH * Settings.LEVEL_HEIGHT);
            _levelGraphics    = new Array(Settings.LEVEL_WIDTH * Settings.LEVEL_HEIGHT);
            
            _buffer    = new BitmapData(Settings.SCREEN_WIDTH, Settings.SCREEN_HEIGHT, true)
            
            Gfx.init(Engine.main);
            
            Engine.stage.addEventListener(Event.ENTER_FRAME, levelStep);
        }
        
        public static function levelStep(e:Event):void{
            Debug.update();
            
            _stepID++;
            
            var i:ObjGame;
            
            switch( _state ){
                case(0):
                    Scrolling.updateScrolling();
                    
                    Gfx.paperUpdate();
                    break;
                    
                case(1):
                    if (_stepID > 5 && Controls.anyKeyHit){
                        _state = STATE_PLAYING; 
                    }
                    
                    Scrolling.updateScrolling();
                    
                    Gfx.paperUpdate();
                    Gfx.hudUpdate();
                    
                    drawTiles();
                    break;
                    
                case(2):
                    Obs.updateAll();
                    
                    Scrolling.updateScrolling();
                    
                    Gfx.paperUpdate();
                    Gfx.hudUpdate();
                    Gfx.messageUpdate();

                    drawTiles();
                    break;
            }            
            
            Controls.Reset();
        }
        
        /**
         * Inner function which redraws all the tiles 
         */
        private static function drawTiles():void{
            buffer.fillRect(new Rectangle(0, 0, Settings.SCREEN_WIDTH, Settings.SCREEN_HEIGHT), 0x00FFFFFF)
                    
            var m  :int       =     Math.floor(Scrolling.x / Settings.TILE_WIDTH)  - 2;
            var n  :int       =     Math.floor(Scrolling.y / Settings.TILE_HEIGHT) - 2;
            var toI:int       = m + 2 + Math.ceil (Settings.SCREEN_WIDTH  / Settings.TILE_WIDTH)  + (Scrolling.x % Settings.TILE_WIDTH  ? 1 : 0);
            var toJ:int       = n + 2 + Math.ceil (Settings.SCREEN_HEIGHT / Settings.TILE_HEIGHT) + (Scrolling.y % Settings.TILE_HEIGHT ? 1 : 0);
            var r  :Rectangle = new Rectangle (0, 0, Settings.TILE_WIDTH, Settings.TILE_HEIGHT);
            var p  :Point     = new Point;
            
            for     (var i:int = m; i < toI; i++){
                for (var j:int = n; j < toJ; j++){
                    if (_levelGraphics[i + j * Settings.LEVEL_WIDTH]){
                        r.width  = _levelGraphics[i + j * Settings.LEVEL_WIDTH].width;
                        r.height = _levelGraphics[i + j * Settings.LEVEL_WIDTH].height;
                        p.x      = i * Settings.TILE_WIDTH  - Scrolling.x;
                        p.y      = j * Settings.TILE_HEIGHT - Scrolling.y;
                        buffer.copyPixels(_levelGraphics[i + j * Settings.LEVEL_WIDTH], r, p, null, null, true); 
                    }
                }
            }
        }
        
        /**
         * Starts a level of ID with a totalBonuses in level
         */
        public static function startLevel(id:int, totalBonuses:int):void{
            Level.ID = id;
            
            time      .set(0);
            bonuses   .set(0);
            bonusesMax.set(totalBonuses);
            keys      .set(0);
            
            _checkpointed = false;
            _stepID       = 0;
            
            Controls.Reset();
            
            for (var i:Number = Engine.main.numChildren - 1; i >= 0; i--){
                if (Engine.main.getChildAt(i) as Shape || Engine.main.getChildAt(i) as Bitmap){
                    Gfx.backgroundAdd(Engine.main.getChildAt(i));
                }
            }
            
            _state = STATE_READY;
            
            Gfx.show();
        }

        
        
        
        // --------------------------------------------------------------------
        // ::::::::                                            LEVEL CONTROLS
        // --------------------------------------------------------------------
        
        public static function stateCheckpoint():void{
            Obs.stateCheckpoint();
            
            _checkpointed = true;
        }
        
        public static function stateDeath():void{
            if (_checkpointed){
                Obs.stateDeath();
            } else {
                stateRestart();
            }
            Level._state = STATE_READY;
        }
        
        public static function stateRestart():void{
            Obs.stateRestart();
            Level._state = STATE_READY;
            
            keys   .set(0);
            bonuses.set(0);
            time   .set(0);
        }
        
        // --------------------------------------------------------------------
        // ::::::::                                     DATA MODIFY / ACQUIRE
        // --------------------------------------------------------------------
        
        
        /**
         * Sets the tile at X and Y coordinates to T.
         */
        public static function tileColliderSet(x:uint, y:uint, t:Tile):void{
            if (x < 0 || y < 0 || x >= Settings.LEVEL_WIDTH || y >= Settings.LEVEL_HEIGHT){
                return;
            }
            
            _levelColliders[x + y * Settings.LEVEL_WIDTH] = t;
        }
        
        /**
         * Sets the tile graphic at X and Y coordinates to T.
         */
        public static function tileGraphicSet(x:uint, y:uint, bg:Class):void{
            if (x < 0 || y < 0 || x >= Settings.LEVEL_WIDTH || y >= Settings.LEVEL_HEIGHT){
                return;
            }
            
            _levelGraphics[x + y * Settings.LEVEL_WIDTH] = GFX.BD(bg);
        }
        
        /**
         * DEPRECATED! Check tileGraphicSet() for usage reference
         */
        public static function backgroundSet(x:uint, y:uint, bg:Class):void{
            tileGraphicSet(x, y, bg);
        }
        
        /**
         * Returns the tile on X and Y coordinates (pixel based), if none return null 
         */
        public static function tileGetFree(x:Number, y:Number):Tile{
            x = Math.floor(x / Settings.TILE_WIDTH);
            y = Math.floor(y / Settings.TILE_HEIGHT);
            
            if (x < 0 || y < 0 || x >= Settings.LEVEL_WIDTH || y >= Settings.LEVEL_HEIGHT){
                return null;
            }
            
            return _levelColliders[x + y * Settings.LEVEL_WIDTH];
        }
        
        /**
         * Returns the tile on X and Y coordinates (tile based), if none return null 
         */
        public static function tileGetGrid(x:uint, y:uint):Tile{
            if (x < 0 || y < 0 || x >= Settings.LEVEL_WIDTH || y >= Settings.LEVEL_HEIGHT){
                return null;
            }
            
            return _levelColliders[x + y * Settings.LEVEL_WIDTH] as Tile;
        }
        
        
        
        // --------------------------------------------------------------------
        // ::::::::                                                   GETTERS
        // --------------------------------------------------------------------
        
        public static function get buffer():BitmapData{ return _buffer; }
        
    }
}