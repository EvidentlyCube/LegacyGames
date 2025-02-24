package net.retrocade.tacticengine.monstro.ingame.ais.classic
{
	import net.retrocade.constants.KeyConst;
	import net.retrocade.retrocamel.core.RetrocamelInputManager;
	import net.retrocade.tacticengine.core.Eventer;
	import net.retrocade.tacticengine.core.MonstroField;
	import net.retrocade.tacticengine.core.injector.MonstroInjector;
	import net.retrocade.tacticengine.core.injector.injectCreate;
	import net.retrocade.tacticengine.monstro.global.core.MonstroData;
	import net.retrocade.tacticengine.monstro.global.enum.EnumUnitController;
	import net.retrocade.tacticengine.monstro.global.states.MonstroStateIngame;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroFieldRenderer;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.player.MonstroPlayerClickControls;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.player.MonstroPlayerDragAndDropControls;
	import net.retrocade.tacticengine.monstro.ingame.ais.common.IMonstroTurnProcess;
	import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventEndTurn;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventSaveStateLoaded;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUndidUnit;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUndo;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitKilled;
	import net.retrocade.tacticengine.monstro.ingame.traps.IMonstroTrap;
	import net.retrocade.tacticengine.monstro.ingame.undo.UndoBitTrap;
	import net.retrocade.tacticengine.monstro.ingame.undo.UndoManager;
	import net.retrocade.tacticengine.monstro.ingame.undo.UndoBitUnit;

	public class MonstroPlayerTurnProcess implements IMonstroTurnProcess
	{
		[Inject]
		public var field:MonstroField;
		[Inject]
		public var fieldRenderer:MonstroFieldRenderer;
		[Inject]
		public var stateIngame:MonstroStateIngame;
		private var _enabled:Boolean = true;
		private var _clickControls:MonstroPlayerClickControls;
		private var _dragControls:MonstroPlayerDragAndDropControls;
		private var _units:Vector.<MonstroEntity>;
		private var _ignoreTurnStart:Boolean = false;
		private var _isTurnEnded:Boolean = false;

		public function onUndo():void
		{
		}

		public function init():void
		{
			Eventer.listen(MonstroEventUnitKilled.NAME, resetUnitsList, this);
			Eventer.listen(MonstroEventSaveStateLoaded.NAME, onSaveLoaded, this);
			Eventer.listen(MonstroEventUndidUnit.NAME, resetUnitsList, this);
			resetUnitsList();

			_clickControls = injectCreate(MonstroPlayerClickControls);
			_dragControls = injectCreate(MonstroPlayerDragAndDropControls);

			MonstroInjector.mapValue(MonstroPlayerClickControls, _clickControls);
		}

		public function dispose():void
		{
			Eventer.releaseContext(this);

			MonstroInjector.unmap(MonstroPlayerClickControls);
			MonstroInjector.unmap(MonstroPlayerDragAndDropControls);

			_clickControls.dispose();
			_dragControls.dispose();

			field = null;
			fieldRenderer = null;
			stateIngame = null;
			_units = null;
		}

		public function start():void
		{
			_isTurnEnded = false;

			if (_ignoreTurnStart) {
				_ignoreTurnStart = false;
			} else {
				for each(var unit:MonstroEntity in _units) {
					unit.onTurnStarted();
				}
			}

			Eventer.listen(MonstroEventEndTurn.NAME, onEndTurn, this);
		}

		public function stop():void
		{
			for each(var unit:MonstroEntity in _units) {
				unit.onTurnEnded();
			}

			Eventer.releaseContext(this);

			enabled = false;
		}

		public function update():Boolean
		{
			if (RetrocamelInputManager.isKeyHit(KeyConst.SPACE)){
				new MonstroEventEndTurn();
			} else if (RetrocamelInputManager.isKeyHit(KeyConst.Q) && !stateIngame.hasBlockingActions){
				new MonstroEventUndo();
			} else if (MonstroData.getIsDragControls()){
				_dragControls.update();
			} else {
				_clickControls.update();
			}

			return _isTurnEnded;
		}

		public function onSaveLoaded():void
		{
			_ignoreTurnStart = true;
		}

		private function onEndTurn():void
		{
			_isTurnEnded = true;

			UndoManager.instance.startNewStep(field);
			for each(var entity:MonstroEntity in field.getLivingEntities()) {
				UndoManager.instance.addBit(new UndoBitUnit(entity));
			}
			for each(var trap:IMonstroTrap in field.getAllTraps()){
				UndoManager.instance.addBit(new UndoBitTrap(trap));
			}
			UndoManager.instance.commitStep();


			for each(var unit:MonstroEntity in _units) {
				if (!unit.hasMoved) {
					unit.hasMoved = true;
				}
			}
		}

		private function resetUnitsList():void
		{
			_units = new Vector.<MonstroEntity>();

			var entities:Vector.<MonstroEntity> = field.getLivingEntities();
			for each(var entity:MonstroEntity in entities) {
				if (entity.controlledBy.isPlayer()) {
					_units.push(entity as MonstroEntity);
				}
			}
		}

		public function get enabled():Boolean
		{
			return _enabled;
		}

		public function set enabled(value:Boolean):void
		{
			_enabled = value;
		}

		public function get controllableUnits():Vector.<MonstroEntity>
		{
			return _units;
		}

		public function get controlledBy():EnumUnitController {
			return EnumUnitController.PLAYER;
		}
	}
}