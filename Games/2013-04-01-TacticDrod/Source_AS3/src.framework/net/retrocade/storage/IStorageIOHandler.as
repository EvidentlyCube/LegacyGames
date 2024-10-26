package net.retrocade.storage{
    import flash.utils.ByteArray;

    public interface IStorageIOHandler{
        function write(data:Object):void;
        function read():Object;
    }
}