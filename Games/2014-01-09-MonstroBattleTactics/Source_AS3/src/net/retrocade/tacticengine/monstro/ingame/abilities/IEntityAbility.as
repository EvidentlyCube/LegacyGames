package net.retrocade.tacticengine.monstro.ingame.abilities
{
	import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;

	public interface IEntityAbility
	{
		function attachToUnit(unit:MonstroEntity):void;
		function onTurnStart():void;
		function onTurnEnd():void;
		function onAttack():void;
		function onDefense():void;
		function onMove():void;
		function onWait():void;

		function get name():String;
	}
}
