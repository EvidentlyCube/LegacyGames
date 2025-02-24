

package net.retrocade.retrocamel.interfaces{

    import net.retrocade.retrocamel.model.RetrocamelMochiSettings;

    public interface IRetrocamelSettings{

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Game Settings
        // ::::::::::::::::::::::::::::::::::::::::::::::

        function get debug():Boolean;

        function get eventsCount():uint;
        function get languages():Array;

        function get gameWidth():uint;
        function get gameHeight():uint;

        function get swfWidth():uint;
        function get swfHeight():uint;

        function get apiNewgroundsId():String;
        function get apiNewgroundsKey():String;

        function get apiFlashGameLicenseId():String;

        function get mochiSettings():RetrocamelMochiSettings;
    }
}