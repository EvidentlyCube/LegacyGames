package com.mauft
{
   import flash.net.SharedObject;
   
   public class SaveLoad
   {
      
      private static var sharedObject:SharedObject;
       
      
      public function SaveLoad()
      {
         super();
         new Error("Can\'t instantiate SaveLoad object - please use static methods only!");
      }
      
      public static function setStorage(param1:String = "") : void
      {
         sharedObject = SharedObject.getLocal(param1);
      }
      
      public static function addData(param1:String, param2:Object, param3:String = "") : void
      {
         if(param3 != "" && Boolean(param2 as String))
         {
            param2 = Crypto.encrypt(String(param2),param3);
         }
         sharedObject.data[param1] = param2;
      }
      
      public static function getData(param1:String, param2:String = "") : Object
      {
         if(param2 != "")
         {
            return Crypto.decrypt(sharedObject.data[param1],param2);
         }
         return sharedObject.data[param1];
      }
      
      public static function flushData() : void
      {
         sharedObject.flush();
      }
   }
}
