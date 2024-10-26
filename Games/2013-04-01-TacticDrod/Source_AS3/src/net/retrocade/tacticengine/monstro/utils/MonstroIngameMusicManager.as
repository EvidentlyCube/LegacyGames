/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 09.03.13
 * Time: 11:17
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.utils {
    import net.retrocade.camel.interfaces.rIUpdatable;
    import net.retrocade.camel.objects.rSound;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.core.IDestruct;
    import net.retrocade.tacticengine.monstro.ais.MonstroPlayerTurnProcess;
    import net.retrocade.tacticengine.monstro.core.MonstroSfx;
    import net.retrocade.tacticengine.monstro.events.MonstroEventTurnProcessChange;

    public class MonstroIngameMusicManager implements IDestruct, rIUpdatable{
        private static const VOLUME_FADE_SPEED:Number = 0.0625;
        private static const MAX_VOLUME:Number = 1;

        private var _isPlayerTurn:Boolean = true;
        private var _playerTurn:rSound;
        private var _monsterTurn:rSound;

        public function MonstroIngameMusicManager() {
            Eventer.listen(MonstroEventTurnProcessChange.NAME, onTurnChanged);

            _playerTurn = new rSound(MonstroSfx.getMusicHumanTurn());
            _monsterTurn = new rSound(MonstroSfx.getMusicMonsterTurn());

            _playerTurn.registerAsMusic();
            _monsterTurn.registerAsMusic();

            _playerTurn.play(9999);
            _playerTurn.pause();
            _playerTurn.volume = 0;

            _monsterTurn.play(9999);
            _monsterTurn.pause();
            _monsterTurn.volume = 0;
        }

        public function update():void{
            if (_isPlayerTurn){
                if (!_playerTurn.isPlaying){
                    _playerTurn.resume();
                }

                if (_playerTurn.volume < MAX_VOLUME){
                    _playerTurn.volume += VOLUME_FADE_SPEED;
                }

                if (_monsterTurn.isPlaying){
                    if (_monsterTurn.volume > 0){
                        _monsterTurn.volume -= VOLUME_FADE_SPEED;
                    } else {
                        _monsterTurn.pause();
                    }
                }
            } else {
                if (!_monsterTurn.isPlaying){
                    _monsterTurn.resume();
                }

                if (_monsterTurn.volume < MAX_VOLUME){
                    _monsterTurn.volume += VOLUME_FADE_SPEED;
                }

                if (_playerTurn.isPlaying){
                    if (_playerTurn.volume > 0){
                        _playerTurn.volume -= VOLUME_FADE_SPEED;
                    } else {
                        _playerTurn.pause();
                    }
                }
            }
        }

        private function onTurnChanged(e:MonstroEventTurnProcessChange):void{
            _isPlayerTurn = (e.newProcess is MonstroPlayerTurnProcess);
        }

        public function destruct():void{
            Eventer.release(MonstroEventTurnProcessChange.NAME, onTurnChanged);

            _playerTurn.dispose();
            _monsterTurn.dispose();

            _playerTurn = null;
            _monsterTurn = null;
        }
    }
}
