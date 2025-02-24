package{
    public function S():S_Instance{
        return S_Instance._instance;
    }
}

import net.retrocade.functions.printf;
import net.retrocade.retrocamel.core.RetrocamelDisplayManager;
import net.retrocade.retrocamel.interfaces.IRetrocamelSettings;
import net.retrocade.retrocamel.model.RetrocamelMochiSettings;
import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;


class S_Instance implements IRetrocamelSettings{
    public static var _instance:S_Instance = new S_Instance();

    public function get apiFlashGameLicenseId():String {
        return "";
    }

// ::::::::::::::::::::::::::::::::::::::::::::::
    // :: Game Settings
    // ::::::::::::::::::::::::::::::::::::::::::::::	
    
    public function get debug():Boolean{ return true; }

    public function get swfWidth():uint {
        return RetrocamelDisplayManager.flashStage.stageWidth;
    }

    public function get swfHeight():uint {
        return RetrocamelDisplayManager.flashStage.stageHeight;
    }

    public function get apiNewgroundsId():String {
        return "38544:aGxXr1Ya";
    }

    public function get apiNewgroundsKey():String {
        return "EoVDXyt0LNF8CCn2LzWRQXrCPIJVOcis";
    }

    public function get mochiSettings():RetrocamelMochiSettings {
        var mochiSettings:RetrocamelMochiSettings = new RetrocamelMochiSettings();
        mochiSettings.id = "0a3808f1ade69a04";
        mochiSettings.preAdResolution = printf("%%x%%", MonstroConsts.gameWidth, MonstroConsts.gameHeight);

        return mochiSettings;
    }

    public function get eventsCount():uint{ return MonstroConsts.EVENT_COUNT; }
    public function get languages():Array{return ['en'] }
    
    public function get gameWidth():uint{ return RetrocamelDisplayManager.flashStage.stageWidth; }
    public function get gameHeight():uint{ return RetrocamelDisplayManager.flashStage.stageHeight; }

    public function get gameFullscreenWidth():uint { return RetrocamelDisplayManager.flashStage.fullScreenWidth; }
    public function get gameFullscreenHeight():uint { return RetrocamelDisplayManager.flashStage.fullScreenHeight; }

    public function get playfieldWidth():uint{ return gameWidth; }
    public function get playfieldHeight():uint{ return gameHeight; }
}