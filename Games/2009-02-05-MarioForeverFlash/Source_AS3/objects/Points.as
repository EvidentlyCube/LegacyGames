package objects {
	import flash.display.*;
	import mx.core.BitmapAsset;
	public class Points extends Effect {
		private var fY:int;
		private var GFX:BitmapAsset;
		public function Points(oX:Number,oY:Number,numb:String){
			fY=oY;
			var GFXclass:Class=Mario.classGFX.AccessGFX("effect_points_"+numb);
			GFX=new GFXclass;
			GFX.x=Math.floor(oX-GFX.width/2);
			GFX.y=fY;
			Mario.layerEffects.addChild(GFX);
			timer=120;
			switch(numb){
				case("100"):
					Mario.Hud.Pnts+=100;
					Mario.Hud.RedrawPnts();
					break;
				case("200"):
					Mario.Hud.Pnts+=200;
					Mario.Hud.RedrawPnts();
					break;
				case("500"):
					Mario.Hud.Pnts+=500;
					Mario.Hud.RedrawPnts();
					break;
				case("1000"):
					Mario.Hud.Pnts+=1000;
					Mario.Hud.RedrawPnts();
					break;
				case("2000"):
					Mario.Hud.Pnts+=2000;
					Mario.Hud.RedrawPnts();
					break;
				case("5000"):
					Mario.Hud.Pnts+=5000;
					Mario.Hud.RedrawPnts();
					break;
				case("8000"):
					Mario.Hud.Pnts+=8000;
					Mario.Hud.RedrawPnts();
					break;
				case("1up"):
					Mario.Hud.Lives++;
					Mario.Hud.RedrawPnts();
					break;
			}
		}
		override public function Update(myID:uint):void{
			fY-=1;
			timer--;
			GFX.y=fY;
			GFX.alpha=timer/30;
			if (timer==0){
				Mario.removeEffect(myID);
				Mario.layerEffects.removeChild(GFX);
			}
		}
	}
	
}