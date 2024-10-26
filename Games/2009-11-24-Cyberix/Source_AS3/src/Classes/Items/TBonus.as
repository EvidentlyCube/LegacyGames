package Classes.Items
{
	import Classes.Interactivers.TObject;
	import Classes.Loading;
	import Classes.Menu.TAchievementsPanel;
	import Classes.SFX;
	import Classes.Scenes.TLevelScene;
	import Classes.TLevel;

	public class TBonus extends TItem{
		[Embed("../../../assets/gfx/gameplay/Bonus00.png")] public static var g_00:Class;
		[Embed("../../../assets/gfx/gameplay/Bonus01.png")] public static var g_01:Class;
		[Embed("../../../assets/gfx/gameplay/Bonus02.png")] public static var g_02:Class;
		[Embed("../../../assets/gfx/gameplay/Bonus03.png")] public static var g_03:Class;
		[Embed("../../../assets/gfx/gameplay/Bonus04.png")] public static var g_04:Class;
		[Embed("../../../assets/gfx/gameplay/Bonus05.png")] public static var g_05:Class;
		[Embed("../../../assets/gfx/gameplay/Bonus06.png")] public static var g_06:Class;
		[Embed("../../../assets/gfx/gameplay/Bonus07.png")] public static var g_07:Class;
		[Embed("../../../assets/gfx/gameplay/Bonus08.png")] public static var g_08:Class;
		[Embed("../../../assets/gfx/gameplay/Bonus09.png")] public static var g_09:Class;
		[Embed("../../../assets/gfx/gameplay/Bonus10.png")] public static var g_10:Class;
		[Embed("../../../assets/gfx/gameplay/Bonus11.png")] public static var g_11:Class;
		[Embed("../../../assets/gfx/gameplay/Bonus12.png")] public static var g_12:Class;
		[Embed("../../../assets/gfx/gameplay/Bonus13.png")] public static var g_13:Class;
		[Embed("../../../assets/gfx/gameplay/Bonus14.png")] public static var g_14:Class;
		[Embed("../../../assets/gfx/gameplay/Bonus15.png")] public static var g_15:Class;
		[Embed("../../../assets/gfx/gameplay/Bonus16.png")] public static var g_16:Class;
		[Embed("../../../assets/gfx/gameplay/Bonus17.png")] public static var g_17:Class;
		[Embed("../../../assets/gfx/gameplay/Bonus18.png")] public static var g_18:Class;
		[Embed("../../../assets/gfx/gameplay/Bonus19.png")] public static var g_19:Class;

		public function TBonus(_x:uint,_y:uint,_g:uint){
			x=_x
			y=_y
			switch(_g){
				case(140):addChild(new g_00);break;
				case(141):addChild(new g_01);break;
				case(142):addChild(new g_02);break;
				case(143):addChild(new g_03);break;
				case(144):addChild(new g_04);break;
				case(145):addChild(new g_05);break;
				case(146):addChild(new g_06);break;
				case(147):addChild(new g_07);break;
				case(148):addChild(new g_08);break;
				case(149):addChild(new g_09);break;
				case(150):addChild(new g_10);break;
				case(151):addChild(new g_11);break;
				case(152):addChild(new g_12);break;
				case(153):addChild(new g_13);break;
				case(154):addChild(new g_14);break;
				case(155):addChild(new g_15);break;
				case(156):addChild(new g_16);break;
				case(157):addChild(new g_17);break;
				case(158):addChild(new g_18);break;
				case(159):addChild(new g_19);break;
			}
			Game.layerItems.addChild(this)
			TLevel.fruits++
		}
		override public function Stomp(who:TObject):void{
			if (!who.F_collectsBonuses){return}
			TLevel.Remove(x,y)
			SFX.Play("eat")
			if (TLevel.fruits == 0 && Game.curScene is TLevelScene){
				SFX.Play("unlock")
			}
			TAchievementsPanel.recordEatingItem();
		}
		override public function Remove():void{
			TLevel.fruits--
			Game.layerItems.removeChild(this)
		}
	}
}
