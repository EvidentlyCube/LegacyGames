package submuncher.ingame.gameObjects {
    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;

    public class BonusDna extends GameObject{
        override public function get objectType():GameObjectType {
            return GameObjectType.DNA_STRAND;
        }

        public function BonusDna(level:Level, x:Number, y:Number) {
            super(level, x, y);
        }

        override public function update():void {
            if (!level.isLevelCompleted && level.player && !level.player.isMoving && level.player.x === x && level.player.y === y){
                collect();
            } else {
                super.update();
            }
        }

        protected function collect():void{
            gameCommunication.onBonusCollected.call(this);
            destroy();
        }
    }
}