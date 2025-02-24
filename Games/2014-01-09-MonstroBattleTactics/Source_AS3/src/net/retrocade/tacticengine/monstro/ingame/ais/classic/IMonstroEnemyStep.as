
package net.retrocade.tacticengine.monstro.ingame.ais.classic {
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.IDisposable;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;

    public interface IMonstroEnemyStep extends IDisposable{
        function set field(value:MonstroField):void;
        function init(entity:MonstroEntity, tiles:Vector.<Tile>, friendlyUnits:Vector.<MonstroEntity>, hostileUnits:Vector.<MonstroEntity>):void;
        function update():Boolean;
        function getResult():Vector.<Tile>;

        function toString():String;
    }
}
