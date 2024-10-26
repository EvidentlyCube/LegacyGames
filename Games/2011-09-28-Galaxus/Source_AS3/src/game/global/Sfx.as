package game.global {
	import net.retrocade.retrocamel.sound.RetrocamelSound;

	public class Sfx {
		[Embed(source="/../assets/sfx/sfxRollOver.mp3")] private static var _sfxRollOver_src_:Class;
		[Embed(source="/../assets/sfx/sfxClick.mp3")] private static var _sfxClick_src_:Class;
		[Embed(source="/../assets/sfx/sfxFire.mp3")] private static var _sfxFire_src_:Class;
		[Embed(source="/../assets/sfx/sfxExplode.mp3")] private static var _sfxExplode_src_:Class;
		[Embed(source="/../assets/sfx/sfxEnFire.mp3")] private static var _sfxEnFire_src_:Class;
		[Embed(source="/../assets/sfx/sfxDamage.mp3")] private static var _sfxDamage_src_:Class;
		[Embed(source="/../assets/sfx/sfxCoin.mp3")] private static var _sfxCoin_src_:Class;

		public static var sfxRollOver:RetrocamelSound;
		public static var sfxClick:RetrocamelSound;
		public static var sfxFire:RetrocamelSound;
		public static var sfxExplode:RetrocamelSound;
		public static var sfxEnFire:RetrocamelSound;
		public static var sfxDamage:RetrocamelSound;
		public static var sfxCoin:RetrocamelSound;

		public static function initialize():void {
			sfxRollOver = new RetrocamelSound(_sfxRollOver_src_);
			sfxClick = new RetrocamelSound(_sfxClick_src_);
			sfxFire = new RetrocamelSound(_sfxFire_src_);
			sfxExplode = new RetrocamelSound(_sfxExplode_src_);
			sfxEnFire = new RetrocamelSound(_sfxEnFire_src_);
			sfxDamage = new RetrocamelSound(_sfxDamage_src_);
			sfxCoin = new RetrocamelSound(_sfxCoin_src_);
		}
	}
}