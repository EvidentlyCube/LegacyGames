package submuncher.initialization {
    // import flash.desktop.NativeApplication;
    import flash.display.Stage;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    // import flash.filesystem.File;
    import flash.geom.Rectangle;

    import net.retrocade.random.Random;
    import net.retrocade.random.RandomEngineType;

    import net.retrocade.retrocamel.core.RetrocamelCore;
    import net.retrocade.retrocamel.core.RetrocamelStarlingCore;
    import net.retrocade.retrocamel.core.RetrocamelWindowsManager;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
    import net.retrocade.retrocamel.locale.RetrocamelLocaleParserRetrocadeProperties;
    import net.retrocade.signal.Signal;

    import starling.text.TextField;

    import submuncher.core.constants.GameFile;

    import S;
    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.SGetter;
    import submuncher.core.fonts.FontGreen;
    import submuncher.core.fonts.FontGreenBold;
    import submuncher.core.fonts.FontOrange;
    import submuncher.core.fonts.FontOrangeBold;
    import submuncher.core.fonts.FontPixelmix;
    import submuncher.core.fonts.FontPixelmixShadow;
    import submuncher.core.fonts.FontRed;
    import submuncher.core.fonts.FontRedBold;
    import submuncher.core.repositories.LevelGroupsRepository;
    import submuncher.core.repositories.LevelMetadata;
    import submuncher.core.repositories.LevelRepository;
    import submuncher.core.submuncher_init;

    use namespace submuncher_init;

    public class SubmuncherInit {
        private var _root:SubmuncherMain;
        private var _onInitialized:Signal;
        private var _onInitializationFailed:Signal;

        private var _windowLayer:RetrocamelLayerStarling;

        public function get onInitialized():Signal {
            return _onInitialized;
        }

        public function get onInitializationFailed():Signal {
            return _onInitializationFailed;
        }

        public function SubmuncherInit(root:SubmuncherMain) {
            _root = root;

            _onInitialized = new Signal();
            _onInitializationFailed = new Signal();
        }

        public function dispose():void{
            _onInitialized.dispose();
            _onInitializationFailed.dispose();

            _onInitialized = null;
            _onInitializationFailed = null;
        }

        public function initialize():void {
            _root.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
        }

        private function enterFrameHandler(event:Event):void {
            // if (NativeApplication.nativeApplication.openedWindows.length === 0){
                // return;
            // }

            _root.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);

            step1_loadFiles();
        }

        private function step1_loadFiles():void {
            FileLoader.onLoadingFinished.add(step2_filesLoaded);
            FileLoader.startLoading();
        }

        private function step2_filesLoaded(result:*):void{
            if (result === true){
                step3_setStageProperties()
            } else {
                onInitializationFailed.call(result);
            }
        }

        private function step3_setStageProperties():void {
            var stage:Stage = _root.stage;
            stage.scaleMode = StageScaleMode.SHOW_ALL;
            // stage.align     = StageAlign.TOP_LEFT;
            stage.frameRate = 60;

            step4_initializeFramework();
        }

        private function step4_initializeFramework():void {
            RetrocamelCore.initFlash(_root.stage, _root, SGetter(), null);

            Random.defaultEngineType = RandomEngineType.MULTIPLY_WITH_CARRY;
            Random.defaultEngine.randomizeSeed();

            step5_initializeStarling();

        }

        private function step5_initializeStarling():void {
            RetrocamelStarlingCore.initialize(SubmuncherStarlingRoot, _root.stage, new Rectangle(0, 0, S.gameWidth, S.gameHeight), step6_initializeTextures);
        }

        private function step6_initializeTextures():void{
            Gfx.initialize();
            step7_initializeFont();
        }

        public function step7_initializeFont():void {
            TextField.registerBitmapFont(new FontPixelmix(), S.FONT_OLD);
            TextField.registerBitmapFont(new FontPixelmixShadow(), S.FONT_OLD_SHADOW);
            TextField.registerBitmapFont(new FontGreen(), S.FONT_GREEN);
            TextField.registerBitmapFont(new FontOrange(), S.FONT_ORANGE);
            TextField.registerBitmapFont(new FontRed(), S.FONT_RED);
            TextField.registerBitmapFont(new FontGreenBold(), S.FONT_GREEN_BOLD);
            TextField.registerBitmapFont(new FontOrangeBold(), S.FONT_ORANGE_BOLD);
            TextField.registerBitmapFont(new FontRedBold(), S.FONT_RED_BOLD);

            step8_loadI18N();
        }

        public function step8_loadI18N():void {
            RetrocamelLocaleParserRetrocadeProperties.parse(GameFile.I18N_ENGLISH.getString(), "en");
            step9_loadLevels();
        }

        private function step9_loadLevels():void{
            LevelRepository.init();
            LevelGroupsRepository.init();

            // LevelRepository.addCustomLevel(File.applicationDirectory.resolvePath("levels/test.oel"));

            step10_initializeLayers();
        }

        private function step10_initializeLayers():void{
            _windowLayer = new RetrocamelLayerStarling();
            RetrocamelWindowsManager.hookStarlingLayer(_windowLayer);

            step11_finishInitialization();
        }

        private function step11_finishInitialization():void{
            onInitialized.call();
        }
    }
}
