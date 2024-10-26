package Classes.Interactivers{
	import Classes.Items.TDropper;
	import Classes.Scenes.TLevelScene;
	import Classes.TLevel;

	import flash.display.Sprite;

	import mx.core.BitmapAsset;
	/*STATIC*/ public class TEnWaller extends TObject{
		[Embed("../../../assets/gfx/gameplay/EnemyC_0.png")] public static var g_4:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyC_1.png")] public static var g_5:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyC_2.png")] public static var g_6:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyC_3.png")] public static var g_7:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyC_4.png")] public static var g_0:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyC_5.png")] public static var g_1:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyC_6.png")] public static var g_2:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyC_7.png")] public static var g_3:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyC_A.png")] public static var g_a:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyC_B.png")] public static var g_b:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyC_C.png")] public static var g_c:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyC_D.png")] public static var g_d:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyC_E.png")] public static var g_e:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyC_F.png")] public static var g_f:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyC_G.png")] public static var g_g:Class;
		[Embed("../../../assets/gfx/gameplay/EnemyC_H.png")] public static var g_h:Class;
		private var waitTurnCount:uint = 0
		private var first:Boolean = true
		private var frames:Array = new Array(4)
		private var frame:uint = 0
		private var wait:uint = 0
		public var dir:int
		public function TEnWaller(_x:uint,_y:uint,_mx:int,_my:int,_dir:int){
			x=_x
			y=_y
			moveX=_mx
			moveY=_my

			dir=_dir
			if (dir == 1){
				frames[0]=g_0
				frames[1]=g_1
				frames[2]=g_2
				frames[3]=g_3
			} else {
				frames[0]=g_4
				frames[1]=g_5
				frames[2]=g_6
				frames[3]=g_7
			}

			for (var i:uint = 0;i < 4;i++){
				var ab:BitmapAsset = new frames[i]
				var bb:BitmapAsset = new frames[i]
				var cb:BitmapAsset = new frames[i]
				bb.x = TLevel.wid * 24
				cb.y = TLevel.hei * 24
				frames[i]=new Sprite
				frames[i].addChild(ab)
				frames[i].addChild(bb)
				frames[i].addChild(cb)
			}
			frames[0].visible = false
			frames[1].visible = false
			frames[2].visible = false
			frames[3].visible = false

			addChild(frames[0])
			addChild(frames[1])
			addChild(frames[2])
			addChild(frames[3])

			frame = Math.floor(Math.random() * 4)
			frames[frame].visible = true

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
			wait++
			if (wait == 2){
				wait = 0
				frames[frame].visible = false
				frame = (frame + 1)%4
				frames[frame].visible = true
			}
			if (moveX + moveY == 0){return}
			while (true){
				if (x%24 == 0 && y%24 == 0){
					var moveT:int = moveY
					moveY = moveX * dir
					moveX=-moveT * dir
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
					} else {
						continue
					}
				}
				break
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
			moveY=-moveX * dir
			moveX = moveT * dir
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

			new TFadeWhite(x,y,new g_0)

			alpha = 0
			new TItemAppear(this,1)
		}
	}
}