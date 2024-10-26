package submuncher.core.constants {
    import flash.utils.Dictionary;

    public class GameObjectIndexes {
        private static var _displayIndexes:Dictionary;
        private static var _actionIndexes:Dictionary;

        private static var _displayIndexesCounter:uint = 0;
        private static var _actionIndexesCounter:uint = 0;
        
        {
            init();
        }

        private static function init():void {
            _displayIndexes = new Dictionary();
            _actionIndexes = new Dictionary();

            addActionIndex(GameObjectType.FAKE_WALL);
            addActionIndex(GameObjectType.PLAYER);
            addActionIndex(GameObjectType.CRATE_WEAK);
            addActionIndex(GameObjectType.CRATE_STRONG);
            addActionIndex(GameObjectType.BARREL);
            addActionIndex(GameObjectType.SPIKES);
            addActionIndex(GameObjectType.FISH);
            addActionIndex(GameObjectType.TURTLE);
            addActionIndex(GameObjectType.BLOB);
            addActionIndex(GameObjectType.EYE);
            addActionIndex(GameObjectType.SHELL);
            addActionIndex(GameObjectType.SPINNING_BLADES);
            addActionIndex(GameObjectType.GHOST_SUB);
            addActionIndex(GameObjectType.TORPEDO);
            addActionIndex(GameObjectType.BULLET_SHELL);
            addActionIndex(GameObjectType.BULLET_PENETRATING_LASER);
            addActionIndex(GameObjectType.DNA_STRAND);
            addActionIndex(GameObjectType.DNA_SECRET_STRAND);
            addActionIndex(GameObjectType.AMMO);
            addActionIndex(GameObjectType.DOCUMENT);
            addActionIndex(GameObjectType.KEY);
            addActionIndex(GameObjectType.BARRIER);
            addActionIndex(GameObjectType.EEL);
            addActionIndex(GameObjectType.EEL_SEGMENT);
            addActionIndex(GameObjectType.JELLYFISH);
            addActionIndex(GameObjectType.JELLYFISH_SEGMENT);
            addActionIndex(GameObjectType.DETECTOR);
            addActionIndex(GameObjectType.SPONGE);
            addActionIndex(GameObjectType.LEVEL_ENTRANCE);
            addActionIndex(GameObjectType.SCREEN);
            addActionIndex(GameObjectType.FLOOR_TRIGGER);
            addActionIndex(GameObjectType.BOSS_FISH);
            addActionIndex(GameObjectType.DOOR);

            addDisplayIndex(GameObjectType.FLOOR_TRIGGER);
            addDisplayIndex(GameObjectType.SPIKES);
            addDisplayIndex(GameObjectType.DNA_STRAND);
            addDisplayIndex(GameObjectType.DNA_SECRET_STRAND);
            addDisplayIndex(GameObjectType.AMMO);
            addDisplayIndex(GameObjectType.DOCUMENT);
            addDisplayIndex(GameObjectType.KEY);
            addDisplayIndex(GameObjectType.BARREL);
            addDisplayIndex(GameObjectType.EYE);
            addDisplayIndex(GameObjectType.SHELL);
            addDisplayIndex(GameObjectType.CRATE_WEAK);
            addDisplayIndex(GameObjectType.CRATE_STRONG);
            addDisplayIndex(GameObjectType.BULLET_SHELL);
            addDisplayIndex(GameObjectType.BULLET_PENETRATING_LASER);
            addDisplayIndex(GameObjectType.BLOB);
            addDisplayIndex(GameObjectType.FISH);
            addDisplayIndex(GameObjectType.TURTLE);
            addDisplayIndex(GameObjectType.TORPEDO);
            addDisplayIndex(GameObjectType.PLAYER);
            addDisplayIndex(GameObjectType.GHOST_SUB);
            addDisplayIndex(GameObjectType.EEL);
            addDisplayIndex(GameObjectType.EEL_SEGMENT);
            addDisplayIndex(GameObjectType.JELLYFISH);
            addDisplayIndex(GameObjectType.JELLYFISH_SEGMENT);
            addDisplayIndex(GameObjectType.DETECTOR);
            addDisplayIndex(GameObjectType.SPONGE);
            addDisplayIndex(GameObjectType.LEVEL_ENTRANCE);
            addDisplayIndex(GameObjectType.SCREEN);
            addDisplayIndex(GameObjectType.BARRIER);
            addDisplayIndex(GameObjectType.BOSS_FISH);
            addDisplayIndex(GameObjectType.FAKE_WALL);
            addDisplayIndex(GameObjectType.DOOR);
            addDisplayIndex(GameObjectType.SPINNING_BLADES);
            assertAllIndexesAreSet();
        }

        private static function assertAllIndexesAreSet():void {
            for each (var objectType:GameObjectType in GameObjectType.getAll()) {
                if (!(objectType in _displayIndexes)) {
                    throw new Error("Type: " + objectType.name + " does not have a display-index set!");
                }

                if (!(objectType in _actionIndexes)) {
                    throw new Error("Type: " + objectType.name + " does not have an action-index set!");
                }
            }
        }

        private static function addDisplayIndex(objectType:GameObjectType):void{
            if (objectType in _displayIndexes){
                throw new Error("Trying to reset the display-index for " + objectType.name);
            }

            _displayIndexes[objectType] = _displayIndexesCounter++;
        }

        private static function addActionIndex(objectType:GameObjectType):void{
            if (objectType in _actionIndexes){
                throw new Error("Trying to reset action-index for " + objectType.name);
            }
            
            _actionIndexes[objectType] = _actionIndexesCounter++;
        }

        public static function getActionIndex(objectType:GameObjectType):int {
            return _actionIndexes[objectType];
        }

        public static function getDisplayIndex(objectType:GameObjectType):int {
            return _displayIndexes[objectType];
        }
    }
}
