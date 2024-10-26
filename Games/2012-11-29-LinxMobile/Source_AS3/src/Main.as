package{
    import flash.display.BitmapData;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.geom.Matrix;
    import flash.ui.Keyboard;
    import flash.utils.ByteArray;

    import com.adobe.images.JPGEncoder;

    import net.retrocade.utils.UGraphic;
    import net.retrocade.utils.UString;

    import game.global.Game;
    import game.global.Make;
    import game.global.Pre;
    import game.global.Score;
    import game.global.Sfx;
    import flash.geom.Rectangle;
    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.camel.global.rEvents;
    import net.retrocade.starling.rStarling;
    import flash.display.Stage3D;
    import starling.core.Starling;
    import net.retrocade.camel.layers.rLayerStarling;
    import starling.textures.Texture;
    import starling.display.Image;
    import net.retrocade.camel.global.rGfx;
    import game.global.LinxBoardSprite;
    import game.states.TStateGame;
    import game.states.TStateTitle;
    import net.retrocade.utils.UDisplay;
    import starling.events.Event;
    import game.global.Storage;

    public class Main extends MovieClip{

        public static const MODE_STAGE_SIZE:uint = 0;
        public static const MODE_FULL_SCREEN_SIZE:uint = 1;
        public static const MODE_SCREEN:uint = 2;

        public static var showDebug:Boolean = false;
        public static var debugSprite:Sprite = new Sprite();
        public static var mode:uint = MODE_STAGE_SIZE;

        public static function isLandscape():Boolean{
            return stage.stageWidth / stage.stageHeight > 1;
        }

        public static function isPortrait():Boolean{
            return stage.stageWidth / stage.stageHeight <= 1;
        }

        public static function forceRescale():void{
            //stage.dispatchEvent(new Event(Event.RESIZE));
        }

        private function onResize(e:* = null):void{
            Starling.current.viewPort.width  = S().gameWidth;
            Starling.current.viewPort.height = S().gameHeight;
            Starling.current.stage.stageWidth  = S().gameWidth;
            Starling.current.stage.stageHeight = S().gameHeight;

            if (Main.showDebug){
                UGraphic.clear(debugSprite)
                    .rectFill(0, 0, 10, 10, 0xFF0000, 1)
                    .rectFill(S().gameWidth - 10, 0, 10, 10, 0xFF0000)
                    .rectFill(0, S().gameHeight - 10, 10, 10, 0xFF0000)
                    .rectFill(S().gameWidth - 10, S().gameHeight - 10, 10, 10, 0xFF0000);

                self.setChildIndex(debugSprite, self.numChildren - 1);
            }
        }

        public static var self :Main;
        public static var stage:Stage;

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Layers
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public function Main():void{
            addEventListener(flash.events.Event.ENTER_FRAME, init);
        }

        private function init(e:flash.events.Event):void{
            Main.self  = this;
            Main.stage = this.stage;

            removeEventListener(flash.events.Event.ENTER_FRAME, init);

            rStarling.initialize(StarlingRoot, stage, new Rectangle(0, 0, S().gameFullscreenWidth, S().gameFullscreenHeight), onStarlingInitialized);

            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align     = StageAlign.TOP_LEFT;
            stage.frameRate = 60;
            //stage.autoOrients = true;

            Pre.preCoreInit();

            rCore.init(stage, this, S(), Make());
            Sfx.initialize();

            Pre.init();

            Game.init();

            rEvents.autoClear = false;

            addChild(debugSprite);
        }

        private function onStarlingInitialized():void{
            Gfx.init();

            stage.addEventListener(flash.events.Event.RESIZE, onResize);

            Game.lBG = new rLayerStarling();
            Game.lStarling = new rLayerStarling(-1, LinxBoardSprite);
            Game.lMinimap = new rLayerStarling();
            Game.lHud = new rLayerStarling();

            Game.background = new Image(Texture.fromBitmapData(rGfx.getBD(Game._background)));
            Game.lBG.addChild(Game.background);

            rStarling.starlingInstance.stage.addEventListener(starling.events.Event.RESIZE, Game.onStageResized);
            Game.onStageResized();

            Starling.current.viewPort.width  = S().gameWidth;
            Starling.current.viewPort.height = S().gameHeight;

            onResize();
            Game.onStageResized();
        }
    }

}