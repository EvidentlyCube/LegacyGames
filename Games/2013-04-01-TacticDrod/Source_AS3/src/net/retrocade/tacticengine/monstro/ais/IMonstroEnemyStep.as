/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 19.01.13
 * Time: 20:59
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.ais {
    import net.retrocade.tacticengine.core.Field;
    import net.retrocade.tacticengine.core.IDestruct;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;

    public interface IMonstroEnemyStep extends IDestruct{
        function set field(value:Field):void;
        function init(entity:MonstroEntity, tiles:Vector.<Tile>, friendlyUnits:Vector.<MonstroEntity>, hostileUnits:Vector.<MonstroEntity>):void;
        function update():Boolean;
        function getResult():Vector.<Tile>;
    }
}
