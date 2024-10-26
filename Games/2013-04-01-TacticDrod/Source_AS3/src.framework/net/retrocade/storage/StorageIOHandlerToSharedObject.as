/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 16.03.13
 * Time: 16:54
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.storage {
    import flash.net.SharedObject;

    public class StorageIOHandlerToSharedObject implements IStorageIOHandler{
        private var _sharedObject:SharedObject;

        public function StorageIOHandlerToSharedObject(name:String){
            _sharedObject = SharedObject.getLocal(name);
        }

        public function write(data:Object):void{
            _sharedObject.data.data = data;
            _sharedObject.flush();
        }

        public function read():Object{
            try{
                var data:Object = _sharedObject.data.data;

                if (data != null){
                    return data;
                } else {
                    return {};
                }
            } catch (error:Error){
                return {};
            }

            return {};
        }
    }
}
