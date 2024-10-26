package Classes.Items{
	import Classes.Interactivers.TObject;
	import Classes.SFX
	import Classes.Interactivers.TPlayer
	public class TBouncerD extends TItem{
		[Embed("../../../assets/gfx/gameplay/BouncerD1.png")]	public static var g_0:Class
		[Embed("../../../assets/gfx/gameplay/BouncerD2.png")]	public static var g_1:Class
		public var mode:uint = 0
		public function TBouncerD(_x:uint,_y:uint,_mode:uint){
			x=_x
			y=_y

			mode=_mode
			addChild(mode == 0?new g_0:new g_1)

			Game.layerItems.addChild(this)
		}
		override public function Stomp(who:TObject):void{
			if (!who.stomps){return}
			var temp:int = who.moveX
			if (mode == 1){
				who.moveX = who.moveY
				who.moveY = temp
			} else {
				who.moveX=-who.moveY
				who.moveY=-temp
			}
			if (who.moveSteps > 1){
				if (who is TPlayer){
					SFX.Play("bounce")
				} else {
					who.moveSteps = 0
					SFX.Play("bounce2")
				}
			}
			who.stops = false
		}
		override public function Remove():void{
			Game.layerItems.removeChild(this)
		}
	}
}