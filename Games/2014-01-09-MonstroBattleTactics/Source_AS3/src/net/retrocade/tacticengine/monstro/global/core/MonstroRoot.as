package net.retrocade.tacticengine.monstro.global.core{
    import flash.display.StageDisplayState;
    import flash.events.KeyboardEvent;
    import flash.utils.setTimeout;

    import net.retrocade.constants.KeyConst;

    import net.retrocade.retrocamel.core.RetrocamelDisplayManager;

    import net.retrocade.retrocamel.core.RetrocamelWindowsManager;
    import net.retrocade.retrocamel.interfaces.IRetrocamelStarlingRoot;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
    import net.retrocade.retrocamel.core.RetrocamelStarlingCore;
    import net.retrocade.tacticengine.core.log;
	import net.retrocade.tacticengine.monstro.global.data.FontEboracum48;
	import net.retrocade.tacticengine.monstro.global.data.FontEboracum64;
	import net.retrocade.tacticengine.monstro.global.data.FontNewRocker40Shadow;
	import net.retrocade.tacticengine.monstro.global.data.FontNewRocker48Shadow;
	import net.retrocade.tacticengine.monstro.global.data.FontNewRocker64;
	import net.retrocade.tacticengine.monstro.global.data.FontNewRocker64Shadow;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventResize;

    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;

    public class MonstroRoot extends Sprite implements IRetrocamelStarlingRoot{
        private var _windowLayer:RetrocamelLayerStarling;

        public function MonstroRoot(){
            _l("Root created");
        }

        public function init():void{
            _l("MonstroRoot.init() -> Initializing starling");
            RetrocamelStarlingCore.starlingInstance.simulateMultitouch = false;

            _l("MonstroRoot.init() -> Registering fonts");
            TextField.registerBitmapFont(new FontEboracum48(), MonstroConsts.FONT_EBORACUM_48);
            TextField.registerBitmapFont(new FontEboracum64(), MonstroConsts.FONT_EBORACUM_64);
            TextField.registerBitmapFont(new FontNewRocker64(), MonstroConsts.FONT_NEW_ROCKER_64);
            TextField.registerBitmapFont(new FontNewRocker40Shadow(), MonstroConsts.FONT_NEW_ROCKER_40_SHADOW);
            TextField.registerBitmapFont(new FontNewRocker48Shadow(), MonstroConsts.FONT_NEW_ROCKER_48_SHADOW);
            TextField.registerBitmapFont(new FontNewRocker64Shadow(), MonstroConsts.FONT_NEW_ROCKER_64_SHADOW);

            _l("MonstroRoot.init() -> Creating layers");
            _windowLayer = new RetrocamelLayerStarling();

            _l("MonstroRoot.init() -> Hooks");
            RetrocamelWindowsManager.hookStarlingLayer(_windowLayer);
            RetrocamelStarlingCore.starlingRoot.stage.addEventListener(Event.RESIZE, onResize);

            _l("MonstroRoot.init() -> Queue resize event");
            setTimeout(onResize, 50, null);
        }

        private function onResize(event:Event):void{
            _l("Stage resized: " + S().gameWidth + "x" + S().gameHeight);
            RetrocamelStarlingCore.starlingInstance.viewPort.width = S().gameWidth;
            RetrocamelStarlingCore.starlingInstance.viewPort.height = S().gameHeight;
            RetrocamelStarlingCore.starlingRoot.stage.stageWidth = S().gameWidth;
            RetrocamelStarlingCore.starlingRoot.stage.stageHeight = S().gameHeight;

            new MonstroEventResize();
        }
    }
}