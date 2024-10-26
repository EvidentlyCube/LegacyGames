package net.retrocade.camel.interfaces{
    public interface rIWindow extends rIUpdatable{
        function block():void;
        function isBlocked():Boolean;
        function unblock():void;
        
        function get pauseGame():Boolean;
        function get blockUnder():Boolean;
        
        function show():void;
        function hide():void;
        function resize():void;
    }
}