package Classes.Items{
	import Classes.Interactivers.TObject;
	import Classes.SFX;
	import Classes.TLevel;
	public class TButtonItem extends TItem{
		public var itemX:uint
		public var itemY:uint
		public var itemC:TItem
		public var red:Boolean = false
		public function TButtonItem(_x:uint,_y:uint,_ix:uint,_iy:uint,_ic:uint){
			x=_x
			x
			y=_y
			itemX=_ix
			itemY=_iy
			switch(_ic){
				case(160):	itemC = new TExit(itemX,itemY);break;
				case(161):	itemC = new TStopper(itemX,itemY);break;
				case(162):	itemC = new TBouncerH(itemX,itemY,0);break;
				case(163):	itemC = new TBouncerH(itemX,itemY,1);break;
				case(164):	itemC = new TBouncerV(itemX,itemY,0);break;
				case(165):	itemC = new TBouncerV(itemX,itemY,1);break;
				case(166):	itemC = new TBouncerD(itemX,itemY,0);break;
				case(167):	itemC = new TBouncerD(itemX,itemY,1);break;
				case(168):	itemC = new TCannon(itemX,itemY,0);break;
				case(169):	itemC = new TCannon(itemX,itemY,1);break;
				case(170):	itemC = new TCannon(itemX,itemY,2);break;
				case(171):	itemC = new TCannon(itemX,itemY,3);break;
				case(172):	itemC = new TMine(itemX,itemY);break;
				case(176):	itemC = new TArrow(itemX,itemY,0);break;
				case(177):	itemC = new TArrow(itemX,itemY,1);break;
				case(178):	itemC = new TArrow(itemX,itemY,2);break;
				case(179):	itemC = new TArrow(itemX,itemY,3);break;
				case(180):	itemC = new TArrow(itemX,itemY,4);break;
				case(181):	itemC = new TArrow(itemX,itemY,5);break;
				case(182):	itemC = new TArrow(itemX,itemY,6);break;
				case(183):	itemC = new TArrow(itemX,itemY,7);break;
				case(184):	itemC = new TArrow(itemX,itemY,8);break;
				case(185):	itemC = new TArrow(itemX,itemY,9);break;
				case(187):	itemC = new TWallPierced(itemX,itemY,0);break;
				case(188):	itemC = new TWallPierced(itemX,itemY,1);break;
				case(189):	itemC = new TWallPierced(itemX,itemY,2);break;
				case(190):	itemC = new TRounder(itemX,itemY,0);break;
				case(191):	itemC = new TRounder(itemX,itemY,1);break;
				case(192):	itemC = new TDropper(itemX,itemY);break;
				default:
					if (_ic > 70 && _ic < 130){
						itemC = new TWall(itemX,itemY,_ic)
					}
					break
			}
			if (itemC != null){
				itemC.Fold(true)
			}

			addChild(new TButtonShot.g_0)

			Game.layerItems.addChild(this)
		}
		override public function Stomp(who:TObject):void{
			if (!who.stomps || !who.F_hitsButtons){return;}
			SFX.Play("switch")
			var item:TItem = TLevel.checkAt(itemX,itemY)
			TLevel.Set(itemX,itemY,itemC,false)
			if (itemC != null){itemC.Unfold()}
			itemC = item
			if (itemC != null){itemC.Fold()}
			Swap()
		}

		public function Swap():void{
			if (red){
				removeChildAt(0)
				addChild(new TButtonShot.g_0)
				red = false
			} else {
				removeChildAt(0)
				addChild(new TButtonShot.g_1)
				red = true
			}
		}

		override public function Remove():void{
			Game.layerItems.removeChild(this)
		}
	}
}