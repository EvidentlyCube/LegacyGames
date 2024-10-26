package com.mauft{
    import flash.net.SharedObject;
    
    public class SaveLoad{
        private static var sharedObject:SharedObject;
        
        public function SaveLoad(){ new Error("Can't instantiate SaveLoad object - please use static methods only!") }
        
        public static function setStorage(storageName:String = ""):void{
            sharedObject = SharedObject.getLocal(storageName);
        }
        
        public static function addData(dataName:String, data:Object, cryptKey:String = ""):void{
            if (cryptKey != "" && data as String){
                data = Crypto.encrypt(String(data), cryptKey);
            }
            
            sharedObject.data[dataName] = data;
        }

        public static function getData(dataName:String, cryptKey:String = ""):Object{
            if (cryptKey != ""){
                return Crypto.decrypt(sharedObject.data[dataName], cryptKey);
            }
            return sharedObject.data[dataName];
        }
        
        public static function flushData():void{
            sharedObject.flush();
        }
        
    }
}