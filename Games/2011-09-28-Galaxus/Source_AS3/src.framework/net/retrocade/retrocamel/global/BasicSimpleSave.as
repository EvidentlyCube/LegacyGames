package net.retrocade.retrocamel.global {
	import flash.net.SharedObject;

	public class BasicSimpleSave implements IRetrocamelSimpleSave {
		/**
		 * Shared object used to work with saves
		 */
		private var currentSharedObject:SharedObject;

		/**
		 * An array of shared objects: storagename => SharedObject
		 */
		private var sharedObjects:Object = {};


		public function getName():String {
			return "Basic simple save";
		}

		public function setStorage(storageName:String):void {
			if (!storageName || storageName.length == 0)
				throw new ArgumentError("Invalid storage name");

			if (!sharedObjects[storageName]) {
				sharedObjects[storageName] = SharedObject.getLocal(storageName);
			}

			currentSharedObject = sharedObjects[storageName];
		}

		/**
		 * Writes data to the currently set SharedObject or the one with a specified name.
		 * If you try to access a storage which hasn't been previosly set even once you'll get an error.
		 * @param dataName Name of the data to save
		 * @param data Value to save
		 * @param storageName Optional custom storage name
		 */
		public function write(dataName:String, data:*, storageName:String = null):void {
			var so:SharedObject;

			if (storageName) {
				if (!sharedObjects[storageName])
					throw new Error("Tried to access not yet created storage: " + storageName);

				so = sharedObjects[storageName];
			} else
				so = currentSharedObject;

			so.data[dataName] = data;
		}

		/**
		 * Reads data from the currently set SharedObject or the one with a specified name. If the data was not set
		 * the default value will be retrieved instead.
		 * If you try to access a storage which hasn't been previosly set even once you'll get an error.
		 * @param dataName Name of the data to read
		 * @param defaultVal Default value to return if no data was found
		 * @param storageName Optional custom storage name
		 * @return Previously written data
		 */
		public function read(dataName:String, defaultVal:*, storageName:String = null):* {
			var so:SharedObject;
			if (storageName) {
				if (!sharedObjects[storageName])
					throw new Error("Tried to access not yet created storage: " + storageName);

				so = sharedObjects[storageName];
			} else
				so = currentSharedObject;

			if (!so.data.hasOwnProperty(dataName))
				return defaultVal;

			return so.data[dataName];
		}

		public function flush(size:int = 0, storageName:String = null):void {
			var so:SharedObject;
			if (storageName) {
				if (!sharedObjects[storageName])
					throw new Error("Tried to access not yet created storage: " + storageName);

				so = sharedObjects[storageName];
			} else
				so = currentSharedObject;

			so.flush(size);
		}

		public function deleteData(name:String, storageName:String = null):void {
			var so:SharedObject;
			if (storageName) {
				if (!sharedObjects[storageName])
					throw new Error("Tried to access not yet created storage: " + storageName);

				so = sharedObjects[storageName];
			} else
				so = currentSharedObject;

			delete so.data[name];
		}
	}
}
