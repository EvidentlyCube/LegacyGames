package net.retrocade.tacticengine.monstro.ais.player{
	import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.ais.player.IMonsroPlayerTurnProcessThread;
    import net.retrocade.tacticengine.monstro.core.Monstro;
import net.retrocade.tacticengine.monstro.entities.MonstroEntity;

public class MonstroPlayerThreadFactory{
		public static function createAction(tile:Tile):IMonsroPlayerTurnProcessThread{
			if (tile && tile.entity){
                var entity:MonstroEntity = tile.entity as MonstroEntity;

                if (entity.isPlayer){
                    if (entity.hasMoved){
                        return new MonstroPlayerThreadInactivatePlayerUnit();
                    } else {
                        return new MonstroPlayerThreadPlayerUnit();
                    }
                } else {
                    return new MonstroPlayerThreadEnemyUnit();
                }
			}
			
			return null;
		}
	}
}