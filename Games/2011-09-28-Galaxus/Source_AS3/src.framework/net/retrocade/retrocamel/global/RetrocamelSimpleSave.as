package net.retrocade.retrocamel.global{

    import net.retrocade.retrocamel.core.*;

    use namespace retrocamel_int;

    public class RetrocamelSimpleSave{
        private static var _instance:IRetrocamelSimpleSave = new BasicSimpleSave();

        public function RetrocamelSimpleSave(){ new Error("Can't instantiate SaveLoad object - please use static methods only!") }

        public static function injectInstance(instance:IRetrocamelSimpleSave):void{
	        _instance = instance;
        }

        public static function doTest():void{
            trace("TEST!");
            trace("Instance name: " + _instance.getName());
        }
        public static function setStorage(storageName:String):void{
            _instance.setStorage(storageName);
        }


        /**
         * Writes data to the currently set SharedObject or the one with a specified name.
         * If you try to access a storage which hasn't been previosly set even once you'll get an error.
         * @param dataName Name of the data to save
         * @param data Value to save
         * @param storageName Optional custom storage name
         */
        public static function write(dataName:String, data:*, storageName:String = null):void{
            return _instance.write(dataName, data, storageName);
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
        public static function read(dataName:String, defaultVal:*, storageName:String = null):*{
            return _instance.read(dataName, defaultVal, storageName);
        }

        /**
         * Writes data to the currently set SharedObject or the one with a specified name.
         * Also perfoorms a flush.
         * If you try to access a storage which hasn't been previosly set even once you'll get an error.
         * @param dataName Name of the data to save
         * @param data Value to save
         * @param storageName Optional custom storage name
         */
        public static function writeFlush(dataName:String, data:*, storageName:String = null):void{
            write(dataName, data, storageName);
            flush();
        }

        /**
         * Removed data from the currently set SharedObject or the one with a specified name.
         * If you try to access a storage which hasn't been previosly set even once you'll get an error. 
         * @param name Name of the ddata to remove
         * @param storageName Optional custom storage name
         */
        public static function deleteData(name:String, storageName:String = null):void{
            _instance.deleteData(name, storageName);
        }
        
        /**
         * Flushes the currently set SharedObject or the one with a specified name.
         * If you try to access a storage which hasn't been previosly set even once you'll get an error. 
         * @param size The requested diskspace 
         * @param storageName Optional custom storage name
         */
        public static function flush(size:int = 0, storageName:String = null):void{
            _instance.flush(size, storageName);
        }

    }
}