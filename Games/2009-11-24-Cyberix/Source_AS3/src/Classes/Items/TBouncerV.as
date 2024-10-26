package Classes.Items{
	import Classes.Interactivers.TObject;
	import Classes.SFX
	import Classes.Interactivers.TPlayer
	public class TBouncerV extends TItem{
		[Embed("../../../assets/gfx/gameplay/BouncerV1.png")]	public static var g_0:Class
		[Embed("../../../assets/gfx/gameplay/BouncerV2.png")]	public static var g_1:Class
		public var mode:int = 0
		public function TBouncerV(_x:uint,_y:uint,_mode:uint){
			x=_x
			y=_y

			mode=_mode * 2-1
			addChild(mode==-1?new g_0:new g_1)

			Game.layerItems.addChild(this)
		}
		override public function Stomp(who:TObject):void{
			if (who.moveY == mode){
				who.moveY*=-1
				who.stops = false
				if (who.moveSteps > 1){
					if (who is TPlayer){
						SFX.Play("bounce")
					} else {
						who.moveSteps = 0
						SFX.Play("bounce2")
					}
				}
			}
		}
		override public function Hit(who:TObject):void{
			if (who.moveY==-mode){
				who.moveY*=-1
				who.waitTurn = true
				who.stops = false
				who.stomps = false
				if (who.moveSteps > 1){
					if (who is TPlayer){
						SFX.Play("bounce")
					} else {
						who.moveSteps = 0
						SFX.Play("bounce2")
					}
				}
			}
		}
		override public function Remove():void{
			Game.layerItems.removeChild(this)
		}
	}
}