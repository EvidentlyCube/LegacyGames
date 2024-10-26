package{
	import flash.display.*
	import flash.events.*
	import flash.net.*
	import flash.text.*
	import flash.media.Sound
	import flash.external.ExternalInterface
	import flash.media.SoundChannel
	import flash.geom.Point
	import flash.ui.Keyboard
	import flash.display.StageScaleMode
	import flash.external.ExternalInterface
	import flash.net.LocalConnection
	import flash.utils.getTimer

	import com.mauft.DataVault.Vault;
	dynamic public class M extends MovieClip{
		public static var adCurrent:MovieClip = new MovieClip;
		public static var waitScoring:Boolean = false;

		public static var self:M

		public static var ptsToKill:Array=new Array()

		public static var amountPoints:uint=0;
		public static var amountHovered:uint=0;

		public static var fillX:Number;
		public static var fillY:Number;
		public static var lastFillX:Number;
		public static var lastFillY:Number;
		public static var lastX:Number;
		public static var lastY:Number;
		public static var firstX:Number
		public static var firstY:Number
		public static var pointList:Array=new Array()
		public static var lastPoint:Object

		public static var drawlayer:MovieClip;
		public static var paper:MovieClip;
		public static var picture:MovieClip;

		/* GAME MODE OPTIONS */
		public static var modeTempting  :Boolean = false;		//Tempting Render Engine
		public static var modeDarkness  :Boolean = false;		//All Points Are Invisible
		public static var modeFakes	    :uint    = 0;			//Amount of fake points to appear
		public static var modeDistance  :Number  = 100;			//RAndomization of distance of the fake points
		public static var modeAngle     :Number  = 5*Math.PI/180;			//RAndomization of angle of the fake points
		public static var modeHiding    :Boolean = false;		//Points are Unordered
		public static var modeDifficulty:uint    = 0			//Difficulty: Easy, Normal, Expert
		public static var modeTutorial  :Boolean = true;		//Whether to show guidelines
		public static var modeSketch    :Boolean = true;

		public static var music:Boolean = true;
		public static var sfx:Boolean   = true;
		public static var titleVisited:Boolean=false;
		public static var completion:Array=new Array(8);

		public static var mch:SoundChannel
		public static var dark:Shape=new Shape;

		public static var tempFin:uint = 0;
		public static var lastLevel:uint = 0;

		public static var tooltip:TextField;
		public static var menuBar:Object;

		public static var butPlay:Object;
		public static var butView:Object;
		public static var butViewScore:Object;

		public static var hud:Object;
		public static var timer:Number=0;

		public static var init:Boolean = false;
		public function M():void{
			tabChildren = false;
			Vault.setValue("score", 0);

			addChild(adCurrent);
			adCurrent.visible = false;

			for (var i:uint=0;i<8;i++){
				completion[i]=false
			}

			dark.graphics.beginFill(0)
			dark.graphics.drawRect(0,0,600,600)
			dark.graphics.endFill()
			dark.alpha=0;
			self=this

			ModernDisplay.Init(this, stage, 600, 600);
		}

		public function escapeCheck(e:KeyboardEvent):void{
			if (e == null || e.keyCode==81 || e.keyCode==Keyboard.ESCAPE){
				if (currentFrame>5 && !waitScoring){
					modeTutorial=false;
					tipSet("");
					removeChild(drawlayer);
					removeChild(paper);
					removeChild(picture);
					self.removeEventListener(Event.ENTER_FRAME,completeNormal);
					self.removeEventListener(Event.ENTER_FRAME,completeTempting);
					self.removeEventListener(Event.ENTER_FRAME,step);
					for each(var i:DisplayObject in pointList){
						if (contains(i)){ removeChild(i); }
					}
					pointList = new Array();
					gotoAndStop(4)
				}
			}
		}
		public static function reset():void{
			amountPoints=0
			amountHovered=0
			tempFin=0
			while (ptsToKill.length){
				self.removeChild(ptsToKill.pop())
			}
			pointList=new Array()
		}
		public static function step(e:Event):void{
			if (amountHovered==0 || amountHovered==amountPoints){return}
			timer --;
			if (timer == 0){
				self.removeEventListener(Event.ENTER_FRAME,step)
				var s:Sound=new BUZZER
				if (M.sfx){s.play()}

				for each(var i:DisplayObject in pointList){
					if (self.contains(i)){ self.removeChild(i); }
				}
				pointList = new Array();

				self.gotoAndStop(self.currentFrame-1)
			}
		}
		public static function hovered():void{
			if (modeDifficulty == 0){
				Vault.setValue("score", Vault.retrieveValue("score") + Math.floor(timer / 24));
				hud.scored(Math.floor(timer / 24));
				timer = 240;
			} else if (modeDifficulty == 1){
				Vault.setValue("score", Vault.retrieveValue("score") + Math.floor(timer / 4));
				hud.scored(Math.floor(timer / 4));
				timer = 120;
			} else {
				Vault.setValue("score", Vault.retrieveValue("score") + Math.floor(timer * 2));
				hud.scored(Math.floor(timer * 2));
				timer = 60;
			}
			while (ptsToKill.length){
				ptsToKill.pop().disappear()
			}
			if (amountHovered>0 && amountHovered<amountPoints && modeFakes>0){
				var posX:Number=pointList[amountHovered-1].x
				var posY:Number=pointList[amountHovered-1].y
				var posX2:Number=pointList[amountHovered].x
				var posY2:Number=pointList[amountHovered].y
				var basedir:Number=Math.atan2(posY2-posY,posX2-posX)
				var dist:Number=Math.sqrt((posX2-posX)*(posX2-posX)+(posY2-posY)*(posY2-posY))
				var turn:Number=(Math.PI*2)/(1+modeFakes)
				for (var i:uint=1;i<=modeFakes;i++){
					var l:O_NUMBERX_FAKE=new O_NUMBERX_FAKE
					l.x=posX+Math.cos(turn*i+basedir+Math.random()*modeAngle - Math.random()*modeAngle)*Math.max(60, dist + Math.random()*modeDistance - Math.random()*modeDistance);
					l.y=posY+Math.sin(turn*i+basedir+Math.random()*modeAngle - Math.random()*modeAngle)*Math.max(60, dist + Math.random()*modeDistance - Math.random()*modeDistance);
					ptsToKill.push(l)
					self.addChildAt(l,Math.min(self.numChildren-1,2))
				}
			}
		}
		public static function completed():void{
			completion[(self.currentFrame-7)/2]=true

			waitScoring = true;

			leaderboardClose();

			if (modeTempting){
				self.addEventListener(Event.ENTER_FRAME,completeTempting)
				self.removeEventListener(Event.ENTER_FRAME,step)
			} else {
				if (!modeSketch){
					drawlayer.graphics.clear()
					drawlayer.graphics.beginFill(0)
					drawlayer.graphics.lineStyle(0)
					drawlayer.graphics.moveTo(pointList[0].x,pointList[0].y)
					for (var i:uint=1;i<pointList.length;i++){
						drawlayer.graphics.lineTo(pointList[i].x,pointList[i].y)
					}
					drawlayer.graphics.endFill()
				}
				self.addEventListener(Event.ENTER_FRAME,completeNormal)
				self.removeEventListener(Event.ENTER_FRAME,step)
			}
			var s:Sound=new SFX_WIN
			if (M.sfx){s.play()}
		}
		public static function completeNormal(e:Event):void{
			if (modeSketch){
				picture.alpha += 0.02;
				drawlayer.alpha -= 0.02;
				if (picture.alpha>=1){
					picture.alpha = 1;
					drawlayer.alpha = 0;
					self.removeEventListener(Event.ENTER_FRAME,completeNormal);
				}
			} else if (paper.alpha>-0.5){
				paper.alpha-=0.02
				if (drawlayer.alpha<1){drawlayer.alpha+=0.02}
			} else if (drawlayer.alpha>0){
				drawlayer.alpha-=0.02
			} else {
				paper.visible=false
				drawlayer.visible=false
				self.removeEventListener(Event.ENTER_FRAME,completeNormal)
			}
		}
		public static function completeTempting(e:Event):void{
			drawlayer.graphics.beginFill(0)
			drawlayer.graphics.drawEllipse(300-tempFin*10,300-tempFin*10,tempFin*20,tempFin*20)
			drawlayer.graphics.endFill()
			tempFin++
			if (tempFin>45){
				self.removeEventListener(Event.ENTER_FRAME,completeTempting)
			}
		}

		public static function tipSet(t:String):void{
			tooltip.wordWrap=false
			tooltip.text = t;
		}
		public static function leaderboardClose():void{
			waitScoring = false;
		}
	}
}