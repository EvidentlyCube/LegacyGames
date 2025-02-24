
package net.retrocade.tacticengine.monstro.global.states {

    import net.retrocade.retrocamel.components.RetrocamelStateBase;
    import net.retrocade.retrocamel.core.RetrocamelWindowsManager;
    import net.retrocade.retrocamel.locale._;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroData;
    import net.retrocade.tacticengine.monstro.gui.windows.MonstroWindowHelpMessage;
    import net.retrocade.utils.UtilsString;

    public class MonstroStateDrmFreeUpdateCheck extends RetrocamelStateBase {
        public static function setState():void {
            var instance:MonstroStateDrmFreeUpdateCheck = new MonstroStateDrmFreeUpdateCheck();

            instance.setToMe();
        }

        override public function create():void {
            super.create();

            if (RetrocadeInterface.version !== null && UtilsString.compareVersions(RetrocadeInterface.version, MonstroConsts.version) < 0) {
                var body:String = _(
                    "outdated.version",
                    MonstroConsts.version,
                    RetrocadeInterface.version,
                    RetrocadeInterface.changelog
                );
                MonstroWindowHelpMessage.showWindow("Monstro update available!", body, 1000);
            } else {
                MonstroStateImportProgress.setState();
            }
        }


        override public function update():void {
            if (RetrocamelWindowsManager.numWindows === 0) {
                MonstroStateImportProgress.setState();
                MonstroData.setLastUpdateSeen(MonstroConsts.versionString);
            }
        }
    }
}
