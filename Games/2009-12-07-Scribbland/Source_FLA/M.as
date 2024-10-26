package{
	import com.mauft.DataVault.Safe;
	import com.mauft.DataVault.Vault;
	import com.mauft.PlatformerEngine.objects.SFX;

	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	dynamic public class M extends MovieClip{
		private var loOhoho:LocalConnection
		public static var animating:Boolean=false
		public function M(){
			loOhoho=new LocalConnection
			//stage.scaleMode=StageScaleMode.SHOW_ALL
			//stage.showDefaultContextMenu=false
			//stage.align=StageAlign.TOP_LEFT
			flash.net.registerClassAlias("Safe", Safe)
			Vault.loadVault()

			 ModernDisplay.Init(this, stage, 800, 600);
			 CheatCodes.Init()
			 CheatCodes.AddCheat('arrow', function(): void {
				if (Controls.cheatAltControls) {
					Controls.cheatAltControls = false;
				} else {
					Controls.cheatAltControls = true;
				}
				SFX.playClock();
			 })

            stage.addEventListener(KeyboardEvent.KEY_DOWN, CheatCodes.HandleKey);

		}
	}
}