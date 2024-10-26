package{
    public function S():S_Instance{
        return S_Instance._instance;
    }
}
import net.retrocade.camel.global.rDisplay;
import net.retrocade.camel.interfaces.rISettings;


class S_Instance implements rISettings{
    public static var _instance:S_Instance = new S_Instance();
    
    // ::::::::::::::::::::::::::::::::::::::::::::::
    // :: Game Settings
    // ::::::::::::::::::::::::::::::::::::::::::::::	
    
    public function get debug():Boolean{ return true; }
    
    public function get eventsCount():uint{ return 0; }
    public function get languages():Array{return ['en']; }
    
    public function get gameWidth():uint{ return rDisplay.flashStage.stageWidth; }
    public function get gameHeight():uint{ return rDisplay.flashStage.stageHeight; }

    public function get gameFullscreenWidth():uint { return rDisplay.flashStage.fullScreenWidth; }
    public function get gameFullscreenHeight():uint { return rDisplay.flashStage.fullScreenHeight; }

    public function get playfieldWidth():uint{ return gameWidth; }
    public function get playfieldHeight():uint{ return gameHeight; }
}