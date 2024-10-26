package net.retrocade.retrocamel.global {
	public interface IRetrocamelSimpleSave {
		function getName():String;
		function setStorage(storageName:String):void;
		function write(dataName:String, data:*, storageName:String = null):void;
		function read(dataName:String, defaultVal:*, storageName:String = null):*;
		function flush(size:int = 0, storageName:String = null):void;
		function deleteData(name:String, storageName:String = null):void;
	}
}
