package objects
{
	import flash.display.Sprite;
	import mx.core.BitmapAsset;
	import flash.media.Sound
	import flash.geom.Matrix
	import flash.display.GradientType
	import flash.display.SpreadMethod
	import flash.display.Shape
	import flash.text.TextField
	import flash.text.TextFieldAutoSize
	/**
	* ...
	* @author $(DefaultUser)
	*/
	public class GameEnd{
		[Embed(source="../../assets/gfx/game/GFX_KISS.png")]			private var GFXK:Class;
		[Embed(source="../../assets/gfx/game/GFX_CASTLE.png")]			private var GFXC:Class;
		private var castle:Sprite=new Sprite
		private var kiss:Sprite=new Sprite
		private var flash:Sprite=new Sprite
		private var bar:Shape=new Shape
		private var bar2:Shape=new Shape
		private var cY:Number=20
		private var cX:Number
		private var timer:Number=0
		private var seq:uint=0
		private var list:Array=new Array();
		private var txt:TextField=new TextField;
		[Embed(source='../../assets/sfx/jebut.mp3')]					private var Jebs:Class;
		private var SFXJ:Sound
		private var kifu:Boolean=false;
		public function GameEnd() {
			SFXJ=new Jebs
			flash.graphics.beginFill(0xFFFFFF)
			flash.graphics.drawRect(0,0,400,375)
			flash.graphics.endFill()
			Mario.playerControllable=false
			objects.Player.GFX2.alpha=0
			Mario.Hud.GFX.alpha=0
			var tem:BitmapAsset=new GFXK
			kiss.addChild(tem)
			kiss.x=200-kiss.width/2
			kiss.y=40
			tem=new GFXC
			castle.addChild(tem)
			kiss.alpha=0
			cX=200-castle.width/2
			castle.x=cX
			castle.y=cY
			Barer()
			Mario.layerHide.addChild(castle)
			Mario.layerGover.addChild(flash)
			Mario.layerGover.addChild(kiss)
			Mario.layerGover.addChild(bar)
			Mario.layerGover.addChild(txt)
			Mario.layerGover.addChild(bar2)
			txt.textColor=0xFFFFFF
			bar.alpha=0
			bar2.alpha=0
			flash.alpha=0
			txt.scaleX=1.5
			txt.x=200
			txt.y=309

			txt.scaleY=1.5
			txt.autoSize=TextFieldAutoSize.CENTER


			txt.alpha=0
		}
		public function Update(myID:uint):void{
			if (Mario.music==0){kifu=true;} else if (kifu){
				if (seq==0){
					Mario.classSFX.Play(8);
				}
				kifu=false;
			}
			if (seq==0){
				if (timer==0){
					Mario.classSFX.Play(8)
				}
				cY+=timer>100?(timer-100)/135:0
				Mario.playerControllable=false
				objects.Player.GFX2.alpha=0
				Mario.Hud.GFX.alpha=0
				castle.x=cX+Math.sin(timer)*5
				castle.y=cY
				timer+=1
				Mario.instEffects.push(new Fire_Boom(cX+Math.random()*castle.width,275));
				if (Math.random()<0.2){Throw()}
				if (cY>=265){
					seq=1
					timer=2
					if (Mario.sounds){SFXJ.play();}
				}
			} else if (seq==1){
				flash.alpha=timer
				timer-=0.01
				if (timer<=0){
					seq=2
					timer=-0.5
				}
			} else if (seq==2){
				timer+=0.01
				kiss.alpha=timer
				bar.alpha=timer
				if (timer>=1){
					bar2.alpha=1
					txt.alpha=1
					timer=0
					seq=3;
					txt.htmlText="<p align='center'>Squario \n2008 Mauft.com</p>";
					txt.x=200-txt.width/2
				}
			} else if(seq==3){
				timer+=0.01
				bar2.alpha=1-Math.sin(timer)*4
				if (timer>Math.PI){
					timer=0
					seq=4;
					txt.htmlText="<p align='center'>Created by: Mauft.com\n Programming: Mauft.com\n Graphics: Mauft.com</p>";
					txt.x=200-txt.width/2
				}
			} else if(seq==4){
				timer+=0.01
				bar2.alpha=1-Math.sin(timer)*4
				if (timer>Math.PI){
					timer=0
					seq=5;
					txt.htmlText="<p align='center'>\nSound Effects: Public Domain\nLevel Design: Mauft.com</p>";
					txt.x=200-txt.width/2
				}
			} else if(seq==5){
				timer+=0.01
				bar2.alpha=1-Math.sin(timer)*4
				if (timer>Math.PI){
					timer=0
					seq=6;
					txt.scaleX=2.5
					txt.scaleY=2.5
					txt.htmlText="<p align='center'>Thank You for Playing!</p>";
					txt.x=200-txt.width/2
					txt.y+=10
				}
			} else if(seq==6){
				timer+=0.005
				bar2.alpha=1-Math.sin(timer)*4
				if (timer>Math.PI){
					Mario.clearLevel(false)
					Mario.TScreen=new TitleScreen;
					Mario.sequence=4
					Mario.decreaseI=1
					Mario.stepping=true
				}
			}
		}
		public function Throw():void{
			if (list.length==0){
				list.push("enemy_goomba","enemy_goomba","bonus_used","effect_hammer","enemy_bbeetle_1","enemy_bbeetle_2")
				list.push("enemy_bbeetle_shell_1","enemy_bbeetle_shell_2","enemy_bbeetle_shell_3","enemy_bbeetle_shell_4")
				list.push("enemy_bullet_1","enemy_bullet_2","enemy_bullet_3","enemy_fly_green_1","enemy_fly_green_2")
				list.push("enemy_fly_red_1","enemy_fly_red_2","enemy_hammer_1","enemy_hammer_2","enemy_jumper_1")
				list.push("enemy_jumper_2","enemy_jumper_3","enemy_koopa_green_1","enemy_koopa_green_2","enemy_koopa_red_1")
				list.push("enemy_koopa_red_2","enemy_lakitu_1","enemy_shell_green_1","enemy_shell_green_2","enemy_shell_green_3")
				list.push("enemy_shell_green_4","enemy_shell_red_1","enemy_shell_red_2","enemy_shell_red_3","enemy_shell_red_4")
				list.push("enemy_spiny_1","enemy_spiny_2","enemy_spiny_shell_1","enemy_spiny_shell_2")
			}
			var czop:uint=Math.floor(Math.random()*list.length)
			Mario.instEffects.push(new Gamend_Fire(cX+70+Math.random()*(castle.width-140),cY+80,Math.random()*4-Math.random()*4,list[czop]))
		}
		public function Barer():void{
			var fillType:String=GradientType.LINEAR;
			var colors:Array=[0x000000,0x000000];
			var alphas:Array=[0,1]
			var ratios:Array=[0,40]
			var matr:Matrix = new Matrix()
			matr.createGradientBox(400,75,Math.PI/2);
			var spreadMethod:String=SpreadMethod.PAD;
			bar.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);
			bar.graphics.drawRect(0,0,400,75)
			bar.graphics.endFill()
			bar.y=300
			bar2.graphics.beginFill(0x000000)
			bar2.graphics.drawRect(0,0,400,75)
			bar2.graphics.endFill()
			bar2.y=315
		}
	}

}