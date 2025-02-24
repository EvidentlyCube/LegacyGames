
package net.retrocade.tacticengine.monstro.ingame.utils {
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.enum.EnumTileset;
    import net.retrocade.tacticengine.monstro.ingame.floors.MonstroTileFloor;

    public class MonstroTileDefinitions {
        public static const IS_INVALID:int = 0x8000;
        public static const IS_GROUND:int = 0x0001;
        public static const IS_GRASS:int = 0x0002;
        public static const IS_PAVEMENT:int = 0x0004;
        public static const IS_OBSTACLE:int = 0x0008;
        public static const IS_WATER:int = 0x0010;
        public static const IS_ANIMATED:int = 0x0100;

        private static var _definitions:Array;

        { initDefinitions(); }

        private static function initDefinitions():void{
            const G:int = IS_GRASS;
            const E:int = IS_GROUND;
            const P:int = IS_PAVEMENT;
            const X:int = IS_OBSTACLE;
            const W:int = IS_WATER;
            const A:int = IS_WATER | IS_ANIMATED;
            const I:int = IS_INVALID;
            const N:int = 0;
            const U:int = IS_OBSTACLE | IS_ANIMATED;

            _definitions = [];
            _definitions[EnumTileset.GREENLAND.id] = [
                G, G, G, G, G, G, G, G, G, G, G, G, G, I, G, I, X, X, X, X, X, X, X, X, X, X, X, X, I, I,
                G, G, G, G, G, G, G, G, G, G, G, G, G, G, G, G, X, X, X, X, X, X, X, X, X, X, X, X, I, I,
                G, G, G, G, G, G, G, G, G, G, G, G, G, I, G, I, X, X, X, X, X, X, X, X, X, X, X, X, I, I,
                G, G, G, G, G, G, G, G, G, G, G, G, G, I, G, G, N, N, N, N, N, N, N, N, N, N, X, X, X, X,
                G, G, G, G, G, G, G, G, G, G, G, G, G, I, G, G, N, N, N, N, N, N, N, N, N, N, X, P, X, X,
                G, G, G, G, G, G, G, G, G, G, G, G, G, I, G, G, N, N, N, N, N, N, N, I, X, X, X, X, X, I,
                E, E, E, E, E, E, E, N, N, N, N, N, N, P, P, P, N, N, N, N, N, N, I, I, I, I, X, X, X, I,
                E, E, E, E, E, E, E, N, I, N, N, N, N, P, P, P, N, N, N, N, I, I, I, I, X, X, X, X, X, I,
                E, E, E, E, E, I, I, I, N, I, N, N, N, P, P, N, N, N, N, N, N, I, I, X, X, X, X, X, X, I,
                P, P, P, P, P, P, P, I, N, N, N, N, N, N, N, N, I, X, X, X, X, X, X, X, I, X, X, I, X, I,
                P, P, P, P, P, P, P, N, N, N, N, N, N, I, I, I, I, X, X, X, X, X, X, X, X, X, X, X, X, I,
                P, P, P, P, P, P, P, N, N, N, N, N, I, I, I, W, W, X, X, X, X, X, X, I, X, X, X, X, I, I,
                A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, U, U, U, A, A, A,
                I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I,
                I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I,
                A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, U, A, A, A, A,
                I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I,
                I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I,
                U, U, U, U, U, A, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I,
                I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I,
                I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I
            ];

            _definitions[EnumTileset.ICE.id] = [
                G, G, G, G, G, G, G, G, G, G, G, G, G, I, G, I, X, X, X, X, X, X, X, X, X, X, X, X, I, I,
                G, G, G, G, G, G, G, G, G, G, G, G, G, G, G, G, X, X, X, X, X, X, X, X, X, X, X, X, I, I,
                G, G, G, G, G, G, G, G, G, G, G, G, G, I, G, I, X, X, X, X, X, X, X, X, I, I, X, X, I, I,
                G, G, G, G, G, G, G, G, G, G, G, G, G, I, G, G, N, N, N, N, N, N, N, N, N, N, X, X, X, X,
                G, G, G, G, G, G, G, G, G, G, G, G, G, I, G, G, N, N, N, N, N, N, N, N, N, N, X, P, X, X,
                G, G, G, G, G, G, G, G, G, G, G, G, G, I, G, G, N, N, N, N, N, N, N, I, X, X, X, X, X, I,
                E, E, E, E, E, E, E, N, N, N, N, N, N, P, P, P, N, N, N, N, N, N, X, X, I, I, X, X, X, I,
                E, E, E, E, E, E, E, N, I, N, I, I, I, P, P, P, N, N, N, N, I, I, X, X, X, X, X, X, X, I,
                E, E, E, E, E, X, X, I, N, I, I, I, I, P, P, I, N, N, N, N, N, I, I, X, X, X, X, X, X, I,
                P, P, P, P, P, P, P, I, N, N, N, N, N, N, N, I, I, X, X, X, X, X, X, X, I, X, X, I, X, I,
                P, P, P, P, P, P, P, N, N, N, N, N, X, X, X, I, I, X, X, X, X, X, X, X, X, X, X, X, X, I,
                P, P, P, P, P, P, P, N, N, N, N, N, X, X, X, W, W, X, X, X, X, X, X, I, X, X, X, X, I, I,
                A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, U, U, U, A, A, A,
                I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I,
                I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I,
                A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, U, A, A, A, A,
                I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I,
                I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I,
                U, U, U, U, U, A, I, I, U, A, U, I, I, I, U, U, U, U, U, U, I, I, I, U, U, I, I, I, I, A,
                I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I,
                I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I
            ];

            _definitions[EnumTileset.LAVA.id] = [
                G, G, G, G, G, G, G, G, G, G, G, G, G, I, G, X, X, X, X, X, X, X, X, X, X, X, X, X, I, I,
                G, G, G, G, G, G, G, G, G, G, G, G, G, G, G, G, X, X, X, X, X, X, X, X, X, X, X, X, I, I,
                G, G, G, G, G, G, G, G, G, G, G, G, G, I, G, X, X, X, X, X, X, X, X, X, X, X, X, X, I, I,
                G, G, G, G, G, G, G, G, G, G, G, G, G, I, G, G, N, N, N, N, N, N, N, N, N, N, X, X, X, X,
                G, G, G, G, G, G, G, G, G, G, G, G, G, I, G, G, N, N, N, N, N, N, N, N, N, N, X, P, X, X,
                G, G, G, G, G, G, G, G, G, G, G, G, G, I, G, G, N, N, N, N, N, N, N, I, X, X, X, X, X, I,
                E, E, E, E, E, E, E, N, N, N, N, N, N, P, P, P, N, N, N, N, N, N, I, I, I, I, X, X, X, I,
                E, E, E, E, E, E, E, N, N, N, N, N, N, P, P, P, N, N, N, N, I, I, I, I, X, X, X, X, X, I,
                E, E, E, E, E, I, I, I, N, I, N, N, N, P, P, I, N, N, N, N, N, I, I, X, X, X, X, X, X, I,
                P, P, P, P, P, P, P, I, N, N, N, N, N, N, N, N, I, I, I, I, I, X, X, X, I, X, X, I, X, I,
                P, P, P, P, P, P, P, N, N, N, N, N, N, N, N, N, I, I, I, I, I, X, X, X, X, X, X, X, X, I,
                P, P, P, P, P, P, P, N, N, N, N, I, N, I, I, I, I, I, I, I, I, X, X, I, I, I, I, I, I, I,
                A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, U, U, U, A, A, A,
                I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I,
                I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I,
                A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, U, A, A, A, A,
                I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I,
                I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I,
                U, U, U, U, U, A, U, U, U, A, U, U, U, U, U, U, U, U, U, U, U, U, U, I, I, I, I, I, I, I,
                I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I,
                I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I, I
            ];
        }

        public static function updateFloorMeta(floor:MonstroTileFloor, tx:int, ty:int, tileset:EnumTileset):void{
            tx /= MonstroConsts.tileWidth;
            ty /= MonstroConsts.tileHeight;

            var tileDefinition:int = _definitions[tileset.id][tx + ty * 30];
            if ((tileDefinition & IS_INVALID) !== 0){
                //throw new Error(printf("Invalid tile at %%x%% in tileset %%", floor.x, floor.y, tileset.name));
                return;
            }

            floor.isGrass = Boolean(tileDefinition & IS_GRASS) || floor.isGrass;
            floor.isSidewalk = Boolean(tileDefinition & IS_PAVEMENT) || floor.isSidewalk;
            floor.isGround = Boolean(tileDefinition & IS_GROUND) || floor.isGround;
            floor.isObstacle = Boolean(tileDefinition & IS_OBSTACLE) || floor.isObstacle;
            floor.isWater = Boolean(tileDefinition & IS_WATER) || floor.isWater;
        }
    }
}
