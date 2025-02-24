
package net.retrocade.tacticengine.monstro.ingame.entities {
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.monstro.ingame.statuses.IMonstroStatus;
    import net.retrocade.tacticengine.monstro.ingame.statuses.MonstroStatusFactory;
	import net.retrocade.tacticengine.monstro.ingame.statuses.MonstroStatusStun;

	public class MonstroEntityWithStatuses extends MonstroEntityWithSpecializations{
        private var _statusEffects:Vector.<IMonstroStatus>;

        public function MonstroEntityWithStatuses(field:MonstroField){
            super(field);

            _statusEffects = new Vector.<IMonstroStatus>();
        }

        final public function statusAdd(status:IMonstroStatus):void{
            _statusEffects.push(status);
            status.attachToUnit(this as MonstroEntity);
        }

        final public function statusRemove(status:IMonstroStatus):void{
            var index:int = _statusEffects.indexOf(status);

            if (index !== -1){
                _statusEffects.splice(index, 1);
            }
        }

        final public function statusActOnTurnStart():void{
            for each(var status:IMonstroStatus in _statusEffects){
                status.onTurnStart();
            }
        }

        final public function statusGenerateDescriptors():Vector.<Object>{
            if (_statusEffects.length > 0){
                var descriptors:Vector.<Object> = new Vector.<Object>();

                for each(var status:IMonstroStatus in _statusEffects){
                    descriptors.push(status.makeDump());
                }

                return descriptors;
            } else {
                return null;
            }
        }

		final public function get statusIsStunned():Boolean{
			for each(var status:IMonstroStatus in _statusEffects){
				if (status is MonstroStatusStun){
					return true;
				}
			}

			return false;
		}

        final public function statusLoadFromDescriptors(descriptors:Vector.<Object>):void{
            for each(var status:IMonstroStatus in _statusEffects){
                status.dispose();
            }

            _statusEffects.length = 0;

            for each(var descriptor:Object in descriptors){
                _statusEffects.push(MonstroStatusFactory.getFromDescriptor(descriptor, this as MonstroEntity));
            }
        }

        override public function makeDump():Object {
            var dump:Object = super.makeDump();
            dump.statuses = [];

            for each(var status:Object in statusGenerateDescriptors()){
                dump.statuses.push(status);
            }

            return dump;
        }

        override public function loadFromDump(dump:Object):void {
            super.loadFromDump(dump);

            var statusDescriptors:Vector.<Object> = new Vector.<Object>();
            for each(var descriptor:Object in dump.statuses){
                statusDescriptors.push(descriptor);
            }

            statusLoadFromDescriptors(statusDescriptors);
        }

        override public function dispose():void{
            if (_statusEffects){
                for each(var status:IMonstroStatus in _statusEffects){
                    status.dispose();
                }

                _statusEffects = null;
            }

            super.dispose();
        }
    }
}
