package Classes.Items{
	import Classes.Interactivers.*;
	import Classes.SFX;

	import Editor.GiveClass;
	public class TWall extends TItem{
		[Embed("../../../assets/gfx/gameplay/Wall01.png")] public static var g_00:Class;
		[Embed("../../../assets/gfx/gameplay/Wall02.png")] public static var g_01:Class;
		[Embed("../../../assets/gfx/gameplay/Wall03.png")] public static var g_02:Class;
		[Embed("../../../assets/gfx/gameplay/Wall04.png")] public static var g_03:Class;
		[Embed("../../../assets/gfx/gameplay/Wall05.png")] public static var g_04:Class;
		[Embed("../../../assets/gfx/gameplay/Wall06.png")] public static var g_05:Class;
		[Embed("../../../assets/gfx/gameplay/Wall07.png")] public static var g_06:Class;
		[Embed("../../../assets/gfx/gameplay/Wall08.png")] public static var g_07:Class;
		[Embed("../../../assets/gfx/gameplay/Wall09.png")] public static var g_08:Class;
		[Embed("../../../assets/gfx/gameplay/Wall10.png")] public static var g_09:Class;
		[Embed("../../../assets/gfx/gameplay/Wall11.png")] public static var g_10:Class;
		[Embed("../../../assets/gfx/gameplay/Wall12.png")] public static var g_11:Class;
		[Embed("../../../assets/gfx/gameplay/Wall13.png")] public static var g_12:Class;
		[Embed("../../../assets/gfx/gameplay/Wall14.png")] public static var g_13:Class;
		[Embed("../../../assets/gfx/gameplay/Wall15.png")] public static var g_14:Class;
		[Embed("../../../assets/gfx/gameplay/Wall16.png")] public static var g_15:Class;
		[Embed("../../../assets/gfx/gameplay/Wall17.png")] public static var g_16:Class;
		[Embed("../../../assets/gfx/gameplay/Wall18.png")] public static var g_17:Class;
		[Embed("../../../assets/gfx/gameplay/Wall18_01.png")] public static var g_17_1:Class;
		[Embed("../../../assets/gfx/gameplay/Wall18_02.png")] public static var g_17_2:Class;
		[Embed("../../../assets/gfx/gameplay/Wall18_03.png")] public static var g_17_3:Class;
		[Embed("../../../assets/gfx/gameplay/Wall18_04.png")] public static var g_17_4:Class;
		[Embed("../../../assets/gfx/gameplay/Wall18_05.png")] public static var g_17_5:Class;
		[Embed("../../../assets/gfx/gameplay/Wall18_06.png")] public static var g_17_6:Class;
		[Embed("../../../assets/gfx/gameplay/Wall18_07.png")] public static var g_17_7:Class;
		[Embed("../../../assets/gfx/gameplay/Wall19.png")] public static var g_18:Class;
		[Embed("../../../assets/gfx/gameplay/Wall20.png")] public static var g_19:Class;
		[Embed("../../../assets/gfx/gameplay/Wall21.png")] public static var g_20:Class;
		[Embed("../../../assets/gfx/gameplay/Wall22.png")] public static var g_21:Class;
		[Embed("../../../assets/gfx/gameplay/Wall23.png")] public static var g_22:Class;
		[Embed("../../../assets/gfx/gameplay/Wall24.png")] public static var g_23:Class;
		[Embed("../../../assets/gfx/gameplay/Wall25.png")] public static var g_24:Class;
		[Embed("../../../assets/gfx/gameplay/Wall26.png")] public static var g_25:Class;
		[Embed("../../../assets/gfx/gameplay/Wall27.png")] public static var g_26:Class;
		[Embed("../../../assets/gfx/gameplay/Wall28.png")] public static var g_27:Class;
		[Embed("../../../assets/gfx/gameplay/Wall29.png")] public static var g_28:Class;
		[Embed("../../../assets/gfx/gameplay/Wall30.png")] public static var g_29:Class;
		[Embed("../../../assets/gfx/gameplay/Wall31.png")] public static var g_30:Class;
		[Embed("../../../assets/gfx/gameplay/Wall32.png")] public static var g_31:Class;
		[Embed("../../../assets/gfx/gameplay/Wall33.png")] public static var g_32:Class;
		[Embed("../../../assets/gfx/gameplay/Wall34.png")] public static var g_33:Class;
		[Embed("../../../assets/gfx/gameplay/Wall35.png")] public static var g_34:Class;
		[Embed("../../../assets/gfx/gameplay/Wall36.png")] public static var g_35:Class;
		[Embed("../../../assets/gfx/gameplay/Wall37.png")] public static var g_36:Class;
		[Embed("../../../assets/gfx/gameplay/Wall38.png")] public static var g_37:Class;
		[Embed("../../../assets/gfx/gameplay/Wall39.png")] public static var g_38:Class;
		[Embed("../../../assets/gfx/gameplay/Wall40.png")] public static var g_39:Class;
		[Embed("../../../assets/gfx/gameplay/Wall41.png")] public static var g_40:Class;
		[Embed("../../../assets/gfx/gameplay/Wall41_01.png")] public static var g_40_1:Class;
		[Embed("../../../assets/gfx/gameplay/Wall41_02.png")] public static var g_40_2:Class;
		[Embed("../../../assets/gfx/gameplay/Wall41_03.png")] public static var g_40_3:Class;
		[Embed("../../../assets/gfx/gameplay/Wall42.png")] public static var g_41:Class;
		[Embed("../../../assets/gfx/gameplay/Wall42_01.png")] public static var g_41_1:Class;
		[Embed("../../../assets/gfx/gameplay/Wall42_02.png")] public static var g_41_2:Class;
		[Embed("../../../assets/gfx/gameplay/Wall42_03.png")] public static var g_41_3:Class;
		[Embed("../../../assets/gfx/gameplay/Wall43.png")] public static var g_42:Class;
		[Embed("../../../assets/gfx/gameplay/Wall44.png")] public static var g_43:Class;
		[Embed("../../../assets/gfx/gameplay/Wall45.png")] public static var g_44:Class;
		[Embed("../../../assets/gfx/gameplay/Wall46.png")] public static var g_45:Class;
		[Embed("../../../assets/gfx/gameplay/Wall47.png")] public static var g_46:Class;
		[Embed("../../../assets/gfx/gameplay/Wall48.png")] public static var g_47:Class;
		[Embed("../../../assets/gfx/gameplay/Wall49.png")] public static var g_48:Class;
		[Embed("../../../assets/gfx/gameplay/Wall50.png")] public static var g_49:Class;
		[Embed("../../../assets/gfx/gameplay/Wall51.png")] public static var g_50:Class;
		[Embed("../../../assets/gfx/gameplay/Wall52.png")] public static var g_51:Class;
		[Embed("../../../assets/gfx/gameplay/Wall53.png")] public static var g_52:Class;
		[Embed("../../../assets/gfx/gameplay/Wall54.png")] public static var g_53:Class;
		[Embed("../../../assets/gfx/gameplay/Wall55.png")] public static var g_54:Class;
		[Embed("../../../assets/gfx/gameplay/Wall56.png")] public static var g_55:Class;
		[Embed("../../../assets/gfx/gameplay/Wall57.png")] public static var g_56:Class;
		[Embed("../../../assets/gfx/gameplay/Wall58.png")] public static var g_57:Class;
		[Embed("../../../assets/gfx/gameplay/Wall59.png")] public static var g_58:Class;
		[Embed("../../../assets/gfx/gameplay/Wall60.png")] public static var g_59:Class;
		[Embed("../../../assets/gfx/gameplay/Wall61.png")] public static var g_60:Class;
		[Embed("../../../assets/gfx/gameplay/Wall61_01.png")] public static var g_60_1:Class;
		[Embed("../../../assets/gfx/gameplay/Wall61_02.png")] public static var g_60_2:Class;
		[Embed("../../../assets/gfx/gameplay/Wall61_03.png")] public static var g_60_3:Class;
		[Embed("../../../assets/gfx/gameplay/Wall62.png")] public static var g_61:Class;
		[Embed("../../../assets/gfx/gameplay/Wall62_01.png")] public static var g_61_1:Class;
		[Embed("../../../assets/gfx/gameplay/Wall62_02.png")] public static var g_61_2:Class;
		[Embed("../../../assets/gfx/gameplay/Wall62_03.png")] public static var g_61_3:Class;
		[Embed("../../../assets/gfx/gameplay/Wall63.png")] public static var g_62:Class;
		[Embed("../../../assets/gfx/gameplay/Wall64.png")] public static var g_63:Class;
		[Embed("../../../assets/gfx/gameplay/Wall65.png")] public static var g_64:Class;
		[Embed("../../../assets/gfx/gameplay/Wall66.png")] public static var g_65:Class;
		[Embed("../../../assets/gfx/gameplay/Wall67.png")] public static var g_66:Class;
		[Embed("../../../assets/gfx/gameplay/Wall68.png")] public static var g_67:Class;
		[Embed("../../../assets/gfx/gameplay/Wall69.png")] public static var g_68:Class;
		private var Anim:TAnimWall
		public function TWall(_x:uint,_y:uint,_gfx:uint){
			x=_x
			y=_y
			if (_gfx != 0){addChild(new (GiveClass(_gfx)))}
			switch (_gfx){
				case 88:
				case 112:
				case 111:
				case 131:
				case 132:
				Anim = new TAnimWall(_x,_y,_gfx)
				break
			}
			Game.layerItems.addChild(this)
		}
		override public function Hit(who:TObject):void{
			if (who.moveSteps > 1){SFX.Play("wall")}
			who.Stop()
		}
		override public function Remove():void{
			Game.layerItems.removeChild(this)
		}
		override public function Fold(first:Boolean = false):void{
			super.Fold()
			if (first){
				if (Anim){Anim.alpha = 0}
				alpha = 0
				return
			}
			if (Anim){
				//Anim.visible = false
				if (Anim.app != null){Anim.app.Remove()}
				Anim.app = new TItemAppear(Anim,-1)
			}
		}
		override public function Unfold():void{
			super.Unfold()
			if (Anim){
				//Anim.visible = true
				if (Anim.app != null){Anim.app.Remove()}
				Anim.app = new TItemAppear(Anim,1)
			}
		}
	}
}