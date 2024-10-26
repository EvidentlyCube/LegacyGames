package Classes.Items{
	import Classes.GFX;
	import Classes.Interactivers.TCrate;
	import Classes.Interactivers.TCrateSteel;
	import Classes.Interactivers.TIceCrate;
	import Classes.Interactivers.TIceCrateSteel;
	import Classes.Interactivers.TObject;
	import Classes.SFX;
	import Classes.Scenes.TLevelScene;
	import Classes.TLevel;

	import mx.core.BitmapAsset;
	public class TDropper extends TItem	{
		[Embed("../../../assets/gfx/gameplay/Dropper.png")] public static var g_0:Class;
		public function TDropper(_x:uint,_y:uint){
			x=_x
			y=_y
			addChild(new g_0)
			Game.layerItems.addChild(this)
		}
		override public function Stomp(who:TObject):void{
			if(who.F_canFall){
				TLevelScene.killedObject(who)
				who.Fall(this)
			}
		}
		override public function Remove():void{
			Game.layerItems.removeChild(this)
		}
		public function Fill(who:TObject):void{
			TLevel.Remove(x,y)
			var b:BitmapAsset
			if (who as TCrate){
				b = new (GFX.f_65)
			} else if(who as TCrateSteel){
				b = new (GFX.f_66)
			} else if(who as TIceCrate){
				b = new (GFX.f_68)
			} else if(who as TIceCrateSteel){
				b = new (GFX.f_67)
			}
			b.x = x
			b.y = y
			Game.layerFloor.addChild(b)
			SFX.Play("crate fall")
		}
	}
}