package game.global {
	import net.retrocade.sfxr.SfxrParams;
	import net.retrocade.sfxr.SfxrSynth;
    import net.retrocade.retrocamel.sound.RetrocamelSound;

	public class Sfx {
		[Embed(source="/../assets/sfx/diamond1.mp3")]
		private static var _diamond1:Class;
		[Embed(source="/../assets/sfx/diamond2.mp3")]
		private static var _diamond2:Class;
		[Embed(source="/../assets/sfx/diamond3.mp3")]
		private static var _diamond3:Class;
		[Embed(source="/../assets/sfx/diamond4.mp3")]
		private static var _diamond4:Class;
		[Embed(source="/../assets/sfx/diamond5.mp3")]
		private static var _diamond5:Class;
		[Embed(source="/../assets/sfx/diamond6.mp3")]
		private static var _diamond6:Class;
		[Embed(source="/../assets/sfx/diamond7.mp3")]
		private static var _diamond7:Class;
		[Embed(source="/../assets/sfx/diamond8.mp3")]
		private static var _diamond8:Class;

		[Embed(source="/../assets/sfx/collect1.mp3")]
		private static var _collect1:Class;
		[Embed(source="/../assets/sfx/collect2.mp3")]
		private static var _collect2:Class;
		[Embed(source="/../assets/sfx/collect3.mp3")]
		private static var _collect3:Class;

		[Embed(source="/../assets/sfx/boulder1.mp3")]
		private static var _boulder1:Class;
		[Embed(source="/../assets/sfx/boulder2.mp3")]
		private static var _boulder2:Class;
		[Embed(source="/../assets/sfx/boulder3.mp3")]
		private static var _boulder3:Class;
		[Embed(source="/../assets/sfx/boulder4.mp3")]
		private static var _boulder4:Class;

		[Embed(source="/../assets/sfx/amoeba1.mp3")]
		private static var _amoeba1:Class;
		[Embed(source="/../assets/sfx/amoeba2.mp3")]
		private static var _amoeba2:Class;
		[Embed(source="/../assets/sfx/amoeba3.mp3")]
		private static var _amoeba3:Class;
		[Embed(source="/../assets/sfx/amoeba4.mp3")]
		private static var _amoeba4:Class;
		[Embed(source="/../assets/sfx/amoeba5.mp3")]
		private static var _amoeba5:Class;

		[Embed(source="/../assets/sfx/explosion.mp3")]
		public static var explosion:Class;
		[Embed(source="/../assets/sfx/door.mp3")]
		public static var door:Class;
		[Embed(source="/../assets/sfx/boulderPush.mp3")]
		public static var boulderPush:Class;
		[Embed(source="/../assets/sfx/wallGrow.mp3")]
		public static var wallGrow:Class;
		[Embed(source="/../assets/sfx/magicWall.mp3")]
		public static var magicWall:Class;
		[Embed(source="/../assets/sfx/exitOpened.mp3")]
		public static var exitOpened:Class;


		public static function get diamondFall():Class {
			return Sfx["_diamond" + (Math.random() * 8 + 1 | 0).toString()];
		}

		public static function get boulderFall():Class {
			return Sfx["_boulder" + (Math.random() * 4 + 1 | 0).toString()];
		}

		public static function get diamondCollect():Class {
			return Sfx["_collect" + (Math.random() * 3 + 1 | 0).toString()];
		}

		public static function get amoebaGrow():Class {
			return Sfx["_amoeba" + (Math.random() * 5 + 1 | 0).toString()];
		}


        [Embed(source="../../../assets/sfx/sfxr/sfxRollOver.mp3")] private static var sfxRollOver_src:Class;
        [Embed(source="../../../assets/sfx/sfxr/sfxClick.mp3")] private static var sfxClick_src:Class;
        [Embed(source="../../../assets/sfx/sfxr/sfxWalk.mp3")] private static var sfxWalk_src:Class;
        [Embed(source="../../../assets/sfx/sfxr/sfxAlert.mp3")] private static var sfxAlert_src:Class;
        [Embed(source="../../../assets/sfx/sfxr/sfxTimeCount.mp3")] private static var sfxTimeCount_src:Class;

        public static var sfxRollOver     :RetrocamelSoundAlt;
        public static var sfxClick  :RetrocamelSoundAlt;
        public static var sfxWalk       :RetrocamelSoundAlt;
        public static var sfxAlert:RetrocamelSoundAlt;
        public static var sfxTimeCount      :RetrocamelSound;

		public static function initialize():void {
			sfxRollOver = new RetrocamelSoundAlt(new sfxRollOver_src());
			sfxClick = new RetrocamelSoundAlt(new sfxClick_src());
			sfxWalk = new RetrocamelSoundAlt(new sfxWalk_src());
			sfxAlert = new RetrocamelSoundAlt(new sfxAlert_src());
			sfxTimeCount = new RetrocamelSound(new sfxTimeCount_src());
		}
	}
}