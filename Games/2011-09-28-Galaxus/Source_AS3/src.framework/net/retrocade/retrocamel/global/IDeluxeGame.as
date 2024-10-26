package net.retrocade.retrocamel.global {
	public interface IDeluxeGame {
		function injectSaveManager(saveManager:IRetrocamelSimpleSave):void;
		function getGameName():String;
	}
}
