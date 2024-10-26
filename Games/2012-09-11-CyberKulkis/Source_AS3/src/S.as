package{
    import net.retrocade.camel.interfaces.rISettings;
    import net.retrocade.utils.Base64;
    import net.retrocade.utils.USecure;

    public function S():SettingsClass{
        return SettingsClass.instance;
    }
}
import net.retrocade.camel.interfaces.rISettings;
import net.retrocade.utils.Base64;
import net.retrocade.utils.USecure;

class SettingsClass implements rISettings{

    public static var instance:SettingsClass = new SettingsClass();



    // ::::::::::::::::::::::::::::::::::::::::::::::
    // :: API Settings
    // ::::::::::::::::::::::::::::::::::::::::::::::



    // ::::::::::::::::::::::::::::::::::::::::::::::
    // :: Game Settings
    // ::::::::::::::::::::::::::::::::::::::::::::::

    public function get eventsCount     ():uint    { return 1; }
    public function get debug           ():Boolean { return false; }
    public function get languages       ():Array   { return ["en"]; }
    public function get languagesNames  ():Array   { return ["English"]; }

    public function get gameWidth       ():uint { return 600; }
    public function get gameHeight      ():uint { return 600; }

    public function get swfWidth        ():uint { return 600; }
    public function get swfHeight       ():uint { return 600; }

    public function get levelWidth      ():uint { return 600; }
    public function get levelHeight     ():uint { return 600; }


    public function get saveStorageName ():String {
        return 'cyber-kulkis-101'
    }
}