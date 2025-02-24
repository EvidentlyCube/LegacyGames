
package net.retrocade.tacticengine.monstro.global.states {

	import net.retrocade.retrocamel.components.RetrocamelStateBase;
	import net.retrocade.tacticengine.monstro.global.core.MonstroData;
	import net.retrocade.tacticengine.monstro.global.oldProgressImporter.OldProgressImporter;
	import net.retrocade.tacticengine.monstro.gui.windows.MonstroWindowImportData;

	public class MonstroStateImportProgress extends RetrocamelStateBase {
		public static function setState():void {
			var instance:MonstroStateImportProgress = new MonstroStateImportProgress();

			instance.setToMe();
		}

		override public function create():void {
			super.create();

			CF::flash {
				MonstroStateTitle.show();
			}

			CF::desktop {
				if (!OldProgressImporter.hasProgress() || MonstroData.getSawIntro(false)){
					MonstroStateRetrocade.show();
				} else {
					MonstroWindowImportData.show();
				}
			}
		}
	}
}
