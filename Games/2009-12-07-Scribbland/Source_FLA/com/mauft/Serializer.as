package com.mauft{   
    import flash.utils.ByteArray;
   
    public class Serializer{
    	 public static function serializeToString(value:Object):ByteArray{
            if(value==null){
                throw new Error("null isn't a legal serialization candidate");
            }
            var bytes:ByteArray = new ByteArray();
            bytes.writeObject(value);
            bytes.position = 0;
            return bytes;
        }
       	public static function readObjectFromStringBytes(value:ByteArray):Object{ 
       		var result:ByteArray=value
       		result.position=0
       		return result.readObject();
       	}
    	/*
        public static function serializeToString(value:Object):String{
            if(value==null){
                throw new Error("null isn't a legal serialization candidate");
            }
            var bytes:ByteArray = new ByteArray();
            bytes.writeObject(value);
            bytes.position = 0;
            var be:Base64Encoder = new Base64Encoder();
            be.encode(bytes.readUTFBytes(bytes.length));
            return be.drain();
        }
       	public static function readObjectFromStringBytes(value:String):Object{
       		var dec:Base64Decoder=new Base64Decoder()
       		dec.decode(value)
       		var result:ByteArray=dec.toByteArray()
       		result.position=0
       		return result.readObject();
       	}*/
       	/*
        public static function readObjectFromStringBytes(value:String):Object{
            var dec:Base64Decoder=new Base64Decoder();
            dec.decode(value);
            var result:ByteArray=dec.drain();
            result.position=0;
            return result.readObject();
        }*/     
    }
}