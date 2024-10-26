package submuncher.initialization {
    import flash.display.MovieClip;

    import net.retrocade.retrocamel.core.RetrocamelCore;
    import net.retrocade.retrocamel.core.RetrocamelDisplayManager;
    import net.retrocade.retrocamel.core.RetrocamelStarlingCore;
    import net.retrocade.utils.UtilsDisplay;

    import starling.events.Event;

    import submuncher.core.GlobalEvents;
    import submuncher.core.analytics.AnalyticsCollector;
    import submuncher.editor.StateEditor;
    import submuncher.disclaimer.StateDisclaimer;

    public class SubmuncherMain extends MovieClip {
        private var _initializer:SubmuncherInit;

        public function SubmuncherMain() {
            _initializer = new SubmuncherInit(this);
            _initializer.onInitialized.add(appInitializedHandler);
            _initializer.onInitializationFailed.add(appInitializationFailedHandler);
            _initializer.initialize();
        }

        private function appInitializedHandler():void {
            AnalyticsCollector.init();

//            NativeApplication.nativeApplication.openedWindows[0].maximize();
//            stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
            // NativeApplication.nativeApplication.openedWindows[0].maximize();
            RetrocamelStarlingCore.starlingRoot.stage.addEventListener(Event.RESIZE, onResize);

            RetrocamelDisplayManager.flashStage.color = S.backgroundColor;
            RetrocamelDisplayManager.starlingStage.color = S.backgroundColor;
            RetrocamelDisplayManager.starlingStage.stageWidth = S.gameWidth;
            RetrocamelDisplayManager.starlingStage.stageHeight = S.gameHeight;

            onResize();

//            RetrocamelCore.setState(new StateIngame());
            // RetrocamelCore.setState(new StateEditor());
           RetrocamelCore.setState(new StateDisclaimer());
        }

        private function appInitializationFailedHandler(error:String):void {
            trace(error);
            // NativeApplication.nativeApplication.exit();
        }

        private function onResize(event:Event = null):void {
            UtilsDisplay.calculateScale(S.gameWidth, S.gameHeight, RetrocamelDisplayManager.stageWidth, RetrocamelDisplayManager.stageHeight);

            var width:Number;
            var height:Number;

            if (S.scaleToFull) {
                var scale:Number = Math.min(UtilsDisplay.lastScaleX | 0, UtilsDisplay.lastScaleY | 0);
                width = S.gameWidth * scale;
                height = S.gameHeight * scale;
            } else {
                width = S.gameWidth * UtilsDisplay.lastScaleX;
                height = S.gameHeight * UtilsDisplay.lastScaleY;
            }

//            width = S.gameWidth;
//            height = S.gameHeight;

            RetrocamelStarlingCore.starlingInstance.viewPort.x = (RetrocamelDisplayManager.stageWidth - width) / 2 | 0;
            RetrocamelStarlingCore.starlingInstance.viewPort.y = (RetrocamelDisplayManager.stageHeight - height) / 2 | 0;
            RetrocamelStarlingCore.starlingInstance.viewPort.width = width;
            RetrocamelStarlingCore.starlingInstance.viewPort.height = height;

            GlobalEvents.onStageResized.call();
        }
    }
}
