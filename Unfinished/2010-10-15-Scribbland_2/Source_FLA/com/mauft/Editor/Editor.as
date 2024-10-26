package com.mauft.Editor{
    import flash.display.Shape;
    import flash.display.Stage;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    
    public class Editor{
        public static function get screenW():uint{return _screenWidth;}
        public static function get screenH():uint{return _screenHeight;}
        public static function get tileW():uint{return _tileWidth;}
        public static function get tileH():uint{return _tileHeight;}
        public static function get levelW():uint{return _levelWidth;}
        public static function get levelH():uint{return _levelHeight;}
        public static function get stage():Stage{return _stage;}
        public static function get layers():uint{return _layers;}
        
        private static var ___initialized:Boolean=false;
        private static var ___stageScale:String;
        private static var ___stageAlign:String;
        private static var _stage:Stage;
        
        private static var _screenWidth:uint;
        private static var _screenHeight:uint;
        
        private static var _tileWidth:uint;
        private static var _tileHeight:uint;
        
        private static var _levelWidth:uint;
        private static var _levelHeight:uint;
        
        private static var _layersArray:Array;
        private static var _layers:uint=0;
        
        private static var _winLevel:WindowLevel
        private static var _winHelp:WindowHelp
        private static var _winOptions:WindowOptions
        private static var _winItems:WindowItems
        
        private static var _darkener:Shape
        public function Editor(){}
        public static function Init(
        stg:Stage,
        ScreenWidth:uint, ScreenHeight:uint,
        TileWidth:uint, TileHeight:uint,
        LevelWidthInTiles:uint, LevelHeightInTiles:uint
        ):void{
            if (___initialized){return}
            _stage=stg
            _screenWidth=ScreenWidth
            _screenHeight=ScreenHeight
            _tileWidth=TileWidth
            _tileHeight=TileHeight
            _levelWidth=LevelWidthInTiles
            _levelHeight=LevelHeightInTiles
            
            _darkener=new Shape
            _darkener.graphics.beginFill(0)
            _darkener.graphics.drawRect(0,0,_stage.stageWidth, _stage.stageHeight)
            _darkener.graphics.endFill()
            
            _winLevel=new WindowLevel()
            _winHelp=new WindowHelp
            _winOptions=new WindowOptions
            _winItems=new WindowItems
            
            ___initialized=true
        }
        public static function startEditor():void{
            ___stageScale=_stage.scaleMode
            ___stageAlign=_stage.align
            _stage.scaleMode=StageScaleMode.NO_SCALE
            _stage.align=StageAlign.TOP_LEFT
            
            _stage.addChild(_darkener)
            
            _stage.addChild(_winLevel)
            _stage.addChild(_winHelp)
            _stage.addChild(_winOptions)
            _stage.addChild(_winItems)
            
            _stage.addEventListener(KeyboardEvent.KEY_DOWN, kDown)
            _stage.addEventListener(KeyboardEvent.KEY_UP, kUp)
            _stage.addEventListener(Event.ENTER_FRAME, step)
            
            _winLevel.Start()
        }
        public static function endEditor():void{
            _stage.scaleMode=___stageScale
            _stage.align=___stageAlign
            
            _stage.removeChild(_darkener)
            
            _stage.removeChild(_winLevel)
            _stage.removeChild(_winHelp)
            _stage.removeChild(_winOptions)
            _stage.removeChild(_winItems)
            
            
            _stage.removeEventListener(KeyboardEvent.KEY_DOWN, kDown)
            _stage.removeEventListener(KeyboardEvent.KEY_UP, kUp)
            _stage.removeEventListener(Event.ENTER_FRAME, step)
            
            _winLevel.End()
        }
        private static function step(e:Event):void{
            _winLevel.Step()
            _winItems.Step()
        }
        private static function kDown(e:KeyboardEvent):void{
            switch(e.keyCode){
                case(Keyboard.DOWN):
                    _winLevel.scroll(0, 30);
                    break;
                case(Keyboard.UP):
                    _winLevel.scroll(0, -30);
                    break;
                case(Keyboard.LEFT):
                    _winLevel.scroll(-30, 0);
                    break;
                case(Keyboard.RIGHT):
                    _winLevel.scroll(30, 0);
                    break;
            }
        }
        private static function kUp(e:KeyboardEvent):void{
            
        }
        internal static function selectLayer(lay:Layer):void{
            _winItems.selectLayer(lay)
        }
        
        //END USER FUNCTIONS:
        internal static function newLayer(lay:Layer):void{
            _winOptions.addLayer(lay)
            _winLevel.newLayer(lay)
        }
        internal static function newItem(it:Item):void{
            _winOptions.addItem(it)
        }
    }
}