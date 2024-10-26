package net.retrocade.utils
{
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;

    public class UtilsFile
    {
        public static function writeString(file:File, string:String):void{
            var stream:FileStream = new FileStream();
            stream.open(file, FileMode.WRITE);
            stream.writeUTFBytes(string);
            stream.close();
        }
        public static function readString(file:File):String{
            var stream:FileStream = new FileStream();
            stream.open(file, FileMode.READ);
            var string:String = stream.readUTFBytes(stream.bytesAvailable)
            stream.close();

            return string;
        }
    }
}
