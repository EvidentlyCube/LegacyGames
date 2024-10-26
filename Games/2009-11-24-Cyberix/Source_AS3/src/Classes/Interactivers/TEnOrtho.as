package Classes.Interactivers{
	import Classes.Items.TDropper;
	import Classes.Scenes.TLevelScene;
	import Classes.TLevel;

	import flash.display.Sprite;

	import mx.core.BitmapAsset;
	/*STATIC*/ public class TEnOrtho extends TObject{
		[Embed("../../../assets/gfx/gameplay/EnemyA_0.png")] public static var g_0:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyA_1.png")] public static var g_1:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyA_2.png")] public static var g_2:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyA_3.png")] public static var g_3:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyA_4.png")] public static var g_4:Class;
		private var waitTurnCount:uint = 0
		private var first:Boolean = true
		private var s0:Sprite = new Sprite
		private var s1:Sprite = new Sprite
		private var s2:Sprite = new Sprite
		private var sc:Number = 0
		public function TEnOrtho(_x:uint,_y:uint,_mx:int,_my:int){
			x=_x
			y=_y
			moveX=_mx
			moveY=_my

			F_bulletKills = true
			F_canPush = true
			F_hitsButtons = true
			F_ignoreArrows = true
			F_isTeleportable = true
			F_mineKills = true
			F_enemyStops = true
			//F_accurateHits = true
			F_stopsCrates = true

			stomps = true

			var b:BitmapAsset = new g_0
			b.smoothing = true
			b.x = b.y=-12
			s0.x = s0.y = 12
			s0.addChild(b)
			addChild(s0)
			b = new g_0
			b.smoothing = true
			b.x = b.y=-12
			s1.x = 12
			s1.y = 12 + TLevel.hei * 24
			s1.addChild(b)
			addChild(s1)
			b = new g_0
			b.smoothing = true
			b.x = b.y=-12
			s2.x = 12 + TLevel.wid * 24
			s2.y = 12
			s2.addChild(b)
			addChild(s2)

			sc = Math.random() * Math.PI

			Game.layerObjects.addChild(this)
		}
		override public function Update():void{
			if (moveX + moveY == 0){return}
			if (x%24 == 0 && y%24 == 0){
				moveSteps++
				TLevel.checkStomp(this,x,y)
				if (stops){Stop();return;} else {TLevel.checkHit(this,x + moveX * 24,y + moveY * 24)}
			} else {TLevel.checkHit(this,x + 12 + moveX * 12,y + 12 + moveY * 12)}

			if (!stops){checkHits()}
			if (!waitTurn){
				x += moveX * 2
				y += moveY * 2
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
			waitTurn = false
			sc += 0.2
			if (sc > Math.PI * 2){
				sc -= Math.PI * 2
			}
			s0.scaleX = s1.scaleX = s2.scaleX = 1.1 + Math.sin(sc) / 10
			s0.scaleY = s1.scaleY = s2.scaleY = 1.1 + Math.sin(sc + 3.14) / 10
		}
		override public function Hit(who:TObject):void{
			if (who.F_enemyStops){
				if (moveX + moveY != 0 && who.moveX==-moveX && who.moveY==-moveY){
					Stop()
				}
			}
			if (who as TPlayer){who.Destroy(this)}else{who.Stop(this)}
		}
		override public function Stop(who:TObject = null):void{
			if (who && who.F_enemyKills){
				TLevelScene.killedObject(who)
				who.Destroy(this)
				return
			}
			if (x%24 != 0 || y%24 != 0){
				stops = true
				return
			}
			moveX*=-1
			moveY*=-1
			waitTurn = true
			stops = false
			moveSteps = 0
		}
		override public function Remove():void{
			Game.layerObjects.removeChild(this)
		}
		override public function Destroy(who:*):void{
			Remove()
			stops = true
			new TFadeWhite(x,y,this,0.05,moveX * 2,moveY * 2)
		}
		override public function Fall(d:TDropper):void{
			Remove()
			stops = true
			new TFadeOut(x,y,this,0.05,moveX * 2,moveY * 2)
		}
		override public function Teleport():void{
			var b:BitmapAsset = new g_0
			var s:Sprite = new Sprite
			s.x = 12
			s.y = 12
			b.x=-12
			b.y=-12
			s.addChild(b)
			new TFadeWhite(x,y,s)
			alpha = 0
			new TItemAppear(this,1)
		}
	}
}