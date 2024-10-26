package submuncher.core.constants {
    import net.retrocade.retrocamel.core.RetrocamelSoundManager;

    public class Sfx {
        [Embed(source="/../assets/sfx/collect.mp3")] private static var _collect_class:Class;
        [Embed(source="/../assets/sfx/door_open.mp3")] private static var _door_open_class:Class;
        [Embed(source="/../assets/sfx/player_destroyed.mp3")] private static var _player_destroyed_class:Class;
        [Embed(source="/../assets/sfx/push_strong.mp3")] private static var _push_strong_class:Class;
        [Embed(source="/../assets/sfx/push_weak.mp3")] private static var _push_weak_class:Class;
        [Embed(source="/../assets/sfx/spikes.mp3")] private static var _spikes_class:Class;
        [Embed(source="/../assets/sfx/torpedo_explosion.mp3")] private static var _torpedo_explosion_class:Class;
        [Embed(source="/../assets/sfx/torpedo_fire.mp3")] private static var _torpedo_fire_class:Class;
        [Embed(source="/../assets/sfx/shell_attack.mp3")] private static var _shell_acid_class:Class;
        [Embed(source="/../assets/sfx/level_completed.mp3")] private static var _level_completed_class:Class;
        [Embed(source="/../assets/sfx/shell_acid_explode.mp3")] private static var _shell_acid_explode_class:Class;
        [Embed(source="/../assets/sfx/fish_wall_hit.mp3")] private static var _fish_wall_hit:Class;

        public static function playCollectSound():void {
            RetrocamelSoundManager.playSound(_collect_class, 22);
        }

        public static function playPlayerDestroyed():void {
            RetrocamelSoundManager.playSound(_player_destroyed_class, 22);
        }

        public static function playSpikes(volume:Number):void {
            RetrocamelSoundManager.playSound(_spikes_class, 22, volume);
        }

        public static function playDoorOpen():void {
            RetrocamelSoundManager.playSound(_door_open_class, 22);
        }

        public static function playPushWeak():void {
            RetrocamelSoundManager.playSound(_push_weak_class, 22);
        }

        public static function playPushStrong():void {
            RetrocamelSoundManager.playSound(_push_strong_class, 22);
        }

        public static function playTorpedoExplosion():void {
            RetrocamelSoundManager.playSound(_torpedo_explosion_class, 22);
        }

        public static function playTorpedoFire():void {
            RetrocamelSoundManager.playSound(_torpedo_fire_class, 22);
        }

        public static function playShellAcidFire():void {
            RetrocamelSoundManager.playSound(_shell_acid_class, 22);
        }

        public static function playLevelCompleted():void {
            RetrocamelSoundManager.playSound(_level_completed_class, 22);
        }

        public static function playShellAcidExplode():void {
            RetrocamelSoundManager.playSound(_shell_acid_explode_class, 22);
        }

        public static function playFishWallHit():void {
            RetrocamelSoundManager.playSound(_fish_wall_hit, 22);
        }
    }
}
