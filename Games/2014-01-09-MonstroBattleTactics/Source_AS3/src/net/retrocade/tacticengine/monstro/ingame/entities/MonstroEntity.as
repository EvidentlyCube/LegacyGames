package net.retrocade.tacticengine.monstro.ingame.entities {
	import net.retrocade.retrocamel.global.RetrocamelEventsQueue;
	import net.retrocade.tacticengine.core.MonstroField;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroFunctions;
	import net.retrocade.tacticengine.monstro.global.enum.EnumUnitType;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventDefenseRestored;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitDisable;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitEnable;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitKilled;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitStatsChanged;
	import net.retrocade.tacticengine.monstro.ingame.floors.MonstroTileFloor;

	public class MonstroEntity extends MonstroEntityWithAiControl {
		public var unitType:EnumUnitType;
		public var prettyName:String;
		private var _hasMoved:Boolean = false;
		private var _id:int = -1;

		public var damageDealt:uint = 0;
		public var damageReceived:uint = 0;
		public var tilesMoved:uint = 0;
		public var isPushable:Boolean = false;
		public var canBeDamaged:Boolean = true;

		public function MonstroEntity(stats:MonstroEntityStatistics, field:MonstroField) {
			super(stats, field);
		}

		public function setId(id:uint):void {
			CF::debug{
				ASSERT(_id === -1);
			}

			_id = id;
		}

		override public function move(x:int, y:int):Boolean {
			var result:Boolean = super.move(x, y);

			if (result) {
				MonstroTileFloor(tile.floor).activateTraps(this);
			}

			return result;
		}

		override public function makeDump():Object {
			var dump:Object = super.makeDump();
			dump.name = unitType.name;
			dump.prettyName = prettyName;
			dump.hasMoved = _hasMoved;
			dump.damageDealt = damageDealt;
			dump.damageReceived = damageReceived;
			dump.tilesMoved = tilesMoved;
			dump.id = _id;

			return dump;
		}

		override public function loadFromDump(dump:Object):void {
			super.loadFromDump(dump);

			unitType = EnumUnitType.byName(dump.name);
			prettyName = dump.prettyName;
			_hasMoved = dump.hasMoved;
			damageDealt = dump.damageDealt;
			damageReceived = dump.damageReceived;
			tilesMoved = dump.tilesMoved;
			_id = dump.id;

			if (isAlive) {
				tile = field.getTileAt(x, y);
			}
		}

		public function isHuman():Boolean {
			return unitType.isHuman();
		}

		public function attackOtherUnit(attacked:MonstroEntity):void {
			damageDealt = statistics.attack;
			attacked.beforeReceivingDamage(this);

			attacked.receiveDamage(statistics.attack);
		}

		public function beforeReceivingDamage(attacker:MonstroEntity):void {
			if (!isPushable) {
				return;
			}

			if (attacker.x === x || attacker.y === y) {
				var orientation:int = MonstroFunctions.getOrientationTowards(attacker.x, attacker.y, x, y);
				move(x + MonstroFunctions.getDeltaXFromOrientation(orientation), y + MonstroFunctions.getDeltaYFromOrientation(orientation))
			}
		}

		public function receiveDamage(attack:int):void {
			if (!canBeDamaged) {
				return;
			}

			damageReceived += attack;

			RetrocamelEventsQueue.add(MonstroConsts.EVENT_UNIT_DAMAGED, this);

			if (statistics.defense > attack) {
				statistics.defense -= attack;

			} else {
				attack -= statistics.defense;
				statistics.defense = 0;
				statistics.hp = Math.max(0, statistics.hp - attack);
			}

			new MonstroEventUnitStatsChanged(this);

			if (statistics.hp == 0) {
				killUnit();
			}
		}

		public function killUnit():void {
			RetrocamelEventsQueue.add(MonstroConsts.EVENT_UNIT_KILLED, this);
			tile = null;
			new MonstroEventUnitKilled(this);
		}

		public function onTurnStarted():void {
			if (statistics.defense != statistics.defenseMax) {
				statistics.defense = statistics.defenseMax;
				RetrocamelEventsQueue.add(MonstroConsts.EVENT_DEFENSE_RESTORED, this);
				new MonstroEventDefenseRestored(this);
			}

			new MonstroEventUnitStatsChanged(this);

			statusActOnTurnStart();
		}

		public function onTurnEnded():void {
			hasMoved = false;
			statistics.movesLeft = statistics.movesMax;
		}

		public function get hasMoved():Boolean {
			return _hasMoved;
		}

		public function set hasMoved(value:Boolean):void {
			if (value != _hasMoved) {
				statistics.movesLeft = 0;

				_hasMoved = value;

				if (value == true) {
					new MonstroEventUnitDisable(this);
				} else {
					new MonstroEventUnitEnable(this);
				}
			}
		}


		override public function dispose():void {
			unitType = null;

			super.dispose();
		}

		public function get id():int {
			return _id;
		}

		public function get isAlive():Boolean {
		  	return statistics.hp > 0;
		}

		public function get isDead():Boolean {
		  	return statistics.hp === 0;
		}
	}
}