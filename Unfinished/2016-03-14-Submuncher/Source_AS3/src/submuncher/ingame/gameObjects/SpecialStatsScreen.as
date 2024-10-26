package submuncher.ingame.gameObjects {
    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;

    public class SpecialStatsScreen extends GameObject{
        private var _linkedGroupId:String;

        override public function get objectType():GameObjectType {
            return GameObjectType.SCREEN;
        }

        public function SpecialStatsScreen(level:Level, x:Number, y:Number, groupId:String) {
            super(level, x, y);

            _linkedGroupId = groupId;
        }


        override public function dispose():void {
            super.dispose();
        }


        public function get linkedGroupId():String {
            return _linkedGroupId;
        }
    }
}