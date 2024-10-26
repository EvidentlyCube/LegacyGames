package objects {
	import flash.display.Sprite;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.text.StaticText;
	import flash.text.TextField;
	import mx.core.BitmapAsset;

	/**
	* ...
	* @author Default
	*/
	public class TypeHud {
		public var Pnts:int=0;
		public var Coins:int=0;
		public var Time:int=320;
		public var Interval:int=20;
		public var Lives:int=2;
		public var SFXLife:Sound=new (Mario.classSFX.accessSFX("life"));
		public var GFX:Sprite=new Sprite();
		private var GFXC1:BitmapAsset;
		private var GFXC2:BitmapAsset;
		private var GFXP1:BitmapAsset;
		private var GFXP2:BitmapAsset;
		private var GFXP3:BitmapAsset;
		private var GFXP4:BitmapAsset;
		private var GFXP5:BitmapAsset;
		private var GFXP6:BitmapAsset;
		private var GFXT1:BitmapAsset;
		private var GFXT2:BitmapAsset;
		private var GFXT3:BitmapAsset;
		private var GFXW1:BitmapAsset;
		private var GFXW2:BitmapAsset;
		private var GFXW3:BitmapAsset;
		private var GFXTIME:BitmapAsset;
		private var GFXMARIO:BitmapAsset;
		private var GFXWORLD:BitmapAsset;
		private var GFXCOIN:BitmapAsset;
		private var GFXX:BitmapAsset;
		private var wait:uint=0;
		public var debugtext:TextField=new TextField();
		public var SFXHurry:Sound=new (Mario.classSFX.accessSFX('hurry'));
		public function TypeHud(){
			Mario.layerWall.addChild(debugtext);
			var GFXclass:Class;
			GFXclass=Mario.classGFX.AccessGFX("font_1");
			GFXC1=new GFXclass();
			GFXC1.x=0;
			GFXC1.y=0;
			GFX.addChild(GFXC1);
			GFXclass=Mario.classGFX.AccessGFX("font_1");
			GFXC2=new GFXclass();
			GFXC2.x=1;
			GFXC2.y=1;
			GFX.addChild(GFXC2);
			GFXclass=Mario.classGFX.AccessGFX("font_1");
			GFXP1=new GFXclass();
			GFXP1.x=1;
			GFXP1.y=1;
			GFX.addChild(GFXP1);
			GFXclass=Mario.classGFX.AccessGFX("font_1");
			GFXP2=new GFXclass();
			GFXP2.x=1;
			GFXP2.y=1;
			GFX.addChild(GFXP2);
			GFXclass=Mario.classGFX.AccessGFX("font_1");
			GFXP3=new GFXclass();
			GFXP3.x=1;
			GFXP3.y=1;
			GFX.addChild(GFXP3);
			GFXclass=Mario.classGFX.AccessGFX("font_1");
			GFXP4=new GFXclass();
			GFXP4.x=1;
			GFXP4.y=1;
			GFX.addChild(GFXP4);
			GFXclass=Mario.classGFX.AccessGFX("font_1");
			GFXP5=new GFXclass();
			GFXP5.x=1;
			GFXP5.y=1;
			GFX.addChild(GFXP5);
			GFXclass=Mario.classGFX.AccessGFX("font_1");
			GFXP6=new GFXclass();
			GFXP6.x=1;
			GFXP6.y=1;
			GFX.addChild(GFXP6);
			GFXclass=Mario.classGFX.AccessGFX("font_1");
			GFXT1=new GFXclass();
			GFXT1.x=1;
			GFXT1.y=1;
			GFX.addChild(GFXT1);
			GFXclass=Mario.classGFX.AccessGFX("font_1");
			GFXT2=new GFXclass();
			GFXT2.x=1;
			GFXT2.y=1;
			GFX.addChild(GFXT2);
			GFXclass=Mario.classGFX.AccessGFX("font_1");
			GFXT3=new GFXclass();
			GFXT3.x=1;
			GFXT3.y=1;
			GFX.addChild(GFXT3);
			GFXclass=Mario.classGFX.AccessGFX("font_time");
			GFXTIME=new GFXclass();
			GFXTIME.x=325;
			GFXTIME.y=20;
			GFX.addChild(GFXTIME);
			GFXclass=Mario.classGFX.AccessGFX("font_world");
			GFXWORLD=new GFXclass();
			GFXWORLD.x=200;
			GFXWORLD.y=20;
			GFX.addChild(GFXWORLD);
			GFXclass=Mario.classGFX.AccessGFX("font_mario");
			GFXMARIO=new GFXclass();
			GFXMARIO.x=25;
			GFXMARIO.y=20;
			GFX.addChild(GFXMARIO);
			GFXclass=Mario.classGFX.AccessGFX("font_coin_1");
			GFXCOIN=new GFXclass();
			GFXCOIN.x=120;
			GFXCOIN.y=35;
			GFX.addChild(GFXCOIN);
			GFXclass=Mario.classGFX.AccessGFX("font_x");
			GFXX=new GFXclass;
			GFXX.x=130;
			GFXX.y=36;
			GFX.addChild(GFXX);
			GFXclass=Mario.classGFX.AccessGFX("font_1");
			GFXW1=new GFXclass;
			GFXW1.x=214;
			GFXW1.y=35;
			GFX.addChild(GFXW1);
			GFXclass=Mario.classGFX.AccessGFX("font_-");
			GFXW2=new GFXclass;
			GFXW2.x=225;
			GFXW2.y=35;
			GFX.addChild(GFXW2);
			GFXclass=Mario.classGFX.AccessGFX("font_1");
			GFXW3=new GFXclass;
			GFXW3.x=238;
			GFXW3.y=35;
			GFX.addChild(GFXW3);
			RedrawWorld();
			RedrawCoins();
			RedrawTime();
			RedrawPnts();
		}
		public function Update():void{
			if (Mario.playerControllable){Interval--;
				if (Interval==0){
					Interval=25;
					Time--;
					RedrawTime();
					if (Time==100){
						SFXHurry.play()
					}
				}
				if (Time==0){
					Mario.hitPlayer(true, true);
				}
			}
			wait=(wait+1)%30+1;
			if (wait%10==2){
				GFX.removeChild(GFXCOIN);
				var GFXclass:Class=Mario.classGFX.AccessGFX("font_coin_"+Math.ceil(wait/10));
				GFXCOIN=new GFXclass();
				GFXCOIN.x=115;
				GFXCOIN.y=35;
				GFX.addChild(GFXCOIN);
			}
		}
		public function RedrawCoins():void{
			GFX.removeChild(GFXC1);
			GFX.removeChild(GFXC2);
			while (Coins>99){
				Coins-=100;
				Mario.instEffects.push(new Points(Player.pX,Player.pY,"1up"));
				if (Mario.sounds){SFXLife.play();}
			}
			var GFXclass:Class=Mario.classGFX.AccessGFX("font_"+Math.floor(Coins/10));
			GFXC1=new GFXclass();
			GFXclass=Mario.classGFX.AccessGFX("font_"+(Coins%10));
			GFXC2=new GFXclass();
			GFXC1.x=142;
			GFXC1.y=35
			GFXC2.x=154;
			GFXC2.y=35
			GFX.addChild(GFXC1);
			GFX.addChild(GFXC2);
		}
		public function RedrawTime():void{
			GFX.removeChild(GFXT1);
			GFX.removeChild(GFXT2);
			GFX.removeChild(GFXT3);
			var GFXclass:Class=Mario.classGFX.AccessGFX("font_"+Math.floor(Time/100));
			GFXT1=new GFXclass();
			GFXclass=Mario.classGFX.AccessGFX("font_"+Math.floor(Time/10)%10);
			GFXT2=new GFXclass();
			GFXclass=Mario.classGFX.AccessGFX("font_"+Time%10);
			GFXT3=new GFXclass();
			GFXT1.x=340+(Time>99?0:1000);
			GFXT1.y=35
			GFXT2.x=352+(Time>9?0:1000);
			GFXT2.y=35
			GFXT3.x=364;
			GFXT3.y=35;
			GFX.addChild(GFXT1);
			GFX.addChild(GFXT2);
			GFX.addChild(GFXT3);
		}
		public function RedrawPnts():void{
			GFX.removeChild(GFXP1);
			GFX.removeChild(GFXP2);
			GFX.removeChild(GFXP3);
			GFX.removeChild(GFXP4);
			GFX.removeChild(GFXP5);
			GFX.removeChild(GFXP6);
			var GFXclass:Class=Mario.classGFX.AccessGFX("font_"+Math.floor(Pnts/100000));
			GFXP1=new GFXclass();
			GFXclass=Mario.classGFX.AccessGFX("font_"+Math.floor(Pnts/10000)%10);
			GFXP2=new GFXclass();
			GFXclass=Mario.classGFX.AccessGFX("font_"+Math.floor(Pnts/1000)%10);
			GFXP3=new GFXclass();
			GFXclass=Mario.classGFX.AccessGFX("font_"+Math.floor(Pnts/100)%10);
			GFXP4=new GFXclass();
			GFXclass=Mario.classGFX.AccessGFX("font_"+Math.floor(Pnts/10)%10);
			GFXP5=new GFXclass();
			GFXclass=Mario.classGFX.AccessGFX("font_"+Pnts%10);
			GFXP6=new GFXclass();
			GFXP1.x=25+(Pnts>99999?0:1000);
			GFXP1.y=35
			GFXP2.x=37+(Pnts>9999?0:1000);
			GFXP2.y=35
			GFXP3.x=49+(Pnts>999?0:1000);
			GFXP3.y=35
			GFXP4.x=61+(Pnts>99?0:1000);
			GFXP4.y=35
			GFXP5.x=73+(Pnts>9?0:1000);
			GFXP5.y=35
			GFXP6.x=85;
			GFXP6.y=35;
			GFX.addChild(GFXP1);
			GFX.addChild(GFXP2);
			GFX.addChild(GFXP3);
			GFX.addChild(GFXP4);
			GFX.addChild(GFXP5);
			GFX.addChild(GFXP6);
		}
		public function RedrawWorld():void{
			GFX.removeChild(GFXW1)
			GFX.removeChild(GFXW3)
			var czop:uint=Mario.levelid<16?Math.floor(Mario.levelid/4)+1:4
			var GFXclass:Class
			GFXclass=Mario.classGFX.AccessGFX("font_"+czop);
			GFXW1=new GFXclass;
			GFXW1.x=214;
			GFXW1.y=35;
			GFX.addChild(GFXW1);
			czop=Mario.levelid<16?Mario.levelid%4+1:5
			GFXclass=Mario.classGFX.AccessGFX("font_"+czop);
			GFXW3=new GFXclass;
			GFXW3.x=238;
			GFXW3.y=35;
			GFX.addChild(GFXW3);
		}
		public function Hud():Sprite{
			return GFX;
		}
	}

}