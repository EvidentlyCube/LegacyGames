package submuncher.ingame.gameObjects {
    import net.retrocade.collision.CollisionShapeRectangle;

    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;

    public class EnemySpikes extends GameObject {
        private var _durationSafe:uint;
        private var _spikeTime:uint;
        private var _totalDuration:uint;

        override public function get objectType():GameObjectType {
            return GameObjectType.SPIKES;
        }

        public function EnemySpikes(level:Level, x:Number, y:Number, totalDuration:uint, dangerousTime:uint, startingOffset:uint) {
            super(level, x, y);

            A::SSERT{
                ASSERT(totalDuration >= dangerousTime);
            }
            A::SSERT{
                ASSERT(startingOffset < totalDuration);
            }

            _durationSafe = totalDuration - dangerousTime;
            _spikeTime = startingOffset;
            _totalDuration = totalDuration;

            collisionShape = new CollisionShapeRectangle(x, y, 4, 4, 8, 8);
        }

        override public function update():void {
            _spikeTime = (_spikeTime + 1) % _totalDuration;

            if (_spikeTime === _durationSafe) {
                gameCommunication.onSpikesEjected.call(this);
            }

            if (areSpikesUp && player && doesCollideWith(player)) {
                level.player.damagedByHazard(this);
            }

            super.update();
        }

        public function get areSpikesUp():Boolean {
            return _spikeTime >= _durationSafe;
        }
    }
}