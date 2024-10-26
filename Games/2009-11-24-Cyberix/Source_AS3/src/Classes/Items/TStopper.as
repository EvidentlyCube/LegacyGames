package Classes.Items{
	import Classes.ControlsHandler;
	import Classes.Interactivers.TObject;
	import Classes.Interactivers.TPlayer;
	import Classes.SFX;

	public class TStopper extends TItem{
		[Embed("../../../assets/gfx/gameplay/Stopper.png")] public static var g_0:Class
		public function TStopper(_x:uint,_y:uint){
			x=_x
			y=_y

			addChild(new g_0)

			Game.layerItems.addChild(this)
		}
		override public function Stomp(who:TObject):void{
			if (who.stomps && who.F_isStoppable){
				who.Stop()
				SFX.Play("stopper")
				if (who as TPlayer){ControlsHandler.xTile()}
			}
		}
		override public function Remove():void{
			Game.layerItems.removeChild(this)
		}
	}
}