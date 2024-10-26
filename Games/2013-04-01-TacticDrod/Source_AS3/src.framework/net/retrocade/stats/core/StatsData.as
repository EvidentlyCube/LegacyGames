package net.retrocade.stats.core {
    import flash.utils.IDataInput;
    import flash.utils.IDataOutput;
    import flash.utils.IExternalizable;

    import net.retrocade.camel.global.retrocamel_int;

    use namespace retrocamel_int;

    public class StatsData implements IExternalizable {
        public function StatsData(key:String = "", value:String = "", meta:Array = null) {
            _key = key;
            _value = value;
            _meta = meta;

            _timestamp = getCurrentTimestamp();
        }

        public function writeExternal(output:IDataOutput):void {
            output.writeUTF(_key);
            output.writeUTF(_value);
            output.writeUTF(_timestamp);
            output.writeObject(_meta);
        }

        public function get key():String {
            return _key;
        }

        public function get value():String {
            return _value;
        }

        public function get timestamp():String {
            return _timestamp;
        }

        public function get meta():Array {
            return _meta;
        }

        public function get metaLength():int{
            if (_meta){
                var count:int = 0;
                for (var field:String in _meta){
                    count++;
                }

                return count;
            } else {
                return 0;
            }
        }

        public function readExternal(input:IDataInput):void {
            _key = input.readUTF();
            _value = input.readUTF();
            _timestamp = input.readUTF();
            _meta = input.readObject();
        }

        private function getCurrentTimestamp():String {
            var date:Date = new Date();
            return (date.time / 1000 | 0).toString();
        }

        private var _key:String;
        private var _value:String;
        private var _timestamp:String;
        private var _meta:Array;
    }
}