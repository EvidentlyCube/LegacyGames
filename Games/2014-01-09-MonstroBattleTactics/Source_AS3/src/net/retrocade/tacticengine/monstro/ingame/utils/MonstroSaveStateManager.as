
package net.retrocade.tacticengine.monstro.ingame.utils {
    import flash.utils.ByteArray;

    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.monstro.ingame.condition.IMonstroCondition;
    import net.retrocade.tacticengine.monstro.ingame.condition.MonstroConditionFactory;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntityFactory;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventChangeConditions;
    import net.retrocade.tacticengine.monstro.ingame.traps.IMonstroTrap;
    import net.retrocade.tacticengine.monstro.ingame.traps.MonstroTrapFactory;
	import net.retrocade.tacticengine.monstro.ingame.undo.UndoManager;
	import net.retrocade.utils.UtilsBase64;

    public class MonstroSaveStateManager {
        public static function makeDump(field:MonstroField, victoryCondition:IMonstroCondition, loseCondition:IMonstroCondition):String{
            var dump:Object = {};
            dump.units = [];
            dump.traps = [];
            dump.victoryCondition = victoryCondition.makeDump();
            dump.loseCondition = loseCondition.makeDump();
			dump.undoManager = UndoManager.instance.makeDump();
			dump.currentTurn = field.currentTurn;

            for each(var unit:MonstroEntity in field.getAllEntities()){
                dump.units.push(unit.makeDump());
            }

            for each(var trap:IMonstroTrap in field.getAllTraps()){
                dump.traps.push(trap.makeDump());
            }

            var byteArray:ByteArray = new ByteArray();
            byteArray.writeObject(dump);
            byteArray.position = 0;
            //byteArray.compress();
            //USecure.
            return UtilsBase64.encodeByteArray(byteArray);
        }

        public static function loadFromDump(dumpString:String, field:MonstroField):void{
			field.isLoadedFromContinue = true;

            var byteArray:ByteArray = UtilsBase64.decodeByteArray(dumpString);
            var dump:Object = byteArray.readObject();

			UndoManager.instance.loadFromDump(dump.undoManager);

			var entities:Vector.<MonstroEntity> = new Vector.<MonstroEntity>();
            for each(var unitDescriptor:Object in dump.units){
				entities.push(MonstroEntityFactory.loadDump(unitDescriptor, field));
            }
			field.setEntityList(entities);
			field.currentTurn = dump.currentTurn;

            for each(var trapDescriptor:Object in dump.traps){
                var trap:IMonstroTrap = MonstroTrapFactory.getFromDump(trapDescriptor);

                field.getTileAt(trap.x, trap.y).floor.trap = trap;
            }

            new MonstroEventChangeConditions(
                MonstroConditionFactory.getFromDump(dump.victoryCondition, field),
                MonstroConditionFactory.getFromDump(dump.loseCondition, field)
            );
        }
    }
}
