package src.PlatformerEngine{
    import flash.display.Bitmap;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Shape;
    import flash.display.Sprite;
    
    import src.Objects.Debug;
    import src.misc.PaperForeground;
    
    public class Gfx{
        private static var _layerBack   :Sprite;
        private static var _layerTiles  :Bitmap;
        private static var _layerFront  :Sprite;
        private static var _layerWindows:Sprite;
        private static var _layerPaper  :PaperForeground;
        private static var _layerDebug  :Shape;
        
        private static var _startMessage:_MC_MESSAGE_LEVEL_START;
        private static var _hud         :_MC_HUD;
        
        private static var _main        :DisplayObjectContainer;
        
        public static function init(main:DisplayObjectContainer):void{
            _layerBack    = new Sprite();
            _layerTiles   = new Bitmap(Level.buffer);
            _layerFront   = new Sprite();
            _layerWindows = new Sprite();
            _layerPaper   = new PaperForeground();
            _layerDebug   = new Shape();
            _hud          = new _MC_HUD();
            
            _main         = main;
            
            _main.addChild( _layerPaper );
            
            Debug.init();
        }
        
        public static function show():void{
            _startMessage = new _MC_MESSAGE_LEVEL_START;
            
            _main.addChild( _layerBack    );
            _main.addChild( _layerTiles   );
            _main.addChild( _layerFront   );
            _main.addChild( _layerWindows );
            _main.addChild( _hud          );
            _main.addChild( _startMessage );
            _main.addChild( _layerDebug   );
            
            paperUpdate();
            hudUpdate();
        }
        
        public static function hide():void{
            _main.removeChild( _layerBack    );
            _main.removeChild( _layerTiles   );
            _main.removeChild( _layerFront   );
            _main.removeChild( _layerWindows );
            _main.removeChild( _hud          );
            _main.removeChild( _startMessage );
            _main.removeChild( _layerDebug   );
        }
        
        public static function paperHide():void{
            _layerPaper.visible = false;
        }
        
        public static function paperShow():void{
            _layerPaper.visible = true;
        }
        
        public static function paperUpdate():void{
            _layerPaper.update();
            _main.setChildIndex( _layerPaper, _main.numChildren - 1 );
        }
        
        public static function hudUpdate():void{
            _hud.update();
        }
        
        public static function messageUpdate():void{
            if (_startMessage.alpha > 0){
                _startMessage.alpha -= 0.02;
            }
        }
        
        public static function backgroundAdd(bg:DisplayObject):void{
            _layerBack.addChild(bg); 
        }
        
        public static function backgroundRemove(bg:DisplayObject):void{
            _layerBack.removeChild(bg); 
        }
        
        public static function frontAdd(front:DisplayObject):void{
            _layerFront.addChild(front);
        }
        
        public static function frontRemove(front:DisplayObject):void{
            _layerFront.removeChild(front);
        }
        
        public static function windowAdd(window:DisplayObject):void{
            _layerWindows.addChild(window);
        }
        
        public static function windowRemove(window:DisplayObject):void{
            _layerWindows.removeChild(window);
        }
        
        public static function clearAll():void{
            while (_layerBack   .numChildren){ _layerBack   .removeChildAt(0); }
            while (_layerFront  .numChildren){ _layerFront  .removeChildAt(0); }
            while (_layerWindows.numChildren){ _layerWindows.removeChildAt(0); }
        }
        
        public static function setScroll(x:int, y:int):void{
            _layerBack.x  = x;
            _layerBack.y  = y;
            
            _layerFront.x = x;
            _layerFront.y = y;
            
            _layerDebug.x = x;
            _layerDebug.y = y;
        }
        
        public static function get layerDebug():Shape { return _layerDebug; }
    }
}