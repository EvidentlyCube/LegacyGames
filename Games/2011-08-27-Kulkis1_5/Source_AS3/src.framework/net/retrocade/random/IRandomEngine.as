package net.retrocade.random {
    public interface IRandomEngine {
        function getUint():uint;
        function getInt():int;
        function getNumber():Number;
        function getChance(chance:Number):Boolean;
        function getBool():Boolean;
        function getUintRange(rangeFrom:uint, rangeTo:uint):uint;
        function getIntRange(rangeFrom:int, rangeTo:int):int;
        function getNumberRange(rangeFrom:Number, rangeTo:Number):Number;

        function getSeed():String;
        function setSeed(seed:String):void;

        function randomizeSeed():void;
    }
}