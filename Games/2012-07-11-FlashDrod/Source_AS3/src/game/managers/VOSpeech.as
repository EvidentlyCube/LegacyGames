package game.managers{
    import net.retrocade.utils.Base64;

    public class VOSpeech{
        public var character:uint;
        public var mood     :uint;
        public var message  :String;
        public var delay    :uint;
        public var soundID  :uint;

        public function VOSpeech(xml:XML){
            character = xml.@Character;
            mood      = xml.@Mood;
            message   = Base64.decodeWChar(xml.@Message);
            delay     = xml.@Delay;
            soundID   = xml.@DataID;
        }
    }
}