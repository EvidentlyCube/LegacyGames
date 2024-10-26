package Classes.Interactivers{
	import Classes.ControlsHandler;
	import Classes.Items.TBouncerD;
	import Classes.Items.TButtonItem;
	import Classes.Items.TButtonShot;
	import Classes.Items.TDropper;
	import Classes.TLevel;

	import mx.core.BitmapAsset;
	/*STATIC*/ public class TEnMimic extends TObject{
		[Embed("../../../assets/gfx/gameplay/mimic00.png")] public static var g_0:Class;
		[Embed("../../../assets/gfx/gameplay/mimic01.png")] public static var g_1:Class;
		[Embed("../../../assets/gfx/gameplay/mimic02.png")] public static var g_2:Class;
		[Embed("../../../assets/gfx/gameplay/mimic03.png")] public static var g_3:Class;
		private var waitTurnCount:uint = 0
		private var first:Boolean = true
		public var dir:uint = 0
		public function TEnMimic(_x:uint,_y:uint){
			x=_x
			y=_y

			F_isStoppable = true
			F_isTeleportable = true
			F_hitsButtons = true
			F_stopsObjects = true
			F_canPush = true
			F_bulletKills = true
			F_mineKills = true
			F_canFall = true

			fillGraphics(g_0)
			Game.layerObjects.addChildAt(this,0)
		}
		override public function Update():void{
			if (moveX + moveY == 0){
				if (ControlsHandler.RIGHT){
					move(1,0)
				} else if(ControlsHandler.DOWN){
					move(0,1)
				} else if(ControlsHandler.LEFT){
					move(-1,0)
				} else if(ControlsHandler.UP){
					move(0,-1)
				} else {
					return
				}
			}
			if (x%24 == 0 && y%24 == 0){
				moveSteps++
				TLevel.checkStomp(this,x,y)
				if (stops){Stop();return;} else {TLevel.checkHit(this,x + moveX * 24,y + moveY * 24)}
			} else {TLevel.checkHit(this,x + 12 + moveX * 12,y + 12 + moveY * 12)}
			if (!stops){checkHits()}

			if (!waitTurn){
				x += moveX * 6
				y += moveY * 6
				waitTurnCount = 0
			} else {
				waitTurnCount++
				if (waitTurnCount == 3){
					Stop()
					waitTurnCount = 0
				}
			}
			if (x<=-24){x += TLevel.wid * 24}
			if (x > TLevel.wid * 24 - 24){x -= TLevel.wid * 24}
			if (y<=-24){y += TLevel.hei * 24}
			if (y > TLevel.hei * 24 - 24){y -= TLevel.hei * 24}
			if (moveX + moveY != 0 && !waitTurn){stomps = true}
			if (moveX > 0){fillGraphics(g_0);dir = 0} else
			if (moveY > 0){fillGraphics(g_1);dir = 1} else
			if (moveX < 0){fillGraphics(g_2);dir = 2} else
			if (moveY < 0){fillGraphics(g_3);dir = 3}
			waitTurn = false
		}
		override public function Hit(who:TObject):void{
			if (who.F_stopsObjects){
				if (who.moveX==-moveX && who.moveY==-moveY){
					Stop(who)
				}
			}
			if (who as TPlayer){
				who.Destroy(this)
			}
			who.Stop(this)
		}
		override public function Stop(who:TObject = null):void{
			super.Stop(who)
			if (!stops){moveSteps = 0}
			if (who as TPlayer){
				who.Destroy(this)
			}
		}
		private function move(_x:int,_y:int):void{
			stomps = false
			stops = false
			moveX=_x
			moveY=_y
			if (first){
				first = false
				if (TLevel.checkAt(x,y) as TButtonItem || TLevel.checkAt(x,y) as TButtonShot){
					stomps = true
				}
			} else if (TLevel.checkAt(x,y) as TBouncerD){
				stomps = true
			}
		}
		override public function Remove():void{
			Game.layerObjects.removeChild(this)
		}
		override public function Destroy(who:*):void{
			Remove()
			stops = true
			new TFadeWhite(x,y,this,0.05,moveX * 6,moveY * 6)
		}
		override public function Fall(d:TDropper):void{
			Remove()
			stops = true
			new TFadeOut(x,y,this,0.1)
		}
		override public function Teleport():void{
			var b:BitmapAsset
			if (dir == 0){
				b = new g_0
			} else if (dir == 1){
				b = new g_1
			} else	if (dir == 2){
				b = new g_2
			} else	if (dir == 3){
				b = new g_3
			}
			new TFadeWhite(x,y,b)
			alpha = 0
			new TItemAppear(this,1)
		}
	}
}