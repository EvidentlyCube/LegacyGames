/**
 * Created with IntelliJ IDEA.
 * User: mzarzycki
 * Date: 28.03.13
 * Time: 17:24
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.ais.enemyai {
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.actions.MonstroUnitStepData;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;

    public interface IMonstroEnemyAI {
        function startForUnit(unit:MonstroEntity):void;

        function update():Boolean;
        function getTargetTile():Tile;
        function get isRunning():Boolean;
        function get unit():MonstroEntity;

        function get movementPath():Vector.<MonstroUnitStepData>;

        function get attackTarget():MonstroEntity;

        function get friendlyUnits():Vector.<MonstroEntity>;
        function set friendlyUnits(value:Vector.<MonstroEntity>):void;
        function get hostileUnits():Vector.<MonstroEntity>;
        function set hostileUnits(value:Vector.<MonstroEntity>):void;
    }
}
