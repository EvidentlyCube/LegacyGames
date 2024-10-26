package submuncher.ingame.renderers.core {
    import net.retrocade.retrocamel.effects.RetrocamelEffectQuakeStarling;

    import starling.textures.Texture;

    import submuncher.core.constants.GameEvent;
    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.GameCommunication;
    import submuncher.ingame.core.Level;
    import submuncher.ingame.gameObjects.GameObject;
    import submuncher.ingame.gameObjects.ObjectDoor;
    import submuncher.ingame.gameObjects.ObjectPlayer;
    import submuncher.ingame.renderers.gameObjects.GameObjectRendererPlayer;
    import submuncher.ingame.vfx.EffectDoorOpen;
    import submuncher.ingame.vfx.EffectExplosion;
    import submuncher.ingame.vfx.EffectPlayerDeath;
    import submuncher.ingame.vfx.EffectPlayerLeaveLevel;
    import submuncher.ingame.vfx.EffectShatter;
    import submuncher.ingame.vfx.EffectShellBulletExplosion;

    public class LevelFrontendInteractionManager {
        private var _extFrontend:LevelFrontend;

        public function LevelFrontendInteractionManager(levelFrontend:LevelFrontend) {
            _extFrontend = levelFrontend;

            gameCommunication.onEvent.add(eventHandler);
            gameCommunication.onPlayerDamagedBy.add(playerDamagedHandler);
            gameCommunication.onGameObjectDestroyed.add(gameObjectDestroyedHandler);
            gameCommunication.onLevelCompleted.add(levelCompletedHandler);
        }

        public function dispose():void {
            gameCommunication.onEvent.remove(eventHandler);
            gameCommunication.onPlayerDamagedBy.remove(playerDamagedHandler);
            gameCommunication.onGameObjectDestroyed.remove(gameObjectDestroyedHandler);
            gameCommunication.onLevelCompleted.remove(levelCompletedHandler);

            _extFrontend = null;
        }

        private function playerDamagedHandler(player:ObjectPlayer, hazard:GameObject):void {
            gameCommunication.onEffectCreated.call(new EffectPlayerDeath(
                    level,
                    _extFrontend,
                    _extFrontend.displayObjects.getRenderer(player).texture,
                    player.preciseX,
                    player.preciseY
            ));
        }

        private function eventHandler(event:GameEvent, source:*):void {
            switch (event) {
                case(GameEvent.FISH_BOSS_WALL_HEADBUTT):
                    RetrocamelEffectQuakeStarling.make().power(20, 20).duration(500).run();
                    break;
            }
        }

        private function gameObjectDestroyedHandler(gameObject:GameObject):void {
            switch (gameObject.objectType) {
                case(GameObjectType.TORPEDO):
                    gameCommunication.onEffectCreated.call(new EffectExplosion(level, gameObject.preciseX + 8, gameObject.preciseY + 8));
                    break;
                case(GameObjectType.BULLET_SHELL):
                    gameCommunication.onEffectCreated.call(new EffectShellBulletExplosion(level, gameObject.direction, gameObject.preciseX + 8, gameObject.preciseY + 8));
                    break;
                case(GameObjectType.FISH):
                    var texture:Texture = _extFrontend.displayObjects.getRenderer(gameObject).texture;
                    EffectShatter.createShatter(gameCommunication, texture, gameObject.preciseX + 8, gameObject.preciseY + 8);
                    break;
                case(GameObjectType.DOOR):
                    gameCommunication.onEffectCreated.call(new EffectDoorOpen(_extFrontend, ObjectDoor(gameObject).color, gameObject.x, gameObject.y));
                    break;
            }
        }

        private function levelCompletedHandler():void {
            gameCommunication.onEffectCreated.call(new EffectPlayerLeaveLevel(
                    level.player,
                    displayObjects.getRenderer(level.player) as GameObjectRendererPlayer,
                    _extFrontend
            ));
        }

        public function get level():Level {
            return _extFrontend.level;
        }

        public function get layers():LevelFrontendLayersCollection {
            return _extFrontend.layers;
        }

        public function get displayObjects():LevelFrontendDisplayObjectsCollection {
            return _extFrontend.displayObjects;
        }

        public function get gameCommunication():GameCommunication {
            return _extFrontend.gameCommunication;
        }
    }
}
