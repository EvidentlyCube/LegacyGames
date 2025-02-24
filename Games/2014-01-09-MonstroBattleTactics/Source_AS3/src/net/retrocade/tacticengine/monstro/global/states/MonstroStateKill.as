


package net.retrocade.tacticengine.monstro.global.states {
    import net.retrocade.retrocamel.components.RetrocamelStateBase;

    public class MonstroStateKill extends RetrocamelStateBase{
        public static function setState():void {
            var instance:MonstroStateKill = new MonstroStateKill();
            instance.setToMe();
        }
    }
}
