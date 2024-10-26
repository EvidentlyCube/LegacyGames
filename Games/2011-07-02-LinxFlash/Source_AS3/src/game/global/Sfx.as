package game.global{
    import net.retrocade.camel.core.rSound;

    public class Sfx{
        [Embed(source="/../assets/sfx/sfxRollOver.mp3")] public static var _sfxRollOver_src_:Class;
        [Embed(source="/../assets/sfx/sfxClick.mp3")] public static var _sfxClick_src_:Class;
        [Embed(source="/../assets/sfx/sfxPlacePath.mp3")] public static var _sfxPlacePath_src_:Class;
        [Embed(source="/../assets/sfx/sfxRemovePath.mp3")] public static var _sfxRemovePath_src_:Class;
        [Embed(source="/../assets/sfx/sfxGotMatch.mp3")] public static var _sfxGotMatch_src_:Class;
        [Embed(source="/../assets/sfx/sfxLevelCompleted.mp3")] public static var _sfxLevelCompleted_src_:Class;

        public static function sfxRollOverPlay(): void {
            rSound.playSound(_sfxRollOver_src_);
        }
        public static function sfxClickPlay(): void {
            rSound.playSound(_sfxClick_src_);
        }
        public static function sfxPlacePathPlay(): void {
            rSound.playSound(_sfxPlacePath_src_);
        }
        public static function sfxRemovePathPlay(): void {
            rSound.playSound(_sfxRemovePath_src_);
        }
        public static function sfxGotMatchPlay(): void {
            rSound.playSound(_sfxGotMatch_src_);
        }
        public static function sfxLevelCompletedPlay(): void {
            rSound.playSound(_sfxLevelCompleted_src_);
        }
    }
}