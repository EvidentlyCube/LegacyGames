package submuncher.ingame.gameObjects {
    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;

    public class BonusDnaSecret extends BonusDna{
        override public function get objectType():GameObjectType {
            return GameObjectType.DNA_SECRET_STRAND;
        }

        public function BonusDnaSecret(level:Level, x:Number, y:Number) {
            super(level, x, y);
        }

        override protected function collect():void{
            super.collect();
        }
    }
}