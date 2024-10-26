package net.retrocade.camel.core{
    import flash.net.SharedObject;

    use namespace retrocamel_int;

    public class rSave{
        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

        /**
         * Shared object used to work with saves
         */
        private static var sharedObject:SharedObject;




        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        // Static Constructor
        {setStorage();}

        public function rSave(){ new Error("Can't instantiate SaveLoad object - please use static methods only!") }

        public static function setStorage(storageName:String = null):void{
            sharedObject = SharedObject.getLocal(storageName || rCore.settings.saveStorageName, "/");
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Save & Load
        // ::::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Saves given data with encryption (if is string)
         */
        public static function save(dataName:String, data:*):void{
            sharedObject.data[dataName] = data;
        }

        /**
         * Reads and unencrypts data
         */
        public static function load(dataName:String, def:*):*{
            var s:* = sharedObject.data[dataName];
            if (s == null || s == undefined)
                return def;

            return sharedObject.data[dataName];
        }

        /**
         * Writes and flushes a data, without encryption
         */
        public static function write(dataName:String, data:*):void{
            sharedObject.data[dataName] = data;
            flush();
        }

        /**
         * Reads data, without encryption
         */
        public static function read(dataName:String, def:*):*{
            if (sharedObject.data[dataName] == undefined)
                return def;

            return sharedObject.data[dataName];
        }

        public static function deleteData(name:String):void{
            delete sharedObject.data[name];
        }
        public static function flush(size:int = 0):void{
            sharedObject.flush(size);
        }

    }
}