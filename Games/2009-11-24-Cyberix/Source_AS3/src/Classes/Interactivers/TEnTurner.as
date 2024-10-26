package Classes.Interactivers{
	import Classes.Items.TDropper;
	import Classes.Scenes.TLevelScene;
	import Classes.TLevel;

	import flash.display.Sprite;

	import mx.core.BitmapAsset;
	/*STATIC*/ public class TEnTurner extends TObject{
		[Embed("../../../assets/gfx/gameplay/EnemyB_0.png")] public static var g_0:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyB_1.png")] public static var g_1:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyB_2.png")] public static var g_2:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyB_3.png")] public static var g_3:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyB_4.png")] public static var g_4:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyB_5.png")] public static var g_5:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyB_6.png")] public static var g_6:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyB_7.png")] public static var g_7:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyB_8.png")] public static var g_8:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyB_9.png")] public static var g_9:Class;
		private var waitTurnCount:uint = 0
		private var first:Boolean = true
		private var s0:Sprite = new Sprite
		private var s1:Sprite = new Sprite
		private var s2:Sprite = new Sprite
		public var dir:int
		public function TEnTurner(_x:uint,_y:uint,_mx:int,_my:int,_dir:int){
			x=_x
			y=_y
			moveX=_mx
			moveY=_my

			dir=_dir
			var b:BitmapAsset


			b = new g_1
			b.smoothing = true
			b.x = b.y=-12
			s0.x = s0.y = 12
			s0.addChildAt(b,0)
			addChild(s0)

			b = new g_1
			b.smoothing = true
			b.x = b.y=-12
			s1.x = 612
			s1.y = 12
			s1.addChildAt(b,0)
			addChild(s1)

			b = new g_1
			b.smoothing = true
			b.x = b.y=-12
			s2.x = 12
			s2.y = 612
			s2.addChildAt(b,0)
			addChild(s2)

			b = new g_0
			addChild(b)
			b = new g_0
			b.x = 600
			addChild(b)
			b = new g_0
			b.y = 600
			addChild(b)

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
			Game.layerObjects.addChild(this)
		}
		override public function Update():void{
			s0.rotation += 8*dir
			s1.rotation += 8*dir
			s2.rotation += 8*dir
			if (moveX + moveY == 0){return}
			if (x%24 == 0 && y%24 == 0){
				TLevel.checkStomp(this,x,y)
				if (stops){Stop();return;} else {TLevel.checkHit(this,x + moveX * 24,y + moveY * 24)}
			} else {TLevel.checkHit(this,x + 12 + moveX * 12,y + 12 + moveY * 12)}
			if (!waitTurn &&!stops){checkHits()}
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
				//return
			}
			if (x%24 != 0 || y%24 != 0){
				stops = true
				return
			}
			var moveT:int = moveY
			moveY = moveX * dir
			moveX=-moveT * dir
			waitTurn = true
			stops = false
			moveSteps = 0
			/*
			if (x%24 == 0 && y%24 == 0){

				if (!stops){waitTurn = 1}
				stops = false
			} else {
				stops = true
			}*/
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
			var b1:BitmapAsset = new g_0
			var b2:BitmapAsset = new g_1
			var s:Sprite = new Sprite
			s.x = 12
			s.y = 12
			b2.x=-12
			b2.y=-12
			s.rotation = getChildAt(0).rotation
			s.addChild(b2)
			new TFadeWhite(x,y,s)
			new TFadeWhite(x,y,b1)
			alpha = 0
			new TItemAppear(this,1)
		}
	}
}