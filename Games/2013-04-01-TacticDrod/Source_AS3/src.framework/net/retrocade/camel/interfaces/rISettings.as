package net.retrocade.camel.interfaces{
    public interface rISettings{
        
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Game Settings
        // ::::::::::::::::::::::::::::::::::::::::::::::	
        
        function get debug():Boolean;
        
        function get eventsCount():uint;
        function get languages():Array;
        
        function get gameWidth():uint;
        function get gameHeight():uint;
    }
}