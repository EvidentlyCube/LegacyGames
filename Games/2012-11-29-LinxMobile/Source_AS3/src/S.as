package{
    import net.retrocade.camel.interfaces.rISettings;
    import net.retrocade.utils.USecure;

    public function S():SettingsClass{
        return SettingsClass.instance;
    }
}

import game.global.Game;

import net.retrocade.camel.interfaces.rISettings;
import net.retrocade.utils.UNumber;
import net.retrocade.utils.USecure;

class SettingsClass implements rISettings{

    public static var instance:SettingsClass = new SettingsClass();

    public function get version():String{ return "1.0.6"; }

    public function get apiNewgroundsId         ():String { return ""; }
    public function get apiNewgroundsKey        ():String { return ""; }

    public function get apiRetrocadeId          ():String { return ""; }

    public function get apiMochiId              ():String { return ""; }
    public function get apiMochiScores          ():Object { return null; }

    public function get apiMochiPreResolution   ():String { return '600x640'; }
    public function get apiMochiPreColor        ():uint   { return 0x213e4c;  }
    public function get apiMochiPreBarColor     ():uint   { return 0x396a82;  }
    public function get apiMochiPreOutlineColor ():uint   { return 0x2b5163;  }




    // ::::::::::::::::::::::::::::::::::::::::::::::
    // :: Game Settings
    // ::::::::::::::::::::::::::::::::::::::::::::::

    public function get eventsCount     ():uint    { return 10; }
    public function get debug           ():Boolean { return false; }
    public function get languages       ():Array   { return ["en"]; }
    public function get languagesNames  ():Array   { return ["English"]; }

    public function get gameWidth       ():uint {
        return Main.stage.stageWidth;
    }

    public function get gameFullscreenWidth():uint {
        return Main.stage.fullScreenWidth;
    }

    public function get gameHeight       ():uint {
        return Main.stage.stageHeight;
    }

    public function get gameFullscreenHeight():uint {
        return Main.stage.fullScreenHeight;
    }

    public function get gameDiameter():Number{
        return Math.sqrt(gameWidth * gameWidth + gameHeight * gameHeight);
    }

    public function get gameMaxDimension():uint {
        return gameWidth > gameHeight ? gameWidth : gameHeight;
    }

    public function get gameMinDimension():uint {
        return gameWidth < gameHeight ? gameWidth : gameHeight;
    }

    public function get swfWidth        ():uint { return gameWidth; }
    public function get swfHeight       ():uint { return gameHeight; }

    public function get levelWidth      ():uint { return 1024; }
    public function get levelHeight     ():uint { return 600; }

    public var zoomInFactor:Number = 1;

    public function get gameScale():Number{
        var scaleX:Number = gameWidth / (tileWidth * tileGridWidth);
        var scaleY:Number = gameHeight / (tileHeight * tileGridHeight);
        var scale:Number;

        var boardSpace:uint = Math.min(gameMinDimension, gameMaxDimension * 5 / 6);
        var boardSize :uint = tileWidth * tileGridWidth;

        scale = boardSpace * zoomInFactor / boardSize;
        var scaleMin:Number = (scale * 50 | 0) / 50;
        return scaleMin;
    }

    public function get saveStorageName ():String {
        return 'linx-mobile-100';
    }

    public function get playfieldOffsetX():Number{
        if (Main.isLandscape()){
            return S().gameWidth * 0.2;
        } else {
            return 0;
        }
    }

    public function get hudThickness():Number{
        return gameMaxDimension /5;
    }

    public function get playfieldOffsetY():Number{ return 0; }

    public function get portraitHudHeight():Number{
        return S().gameHeight * 0.2;
    }

    public function get tileWidth():Number { return 50; }
    public function get tileHeight():Number { return 50; }

    public function get realTileWidth():Number { return tileWidth * gameScale; }
    public function get realTileHeight():Number { return tileHeight * gameScale; }

    public function get tileGridWidth():Number { return 14; }
    public function get tileGridHeight():Number { return 14; }

    public function get totalLevels():Number {
        return 40;
    }

    public function get saveCryptoKey   ():String {
        return "KOzVdWUyksAvWkKS";
    }

    public function get sizeScaler():Number{
        if (gameMaxDimension > 1024)
            return Math.max(1, 1 + (gameMaxDimension - 1024) / 1024);
        else
            return Math.max(0.0, Math.min(1, (gameMaxDimension) / 800));
    }

    public function get useSmallTileset():Boolean{
        return gameScale < 1;
    }
}