
package net.retrocade.tacticengine.monstro.global.states {

	import net.retrocade.retrocamel.components.RetrocamelStateBase;
	import net.retrocade.retrocamel.core.RetrocamelWindowsManager;
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroData;
	import net.retrocade.tacticengine.monstro.gui.windows.MonstroWindowHelpMessage;
	import net.retrocade.tacticengine.monstro.gui.windows.MonstroWindowMessage;

	public class MonstroStateUpdateInfo extends RetrocamelStateBase {
		public static function setState():void {
			var instance:MonstroStateUpdateInfo = new MonstroStateUpdateInfo();

			instance.setToMe();
		}

		override public function create():void {
			super.create();

			if (MonstroData.getLastUpdateSeen() !== MonstroConsts.versionString){
				MonstroWindowHelpMessage.showWindow("Monstro update", _('update_txt'), 800);
			}
		}


		override public function update():void {
			if (RetrocamelWindowsManager.numWindows === 0){
				MonstroStateImportProgress.setState();
				MonstroData.setLastUpdateSeen(MonstroConsts.versionString);
			}
		}
	}
}
