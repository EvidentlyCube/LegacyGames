
package net.retrocade.tacticengine.monstro.ingame.tutorial.cards {
    import net.retrocade.retrocamel.global.RetrocamelEventsQueue;
    import net.retrocade.retrocamel.locale._;
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.injector.injectCreate;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroData;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.traps.IMonstroTrap;

    public function MonstroTutorialCardGenerator(field:MonstroField):Vector.<MonstroTutorialCardBase>{
        var vector:Vector.<MonstroTutorialCardBase> = new Vector.<MonstroTutorialCardBase>();
        var definition:MonstroTutorialCardGeneric;

        var id:uint = 0;

        definition = injectCreate(MonstroTutorialCardGeneric);
        definition.initCard(id++, false);
        definition.valGetText = _("hint_1");
        definition.funcCheckIfAppear = function():Boolean{return true;};
        definition.funcCheckIfHide = function():Boolean{ return RetrocamelEventsQueue.occured(MonstroConsts.EVENT_TURN_ENDED); };
        vector.push(definition);

        definition = injectCreate(MonstroTutorialCardGeneric);
        definition.initCard(id++, false);
        definition.valGetText = _("hint_2");
        definition.image = MonstroGfx.getTutorialIcon1();
        definition.funcCheckIfAppear = function():Boolean{return true;};
        definition.funcCheckIfHide = function():Boolean{ return RetrocamelEventsQueue.occured(MonstroConsts.EVENT_TURN_ENDED); };
        vector.push(definition);

        definition = injectCreate(MonstroTutorialCardGeneric);
        definition.initCard(id++, false);
        definition.valGetText = _("hint_3");
        definition.funcCheckIfAppear = function():Boolean{
            for each(var entity:MonstroEntity in field.getAllEntities()){
                if (entity.getStatistics().defenseMax > 0){
                    return true;
                }
            }
            return false;
        };
        definition.funcCheckIfHide = function():Boolean{
            return RetrocamelEventsQueue.occured(MonstroConsts.EVENT_DEFENSE_RESTORED);
        };
        vector.push(definition);

        definition = injectCreate(MonstroTutorialCardGeneric);
        definition.initCard(id++, false);
        definition.valGetText = _("hint_4");
        definition.funcCheckIfAppear = function():Boolean{ return MonstroData.countCompletedLevels() > 5; };
        definition.funcCheckIfHide = function():Boolean{
            return RetrocamelEventsQueue.occured(MonstroConsts.EVENT_PAUSE_MENU_OPENED);
        };
        vector.push(definition);

        definition = injectCreate(MonstroTutorialCardGeneric);
        definition.initCard(id++, false);
        definition.valGetText = _("hint_5");
        definition.funcCheckIfAppear = function():Boolean{ return MonstroData.countCompletedLevels() > 1; };
        definition.funcCheckIfHide = function():Boolean{
            return RetrocamelEventsQueue.occured(MonstroConsts.EVENT_PAUSE_MENU_OPENED);
        };
        vector.push(definition);

        definition = injectCreate(MonstroTutorialCardGeneric);
        definition.initCard(id++, false);
        definition.valGetText = _("hint_7");
        definition.funcCheckIfAppear = function():Boolean{
            for each(var trap:IMonstroTrap in field.getAllTraps()){
                if (trap.isEnabled){
                    return true;
                }
            }
            return false;
        };
        definition.funcCheckIfHide = function():Boolean{ return RetrocamelEventsQueue.occured(MonstroConsts.EVENT_HOVERED_OVER_TRAP); };
        vector.push(definition);

        definition = injectCreate(MonstroTutorialCardGeneric);
        definition.initCard(id++, false);
        definition.valGetText = _("hint_8");
        definition.funcCheckIfAppear = function():Boolean{
            for each(var trap:IMonstroTrap in field.getAllTraps()){
                if (trap.isEnabled){
                    return true;
                }
            }
            return false;
        };
        definition.funcCheckIfHide = function():Boolean{ return RetrocamelEventsQueue.occured(MonstroConsts.EVENT_TRAP_ACTIVATED); };
        vector.push(definition);


        return vector;
    }
}
