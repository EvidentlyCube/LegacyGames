package net.retrocade.camel.interfaces{
    public interface rISettings{
        
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: API Settings
        // ::::::::::::::::::::::::::::::::::::::::::::::	
        
        function get apiNewgroundsId():String;
        function get apiNewgroundsKey():String;
        
        function get apiRetrocadeId():String;
        
        function get apiMochiId():String;
        function get apiMochiScores():Object;
        function get apiMochiPreResolution():String;
        
        function get apiMochiPreColor():uint;
        function get apiMochiPreBarColor():uint;
        function get apiMochiPreOutlineColor():uint;
        
        
        
        
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
    }
}