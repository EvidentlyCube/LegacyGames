package Classes.Interactivers
{
	import Classes.Items.TDropper;
	import Classes.TLevel;

	import Functions.RectRect;

	import flash.display.Sprite;

	import mx.core.BitmapAsset;
	public class TObject extends Sprite{
		public var moveX:int = 0
		public var moveY:int = 0
		public var F_isStoppable:Boolean = false
		public var F_isTeleportable:Boolean = false
		public var F_stopsObjects:Boolean = false
		public var F_hitsButtons:Boolean = false
		public var F_canPush:Boolean = false
		public var F_canFall:Boolean = false
		public var F_bulletKills:Boolean = false
		public var F_mineKills:Boolean = false
		public var F_isTiny:Boolean = false
		public var F_collectsBonuses:Boolean = false
		public var F_ignoreArrows:Boolean = false
		public var F_enemyKills:Boolean = false
		public var F_enemyStops:Boolean = false
		public var F_accurateHits:Boolean = false
		public var F_stopsCrates:Boolean = true
		public var stomps:Boolean = false
		public var stops:Boolean = false
		public var waitTurn:Boolean = false
		public var moveSteps:uint = 0
		public function TObject(){}
		public function Update():void{}
		public function Remove():void{}
		public function Hit(who:TObject):void{}
		public function checkHits():void{
			var tx:int = x+moveX * 2
			var ty:int = y+moveY * 2
			if (!F_accurateHits){
				tx = Math.floor((x + 12 + moveX * 13) / 24) * 24
				ty = Math.floor((y + 12 + moveY * 13) / 24) * 24
			}
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
				if (RectRect(tx,ty,ox,oy)){
					obj.Hit(this)
					return;
				}
				if (ox < 24){
					if (RectRect(tx,ty,ox + TLevel.wid * 24,oy)){
						obj.Hit(this)
						return;
					}
				} else if (ox > TLevel.wid * 24 - 24){
					if (RectRect(tx,ty,ox - TLevel.wid * 24,oy)){
						obj.Hit(this)
						return;
					}
				} else if (oy < 24){
					if (RectRect(tx,ty,ox,oy + TLevel.hei * 24)){
						obj.Hit(this)
						return;
					}
				} else if (oy > TLevel.hei * 24 - 24){
					if (RectRect(tx,ty,ox,oy - TLevel.hei * 24)){
						obj.Hit(this)
						return;
					}
				}
			}
		}
		public function Stop(who:TObject = null):void{
			if (x%24 == 0 && y%24 == 0){
				moveX = 0
				moveY = 0
				stops = false
			} else {stops = true}
		}
		public function fillGraphics(_cl:Class):void{
			while (numChildren > 0){
				removeChildAt(0)
			}
			var ba:BitmapAsset = new _cl
			addChild(ba)

			ba = new _cl
			ba.x = TLevel.wid * 24
			addChild(ba)

			ba = new _cl
			ba.y = TLevel.hei * 24
			addChild(ba)
		}
		public function Destroy(who:*):void{}
		public function Fall(d:TDropper):void{}
		public function Teleport():void{

		}
	}
}