
package net.retrocade.tacticengine.monstro.ingame.utils {
	import net.retrocade.retrocamel.interfaces.IRetrocamelUpdatable;
    import net.retrocade.retrocamel.sound.RetrocamelSound;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.core.IDisposable;
    import net.retrocade.tacticengine.monstro.global.enum.EnumTileset;
    import net.retrocade.tacticengine.monstro.global.states.MonstroStateIngame;
    import net.retrocade.tacticengine.monstro.ingame.ais.classic.MonstroPlayerTurnProcess;
    import net.retrocade.tacticengine.monstro.global.core.MonstroSfx;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventMissionFinished;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTilesetChanged;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTransition;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTurnProcessIsChanging;

    public class MonstroIngameMusicManager implements IDisposable, IRetrocamelUpdatable{
        private static const VOLUME_FADE_SPEED:Number = 0.0625;
        private static const MAX_VOLUME:Number = 1;

        private var _playerTurnMusic:RetrocamelSound;
        private var _enemyTurnMusic:RetrocamelSound;

        private var _currentlyPlayedMusic:RetrocamelSound;
        private var _currentlyFadingMusic:Vector.<RetrocamelSound>;

        private var _currentTileset:EnumTileset;

		[Inject]
        public var stateIngame:MonstroStateIngame;

        public function MonstroIngameMusicManager() {
            _currentlyFadingMusic = new Vector.<RetrocamelSound>();

			Eventer.listen(MonstroEventTurnProcessIsChanging.NAME, onTurnChanged, this);
			Eventer.listen(MonstroEventMissionFinished.NAME, onMissionFinished, this);
			Eventer.listen(MonstroEventTilesetChanged.NAME, onTilesetChanged, this);
			Eventer.listen(MonstroEventTransition.NAME, onTransition, this);
        }

		public function dispose():void{
			Eventer.releaseContext(this);

			while (_currentlyFadingMusic.length){
				var fadingMusic:RetrocamelSound = _currentlyFadingMusic.pop();

				if (!isMusicInCurrentTileset(fadingMusic)){
					fadingMusic.stop();
				}
			}

			_currentlyFadingMusic = null;

			if (_currentlyPlayedMusic){
				_currentlyPlayedMusic.stop();
				_currentlyPlayedMusic = null;
			}

			_playerTurnMusic = null;
			_enemyTurnMusic = null;

		}

        public function update():void{
            if (_currentlyPlayedMusic && _currentlyPlayedMusic.volume < MAX_VOLUME){
                _currentlyPlayedMusic.volume = Math.min(1, _currentlyPlayedMusic.volume + VOLUME_FADE_SPEED);
            }

            for (var i:int = _currentlyFadingMusic.length - 1; i >= 0; i--){
                var fadedMusic:RetrocamelSound = _currentlyFadingMusic[i];

                fadedMusic.volume -= VOLUME_FADE_SPEED;

                if (fadedMusic.volume <= 0){
                    fadedMusic.pause();
                    _currentlyFadingMusic.splice(i, 1);

                    if (fadedMusic != _playerTurnMusic && fadedMusic != _enemyTurnMusic){
                        fadedMusic.stop();
                    }
                }
            }
        }

        private function onTurnChanged(e:MonstroEventTurnProcessIsChanging):void{
            var isPlayerTurn:Boolean = (e.newProcess is MonstroPlayerTurnProcess);
            var musicToPlay:RetrocamelSound;

            musicToPlay = isPlayerTurn ? _playerTurnMusic : _enemyTurnMusic;

			if (musicToPlay === _currentlyPlayedMusic){
				musicToPlay.resume();
				return;
			}

            var indexInFading:int = _currentlyFadingMusic.indexOf(musicToPlay);

            if (indexInFading !== -1){
                _currentlyFadingMusic.slice(indexInFading, 1);
            }

            if (_currentlyPlayedMusic){
                _currentlyFadingMusic.push(_currentlyPlayedMusic);
            }

            _currentlyPlayedMusic = musicToPlay;
            _currentlyPlayedMusic.resume();
        }

        private function onMissionFinished(e:MonstroEventMissionFinished):void{
            if (_currentlyPlayedMusic){
                _currentlyFadingMusic.push(_currentlyPlayedMusic);
            }

            _currentlyPlayedMusic = null;
        }

        private function onTransition(e:MonstroEventTransition):void{
			if (e.type === MonstroEventTransition.TRANSITION_RETURN_TO_MENU){
				if (_currentlyPlayedMusic){
					_currentlyFadingMusic.push(_currentlyPlayedMusic);
					_currentlyPlayedMusic = null;
				}
			}

        }

        private function onTilesetChanged(e:MonstroEventTilesetChanged):void{
            if (e.tileset == _currentTileset){
                return;
            }

            _currentTileset = e.tileset;

			if (_currentlyPlayedMusic === _playerTurnMusic){
				_enemyTurnMusic ? _enemyTurnMusic.stop() : null;

			} else if (_currentlyPlayedMusic === _enemyTurnMusic){
				_playerTurnMusic ? _playerTurnMusic.stop() : null;

			} else {
				_playerTurnMusic ? _playerTurnMusic.stop() : null;
				_enemyTurnMusic ? _enemyTurnMusic.stop() : null;
			}

			switch(e.tileset){
				case(EnumTileset.GREENLAND):
					_playerTurnMusic = MonstroSfx.getMusicIngameGreenlandHuman();
					_enemyTurnMusic = MonstroSfx.getMusicIngameGreenlandMonster();
					break;

				case(EnumTileset.ICE):
					_playerTurnMusic = MonstroSfx.getMusicIngameIceHuman();
					_enemyTurnMusic = MonstroSfx.getMusicIngameIceMonster();
					break;

				case(EnumTileset.LAVA):
					_playerTurnMusic = MonstroSfx.getMusicIngameLavaHuman();
					_enemyTurnMusic = MonstroSfx.getMusicIngameLavaMonster();
					break;
			}

            if (stateIngame.playerControls.isMonster()){
                var tempMusic:RetrocamelSound = _enemyTurnMusic;
                _enemyTurnMusic = _playerTurnMusic;
                _playerTurnMusic = tempMusic;
            }

            _playerTurnMusic.play(9999);
            _playerTurnMusic.pause();
            _playerTurnMusic.volume = 0;

            _enemyTurnMusic.play(9999);
            _enemyTurnMusic.pause();
            _enemyTurnMusic.volume = 0;
        }

        public function isMusicInCurrentTileset(music:RetrocamelSound):Boolean{
            return music == _playerTurnMusic || music == _enemyTurnMusic;
        }
    }
}
