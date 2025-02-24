
package net.retrocade.tacticengine.monstro.ingame.entities {
    import net.retrocade.tacticengine.core.Entity;
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.monstro.ingame.specializations.IMonstroSpecialization;
    import net.retrocade.tacticengine.monstro.ingame.specializations.MonstroSpecializationFactory;

    public class MonstroEntityWithSpecializations extends Entity{
        private var _specializations:Vector.<IMonstroSpecialization>;

        public function MonstroEntityWithSpecializations(field:MonstroField){
            super(field);

            _specializations = new Vector.<IMonstroSpecialization>();
        }


        public function addSpecialization(specialization:IMonstroSpecialization):void{
            specialization.addToUnit(this as MonstroEntity);
            _specializations.push(specialization);
        }

        public function getSpecialization(index:int):IMonstroSpecialization{
            return _specializations[index];
        }

        public function getSpecializationsCount():int{
            return _specializations.length;
        }

       override public function makeDump():Object{
            var dump:Object = super.makeDump();

            dump.specializations = [];
            for each(var specialization:IMonstroSpecialization in _specializations){
                dump.specializations.push(specialization.makeDump());
            }

            return dump;
        }

        override public function loadFromDump(dump:Object):void{
            super.loadFromDump(dump);

            for each(var specializationDump:Object in dump.specializations){
                _specializations.push(MonstroSpecializationFactory.loadFromDump(specializationDump));
            }
        }

        override public function dispose():void{
            if (_specializations){
                for each(var specialization:IMonstroSpecialization in _specializations){
                    specialization.dispose();
                }

                _specializations = null;
            }

            super.dispose();
        }
    }
}
