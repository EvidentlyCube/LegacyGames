package net.retrocade.storage {
	public interface IStorage {
		function writeObject(key:String, value:Object):void;
		function writeFlag(key:String, value:Boolean):void;
		function writeNumber(key:String, value:Number):void;
		function writeString(key:String, value:String):void;
		function readObject(key:String, defaultReturn:Object):Object;
		function readFlag(key:String, defaultReturn:Boolean):Boolean;
		function readNumber(key:String, defaultReturn:Number):Number;
		function readString(key:String, defaultReturn:String):String;
		function registerIntegrityViolationCallback(callback:Function):void;
		function has(key:String):Boolean;
		function load():void;
		function save():void;
	}
}
