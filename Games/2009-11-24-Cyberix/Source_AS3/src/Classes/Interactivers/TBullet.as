package Classes.Interactivers{
	import Classes.SFX;
	import Classes.Scenes.TLevelScene;
	import Classes.TLevel;

	import Functions.RectRect2;
	public class TBullet extends TObject{
		[Embed("../../../assets/gfx/gameplay/Bullet.png")] private var g0:Class;
		public function TBullet(_x:uint,_y:uint,_sx:int,_sy:int){
			x=_x+_sx * 12
			y=_y+_sy * 12

			moveX=_sx
			moveY=_sy

			F_isTeleportable = true
			F_isTiny = true
			F_mineKills = true
			F_ignoreArrows = true

			stomps = false

			fillGraphics(g0)
			Game.layerObjects.addChild(this)
		}
		override public function Update():void{
			if (moveX + moveY == 0){return}
			if (x%24 == 0 && y%24 == 0){
				this.moveSteps++
				TLevel.checkStomp(this,x,y)
				if (stops){return;} else {TLevel.checkHit(this,x + 12 + moveX * 13,y + 12 + moveY * 13)}
			} else {
				TLevel.checkHit(this,x + 12 + moveX * 13,y + 12 + moveY * 13)
				if (stops){return;}
				TLevel.checkBullet(this,x + 12 + moveX * 3,y + 12 + moveY * 3)
				checkHits()
			}

			if (!waitTurn){
				x += moveX * 6
				y += moveY * 6
			}

			if (x<=-24){x += TLevel.wid * 24}
			if (x > TLevel.wid * 24 - 24){x -= TLevel.wid * 24}
			if (y<=-24){y += TLevel.hei * 24}
			if (y > TLevel.hei * 24 - 24){y -= TLevel.hei * 24}
			if (moveX + moveY != 0 && !waitTurn){stomps = true}
			waitTurn = false
		}
		override public function checkHits():void{
			var tx:int = x
			var ty:int = y
			var ox:int
			var oy:int
			var i:uint = 0
			var obj:TObject
			if (tx < 0){
				tx += TLevel.wid * 24
			} else if(tx > TLevel.wid * 24 - 24){
				tx -= TLevel.wid * 24
			} else if (ty < 0){
				ty += TLevel.hei * 24
			} else if (ty > TLevel.hei * 24 - 24){
				ty -= TLevel.hei * 24
			}
			for (i = 0;i < Game.layerObjects.numChildren;i++){
				obj = Game.layerObjects.getChildAt(i) as TObject?Game.layerObjects.getChildAt(i) as TObject:null
				if (obj == null || obj == this){continue}
				ox = obj.x
				oy = obj.y
				if (RectRect2(tx + 9,ty + 9,ox,oy)){
					Stop(obj)
					return
				}
				if (ox < 24){
					if (RectRect2(tx + 9,ty + 9,ox + TLevel.wid * 24,oy)){
						Stop(obj)
						return
					}
				} else if (ox > TLevel.wid * 24 - 24){
					if (RectRect2(tx + 9,ty + 9,ox - TLevel.wid * 24,oy)){
						Stop(obj)
						return
					}
				} else if (oy < 24){
					if (RectRect2(tx + 9,ty + 9,ox,oy + TLevel.hei * 24)){
						Stop(obj)
						return
					}
				} else if (oy > TLevel.hei * 24 - 24){
					if (RectRect2(tx + 9,ty + 9,ox,oy - TLevel.hei * 24)){
						Stop(obj)
						return
					}
				}
			}
		}
		override public function Stop(who:TObject = null):void{
			if (who as TBullet){return}
			if (who && who.F_bulletKills){
				TLevelScene.killedObject(who)
				who.Destroy(this)
			} else {
				SFX.Play("bullet")
			}
			stops = true
			TLevelScene.killedObject(this)

			Remove()
		}
		override public function Destroy(who:*):void{
			stops = true
			TLevelScene.killedObject(this)
			Remove()
		}
		override public function Remove():void{
			stops = true
			Game.layerObjects.removeChild(this)
		}
		override public function Teleport():void{
			new TFadeWhite(x,y,new g0)
			alpha = 0
			new TItemAppear(this,1)
		}
	}
}