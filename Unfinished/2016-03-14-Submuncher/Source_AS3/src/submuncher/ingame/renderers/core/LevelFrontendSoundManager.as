package submuncher.ingame.renderers.core {
    import flash.utils.Dictionary;

    import submuncher.core.constants.GameEvent;

    import submuncher.core.constants.GameObjectType;
    import submuncher.core.constants.Sfx;
    import submuncher.ingame.core.Game;
    import submuncher.ingame.gameObjects.EnemySpikes;
    import submuncher.ingame.gameObjects.GameObject;
    import submuncher.ingame.gameObjects.ObjectCrate;
    import submuncher.ingame.vfx.EffectExplosion;
    import submuncher.ingame.vfx.IEffect;

    public class LevelFrontendSoundManager {
        private var _extGame:Game;
        private var _effectCreatedMap:Dictionary;
        private var _gameObjectCreatedMap:Dictionary;
        private var _gameObjectRemovedMap:Dictionary;
        private var _eventMap:Dictionary;

        public function LevelFrontendSoundManager(game:Game) {
            _extGame = game;

            initializeMaps();

            _extGame.gameCommunication.onEvent.add(eventHandler);
            _extGame.gameCommunication.onEffectCreated.add(effectCreatedHandler);
            _extGame.gameCommunication.onGameObjectCreated.add(gameObjectCreatedHandler);
            _extGame.gameCommunication.onGameObjectDestroyed.add(gameObjectDestroyedHandler);
            _extGame.gameCommunication.onCratePushed.add(cratePushedHandler);
            _extGame.gameCommunication.onSpikesEjected.add(spikesEjectedHandler);
            _extGame.gameCommunication.onDoorOpened.add(doorOpenedHandler);
            _extGame.gameCommunication.onLevelCompleted.add(levelCompletedHandler);
        }

        public function dispose():void {
            _extGame.gameCommunication.onEvent.remove(eventHandler);
            _extGame.gameCommunication.onEffectCreated.remove(effectCreatedHandler);
            _extGame.gameCommunication.onGameObjectCreated.remove(gameObjectCreatedHandler);
            _extGame.gameCommunication.onGameObjectDestroyed.remove(gameObjectDestroyedHandler);
            _extGame.gameCommunication.onCratePushed.remove(cratePushedHandler);
            _extGame.gameCommunication.onSpikesEjected.remove(spikesEjectedHandler);
            _extGame.gameCommunication.onDoorOpened.remove(doorOpenedHandler);
            _extGame.gameCommunication.onLevelCompleted.remove(levelCompletedHandler);
        }

        private function levelCompletedHandler():void {
            Sfx.playLevelCompleted();
        }

        private function doorOpenedHandler():void {
            Sfx.playDoorOpen();
        }

        private function spikesEjectedHandler(spikes:EnemySpikes):void {
            Sfx.playSpikes(Math.max(0, 1 - spikes.distanceFromPlayer / 150));
        }

        private function cratePushedHandler(crate:ObjectCrate):void {
            if (crate.isStrong){
                Sfx.playPushStrong();
            } else {
                Sfx.playPushWeak();
            }
        }


        private function eventHandler(event:GameEvent, source:*):void {
            if (event in _eventMap){
                _eventMap[event]();
            }
        }

        private function effectCreatedHandler(effect:IEffect):void {
            if (effect.objectClass in _effectCreatedMap){
                _effectCreatedMap[effect.objectClass]();
            }
        }

        private function gameObjectCreatedHandler(gameObject:GameObject):void {
            if (gameObject.objectType in _gameObjectCreatedMap){
                _gameObjectCreatedMap[gameObject.objectType]();
            }
        }

        private function gameObjectDestroyedHandler(gameObject:GameObject):void {
            if (gameObject.objectType in _gameObjectRemovedMap){
                _gameObjectRemovedMap[gameObject.objectType]();
            }
        }

        private function initializeMaps():void {
            _eventMap = new Dictionary();
            _eventMap[GameEvent.FISH_BOSS_WALL_HEADBUTT] = Sfx.playFishWallHit;

            _effectCreatedMap = new Dictionary();
            _effectCreatedMap[EffectExplosion] = Sfx.playTorpedoExplosion;

            _gameObjectCreatedMap = new Dictionary();
            _gameObjectCreatedMap[GameObjectType.TORPEDO] = Sfx.playTorpedoFire;
            _gameObjectCreatedMap[GameObjectType.BULLET_SHELL] = Sfx.playShellAcidFire;

            _gameObjectRemovedMap = new Dictionary();
            _gameObjectRemovedMap[GameObjectType.BULLET_SHELL] = Sfx.playShellAcidExplode;
            _gameObjectRemovedMap[GameObjectType.DNA_STRAND] = Sfx.playCollectSound;
            _gameObjectRemovedMap[GameObjectType.DNA_SECRET_STRAND] = Sfx.playCollectSound;
            _gameObjectRemovedMap[GameObjectType.DOCUMENT] = Sfx.playCollectSound;
        }
    }
}
