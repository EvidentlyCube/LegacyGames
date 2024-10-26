/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 11.03.13
 * Time: 23:33
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.entities {
    import net.retrocade.tacticengine.core.Field;

    public class MonstroEntityFactory {
        public static const NAME_CITIZEN:String = "citizen";
        public static const NAME_STALWART:String = "stalwart";
        public static const NAME_BEETHRO:String = "beethro";
        public static const NAME_ROACH:String = "roach";
        public static const NAME_SPIDER:String = "spider";
        public static const NAME_TARBABY:String = "tarbaby";
        public static const NAME_GOBLIN:String = "goblin";
        public static const NAME_SLAYER:String = "slayer";

        public static function getUnit(name:String, field:Field, isPlayerHuman:Boolean):MonstroEntity{
            var unit:MonstroEntity = new MonstroEntity(field);
            unit.name = name;
            unit.prettyName = name.substr(0, 1).toUpperCase() + name.substr(1);

            switch(name){
                case(NAME_CITIZEN):
                    unit.hp = 1;
                    unit.attack = 2;
                    unit.isPlayer = isPlayerHuman;
                    unit.movesMax = 2;
                    unit.movementOrder = 3;
                    break;

                case(NAME_STALWART):
                    unit.hp = 2;
                    unit.attack = 3;
                    unit.isPlayer = isPlayerHuman;
                    unit.movesMax = 2;
                    unit.movementOrder = 2;
                    break;

                case(NAME_BEETHRO):
                    unit.hp = 5;
                    unit.attack = 10;
                    unit.isPlayer = isPlayerHuman;
                    unit.movesMax = 5;
                    unit.movementOrder = 1;
                    break;

                case(NAME_ROACH):
                    unit.hp = 1;
                    unit.attack = 1;
                    unit.isPlayer = !isPlayerHuman;
                    unit.movesMax = 1;
                    unit.movementOrder = 5;
                    break;

                case(NAME_SPIDER):
                    unit.hp = 2;
                    unit.attack = 1;
                    unit.isPlayer = !isPlayerHuman;
                    unit.movesMax = 2;
                    unit.movementOrder = 4;
                    break;

                case(NAME_TARBABY):
                    unit.hp = 4;
                    unit.prettyName = "Tar Baby";
                    unit.attack = 1;
                    unit.isPlayer = !isPlayerHuman;
                    unit.movesMax = 1;
                    unit.movementOrder = 3;
                    break;

                case(NAME_GOBLIN):
                    unit.hp = 3;
                    unit.attack = 3;
                    unit.isPlayer = !isPlayerHuman;
                    unit.movesMax = 3;
                    unit.movementOrder = 2;
                    break;

                case(NAME_SLAYER):
                    unit.hp = 40;
                    unit.attack = 10;
                    unit.isPlayer = !isPlayerHuman;
                    unit.movesMax = 5;
                    unit.movementOrder = 1;
                    break;

                default:
                    unit = null;
                    break;
            }

            unit.movesLeft = unit.movesMax;

            return unit;
        }
    }
}
