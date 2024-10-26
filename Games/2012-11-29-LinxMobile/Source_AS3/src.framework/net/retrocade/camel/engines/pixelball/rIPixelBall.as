package net.retrocade.camel.engines.pixelball{
    public interface rIPixelBall{
        function get x()                 :Number;
        function get y()                 :Number;
        function get speedH()            :Number;
        function get speedV()            :Number;
        function get maxSpeedH()         :Number;
        function get maxSpeedV()         :Number;
        function get radius()            :Number;
        
        function get friction()          :Number;
        function get precision()         :Number;
        function get steps()             :int;
        
        function set x(val:Number)       :void;
        function set y(val:Number)       :void;
        function set speedH(val:Number)  :void;
        function set speedV(val:Number)  :void;
    }
}