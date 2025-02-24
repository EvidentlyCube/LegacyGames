

package net.retrocade.tacticengine.monstro.global.resources {
    import flash.media.Sound;
    import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	import net.retrocade.retrocamel.core.RetrocamelSoundManager;

    import net.retrocade.retrocamel.sound.RetrocamelSound;

    public class ResourcesFull implements IVersionResources{

        [Embed(source="/../assets/music/intro.mp3")] private static const _intro_class:Class;
        [Embed(source="/../assets/music/outro.mp3")] private static const _outro_class:Class;

        [Embed(source="/../assets/music/musicGreenlandHumans.mp3")] private static const _ingameGreenlandHumans_class:Class;
        [Embed(source="/../assets/music/musicGreenlandMonsters.mp3")] private static const _ingameGreenlandMonsters_class:Class;
        [Embed(source="/../assets/music/musicIceHumans.mp3")] private static const _ingameIceHumans_class:Class;
        [Embed(source="/../assets/music/musicLavalMonsters.mp3")] private static const _ingameLavaMonsters_class:Class;
        [Embed(source="/../assets/music/musicIceMonsters.mp3")] private static const _ingameIceMonsters_class:Class;
        [Embed(source="/../assets/music/musicLavalHumans.mp3")] private static const _ingameLavaHumans_class:Class;
        [Embed(source="/../assets/music/jingleDefeatHumans.mp3")] private static const _defeatHumans_class:Class;
        [Embed(source="/../assets/music/jingleDefeatMonsters.mp3")] private static const _defeatMonsters_class:Class;
        [Embed(source="/../assets/music/jingleVictoryHumans.mp3")] private static const _victoryHumans_class:Class;
        [Embed(source="/../assets/music/jingleVictoryMonsters.mp3")] private static const _victoryMonsters_class:Class;

		private var _jingleDefeatHumans:RetrocamelSound;
		private var _jingleDefeatMonsters:RetrocamelSound;
		private var _jingleVictoryHumans:RetrocamelSound;
		private var _jingleVictoryMonsters:RetrocamelSound;

		private var _musicCache:Dictionary = new Dictionary();
		public function getGreenlandHumanMusic():RetrocamelSound {
			if (!_musicCache[_ingameGreenlandHumans_class]){
				_musicCache[_ingameGreenlandHumans_class] = new RetrocamelSound(_ingameGreenlandHumans_class);
				_musicCache[_ingameGreenlandHumans_class].registerAsMusic();
			}

			return _musicCache[_ingameGreenlandHumans_class];
        }

        public function getGreenlandMonsterMusic():RetrocamelSound {
			if (!_musicCache[_ingameGreenlandMonsters_class]){
				_musicCache[_ingameGreenlandMonsters_class] = new RetrocamelSound(_ingameGreenlandMonsters_class);
				_musicCache[_ingameGreenlandMonsters_class].registerAsMusic();
			}
			return _musicCache[_ingameGreenlandMonsters_class];
        }

        public function getIceHumanMusic():RetrocamelSound {
			if (!_musicCache[_ingameIceHumans_class]){
				_musicCache[_ingameIceHumans_class] = new RetrocamelSound(_ingameIceHumans_class);
				_musicCache[_ingameIceHumans_class].registerAsMusic();
			}
			return _musicCache[_ingameIceHumans_class];
        }

        public function getIceMonsterMusic():RetrocamelSound {
			if (!_musicCache[_ingameIceMonsters_class]){
				_musicCache[_ingameIceMonsters_class] = new RetrocamelSound(_ingameIceMonsters_class);
				_musicCache[_ingameIceMonsters_class].registerAsMusic();
			}
			return _musicCache[_ingameIceMonsters_class];
        }

        public function getLavaHumanMusic():RetrocamelSound {
			if (!_musicCache[_ingameLavaHumans_class]){
				_musicCache[_ingameLavaHumans_class] = new RetrocamelSound(_ingameLavaHumans_class);
				_musicCache[_ingameLavaHumans_class].registerAsMusic();
			}
			return _musicCache[_ingameLavaHumans_class];
        }

        public function getLavaMonsterMusic():RetrocamelSound {
			if (!_musicCache[_ingameLavaMonsters_class]){
				_musicCache[_ingameLavaMonsters_class] = new RetrocamelSound(_ingameLavaMonsters_class);
				_musicCache[_ingameLavaMonsters_class].registerAsMusic();
			}
			return _musicCache[_ingameLavaMonsters_class];
        }

        public function getOutroMusic():Class {
            return _outro_class;
        }

        public function getIntroMusic():Class {
            return _intro_class;
        }

        public function playJingleDefeatHumans():void {
			if (!_jingleDefeatHumans){
				_jingleDefeatHumans = new RetrocamelSound(_defeatHumans_class);
				_jingleDefeatHumans.registerAsMusic();
			}

			_jingleDefeatHumans.play(0);
        }

        public function playJingleDefeatMonsters():void {
			if (!_jingleDefeatMonsters){
				_jingleDefeatMonsters = new RetrocamelSound(_defeatMonsters_class);
				_jingleDefeatMonsters.registerAsMusic();
			}

			_jingleDefeatMonsters.play(0);
        }

        public function playJingleVictoryHumans():void {
			if (!_jingleVictoryHumans){
				_jingleVictoryHumans = new RetrocamelSound(_victoryHumans_class);
				_jingleVictoryHumans.registerAsMusic();
			}

			_jingleVictoryHumans.play(0);
        }

        public function playJingleVictoryMonsters():void {
			if (!_jingleVictoryMonsters){
				_jingleVictoryMonsters = new RetrocamelSound(_victoryMonsters_class);
				_jingleVictoryMonsters.registerAsMusic();
			}

			_jingleVictoryMonsters.play(0);
        }
    }
}
