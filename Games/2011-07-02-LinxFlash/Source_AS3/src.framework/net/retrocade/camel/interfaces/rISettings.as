package net.retrocade.camel.interfaces{
    public interface rISettings{
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Game Settings
        // ::::::::::::::::::::::::::::::::::::::::::::::

        function get eventsCount():uint;
        function get languages():Array;
        function get languagesNames():Array;

        function get gameWidth():uint;
        function get gameHeight():uint;

        function get swfWidth():uint;
        function get swfHeight():uint;

        function get levelWidth():uint;
        function get levelHeight():uint;

        function get saveStorageName():String;
    }
}