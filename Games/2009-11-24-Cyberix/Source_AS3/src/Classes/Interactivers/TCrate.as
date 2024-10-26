package Classes.Interactivers
{
	import Classes.Items.TDropper;
	import Classes.SFX;
	import Classes.TLevel;
	public class TCrate extends TObject{
		[Embed("../../../assets/gfx/gameplay/Crate.png")] public static var g_0:Class;
		public function TCrate(_x:uint,_y:uint){
			x=_x
			y=_y

			F_isStoppable = true
			F_hitsButtons = true
			F_isTeleportable = true
			F_stopsObjects = true
			F_canPush = true
			F_bulletKills = true
			F_mineKills = true
			F_canFall = true
			F_ignoreArrows = true
			F_enemyStops = true
			F_stopsCrates = true

			stomps = false

			fillGraphics(g_0)
			Game.layerObjects.addChild(this)
		}
		override public function Update():void{
			if (moveX + moveY == 0){moveSteps = 0;return}
			if (x%24 == 0 && y%24 == 0){
				moveSteps++
				TLevel.checkStomp(this,x,y)
				if (stops){Stop();return;} else {TLevel.checkHit(this,x + moveX * 24,y + moveY * 24)}
			} else {
				TLevel.checkHit(this,x + 12 + moveX * 12,y + 12 + moveY * 12)
			}
			if (!stops){checkHits()}
			if (moveSteps == 1 && (moveX != 0 || moveY != 0) && x%24 == 0 && y%24 == 0){SFX.Play("crate push")}

			if (!waitTurn){
				x += moveX * 6
				y += moveY * 6
			}

			if (x<=-24){x += TLevel.wid * 24}
			if (x > TLevel.wid * 24 - 24){x -= TLevel.wid * 24}
			if (y<=-24){y += TLevel.hei * 24}
			if (y > TLevel.hei * 24 - 24){y -= TLevel.hei * 24}
			if (moveX + moveY != 0 && !waitTurn){stomps = true;stops = true}
			waitTurn = false
		}
		override public function Hit(who:TObject):void{
			if (who.F_stopsCrates){
				if (moveX + moveY != 0 && who.moveX==-moveX && who.moveY==-moveY){
					Stop()
				}
			}
			if (who.F_canPush && moveX + moveY == 0){
				moveX = who.moveX
				moveY = who.moveY
				stops = false
				stomps = false
			}
			who.Stop(this)
		}
		override public function Destroy(who:*):void{
			Remove()
			stops = true
			new TFadeWhite(x,y,new g_0,0.05,moveX * 6,moveY * 6)
		}
		override public function Fall(d:TDropper):void{
			Remove()
			stops = true
			new TFadeOut(x,y,new g_0,0.05)
			d.Fill(this)
		}
		override public function Remove():void{
			Game.layerObjects.removeChild(this)
		}
		override public function Teleport():void{
			new TFadeWhite(x,y,new g_0)
			alpha = 0
			new TItemAppear(this,1)
		}
	}
}