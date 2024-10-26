package game.global
{
    import flash.media.Sound;
    import flash.media.SoundTransform;
    import net.retrocade.retrocamel.core.RetrocamelSoundManager;

    public class RetrocamelSoundAlt
    {
        private var _sound:Sound;
        public function RetrocamelSoundAlt(sound:Sound)
        {
            _sound = sound;
        }

        public function play(): void
        {
            if (RetrocamelSoundManager.soundVolume >= 0.01) {
                _sound.play(0, 0, new SoundTransform(RetrocamelSoundManager.soundVolume));
            }
        }
    }
}