package game.global{
    import net.retrocade.sfxr.SfxrParams;
    import net.retrocade.sfxr.SfxrSynth;

    public class Sfx{
        [Embed(source="../../../assets/sfx/extraLife.mp3")] public static var extraLife:Class;
        [Embed(source="../../../assets/sfx/key.mp3")] public static var key:Class;

        [Embed(source="../../../assets/sfx/sfxr/blockBoom.mp3")] private static var sfxBlockBoom_src:Class;
        [Embed(source="../../../assets/sfx/sfxr/playerBounce.mp3")] private static var sfxPlayerBounce_src:Class;
        [Embed(source="../../../assets/sfx/sfxr/diamond.mp3")] private static var sfxDiamond_src:Class;
        [Embed(source="../../../assets/sfx/sfxr/levelCompleted.mp3")] private static var sfxLevelCompleted_src:Class;
        [Embed(source="../../../assets/sfx/sfxr/rollOver.mp3")] private static var sfxRollOver_src:Class;
        [Embed(source="../../../assets/sfx/sfxr/click.mp3")] private static var sfxClick_src:Class;
        [Embed(source="../../../assets/sfx/sfxr/death.mp3")] private static var sfxDeath_src:Class;
        [Embed(source="../../../assets/sfx/sfxr/changeColor.mp3")] private static var sfxChangeColor_src:Class;

        public static var sfxBlockBoom     :RetrocamelSound;
        public static var sfxPlayerBounce  :RetrocamelSound;
        public static var sfxDiamond       :RetrocamelSound;
        public static var sfxLevelCompleted:RetrocamelSound;
        public static var sfxRollOver      :RetrocamelSound;
        public static var sfxClick         :RetrocamelSound;
        public static var sfxDeath         :RetrocamelSound;
        public static var sfxChangeColor   :RetrocamelSound;

        public static function initialize():void{
            sfxBlockBoom = new RetrocamelSound(new sfxBlockBoom_src());
            sfxPlayerBounce = new RetrocamelSound(new sfxPlayerBounce_src());
            sfxDiamond = new RetrocamelSound(new sfxDiamond_src());
            sfxLevelCompleted = new RetrocamelSound(new sfxLevelCompleted_src());
            sfxRollOver = new RetrocamelSound(new sfxRollOver_src());
            sfxClick = new RetrocamelSound(new sfxClick_src());
            sfxDeath = new RetrocamelSound(new sfxDeath_src());
            sfxChangeColor = new RetrocamelSound(new sfxChangeColor_src());
        }
    }
}