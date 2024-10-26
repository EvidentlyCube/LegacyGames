package game.global{
    import net.retrocade.camel.objects.rSound;

    public class Sfx{

        [Embed(source="/../assets/sfx/sfxRollOver.mp3")] private static var _sfxRollOver_src: Class;
        [Embed(source="/../assets/sfx/sfxClick.mp3")] private static var _sfxClick_src: Class;
        [Embed(source="/../assets/sfx/sfxPlacePath.mp3")] private static var _sfxPlacePath_src: Class;
        [Embed(source="/../assets/sfx/sfxGotMatch.mp3")] private static var _sfxGotMatch_src: Class;
        [Embed(source="/../assets/sfx/sfxLevelCompleted.mp3")] private static var _sfxLevelCompleted_src: Class;
        [Embed(source="/../assets/sfx/sfxRemovePath.mp3")] private static var _sfxRemovePath_src: Class;
        [Embed(source="/../assets/sfx/sfxError.mp3")] private static var _sfxError_src: Class;
        public static var sfxRollOver      :rSound;
        public static var sfxClick         :rSound;
        public static var sfxPlacePath     :rSound;
        public static var sfxRemovePath    :rSound;
        public static var sfxGotMatch      :rSound;
        public static var sfxError         :rSound;
        public static var sfxLevelCompleted:rSound;

        public static function initialize():void{
            sfxRollOver = new rSound(_sfxRollOver_src);
            sfxClick = new rSound(_sfxClick_src);
            sfxPlacePath = new rSound(_sfxPlacePath_src);
            sfxRemovePath = new rSound(_sfxRemovePath_src);
            sfxGotMatch = new rSound(_sfxGotMatch_src);
            sfxError = new rSound(_sfxError_src);
            sfxLevelCompleted = new rSound(_sfxLevelCompleted_src);
        }
    }
}