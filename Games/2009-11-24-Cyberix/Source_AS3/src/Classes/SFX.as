package Classes{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	public class SFX{
		[Embed("../../assets/sfx/arrow1.mp3")] private var arrow_0:Class;
		[Embed("../../assets/sfx/arrow2.mp3")] private var arrow_1:Class;
		[Embed("../../assets/sfx/arrow3.mp3")] private var arrow_2:Class;
		[Embed("../../assets/sfx/arrow4.mp3")] private var arrow_3:Class;
		[Embed("../../assets/sfx/arrow5.mp3")] private var arrow_4:Class;
		[Embed("../../assets/sfx/bounce1.mp3")] private var bounce_0:Class;
		[Embed("../../assets/sfx/bounce2.mp3")] private var bounce_1:Class;
		[Embed("../../assets/sfx/bounce3.mp3")] private var bounce_2:Class;
		[Embed("../../assets/sfx/bounce4.mp3")] private var bounce_3:Class;
		[Embed("../../assets/sfx/bounce5.mp3")] private var bounce_4:Class;
		[Embed("../../assets/sfx/bounceB1.mp3")] private var bounce_b0:Class;
		[Embed("../../assets/sfx/bounceB2.mp3")] private var bounce_b1:Class;
		[Embed("../../assets/sfx/bounceB3.mp3")] private var bounce_b2:Class;
		[Embed("../../assets/sfx/bounceB4.mp3")] private var bounce_b3:Class;
		[Embed("../../assets/sfx/bounceB5.mp3")] private var bounce_b4:Class;
		[Embed("../../assets/sfx/bullet1.mp3")] private var bullet_0:Class;
		[Embed("../../assets/sfx/bullet2.mp3")] private var bullet_1:Class;
		[Embed("../../assets/sfx/bullet3.mp3")] private var bullet_2:Class;
		[Embed("../../assets/sfx/bullet4.mp3")] private var bullet_3:Class;
		[Embed("../../assets/sfx/bullet5.mp3")] private var bullet_4:Class;
		[Embed("../../assets/sfx/cannon1.mp3")] private var cannon_0:Class;
		[Embed("../../assets/sfx/cannon2.mp3")] private var cannon_1:Class;
		[Embed("../../assets/sfx/cannon3.mp3")] private var cannon_2:Class;
		[Embed("../../assets/sfx/cannon4.mp3")] private var cannon_3:Class;
		[Embed("../../assets/sfx/cannon5.mp3")] private var cannon_4:Class;
		[Embed("../../assets/sfx/cannon_die.mp3")] private var cannon_die:Class;
		[Embed("../../assets/sfx/completed.mp3")] private var completed:Class;
		[Embed("../../assets/sfx/crate_fall_1.mp3")] private var crate_fall_0:Class;
		[Embed("../../assets/sfx/crate_push_1.mp3")] private var crate_push_0:Class;
		[Embed("../../assets/sfx/crate_push_2.mp3")] private var crate_push_1:Class;
		[Embed("../../assets/sfx/crate_push_3.mp3")] private var crate_push_2:Class;
		[Embed("../../assets/sfx/crate_push_4.mp3")] private var crate_push_3:Class;
		[Embed("../../assets/sfx/crate_push_5.mp3")] private var crate_push_4:Class;
		[Embed("../../assets/sfx/eat1.mp3")] private var eat_0:Class;
		[Embed("../../assets/sfx/eat2.mp3")] private var eat_1:Class;
		[Embed("../../assets/sfx/eat3.mp3")] private var eat_2:Class;
		[Embed("../../assets/sfx/eat4.mp3")] private var eat_3:Class;
		[Embed("../../assets/sfx/eat5.mp3")] private var eat_4:Class;
		[Embed("../../assets/sfx/eat6.mp3")] private var eat_5:Class;
		[Embed("../../assets/sfx/explosion1.mp3")] private var explosion_0:Class;
		[Embed("../../assets/sfx/explosion2.mp3")] private var explosion_1:Class;
		[Embed("../../assets/sfx/explosion3.mp3")] private var explosion_2:Class;
		[Embed("../../assets/sfx/explosion4.mp3")] private var explosion_3:Class;
		[Embed("../../assets/sfx/kill_player_0.mp3")] private var kill_player_0:Class;
		[Embed("../../assets/sfx/kill_player_1.mp3")] private var kill_player_1:Class;
		[Embed("../../assets/sfx/kill_player_2.mp3")] private var kill_player_2:Class;
		[Embed("../../assets/sfx/kill_player_B0.mp3")] private var kill_player_b0:Class;
		[Embed("../../assets/sfx/menu_click_2.mp3")] private var menu_click_2:Class;
		[Embed("../../assets/sfx/menu_hover_2.mp3")] private var menu_hover_2:Class;
		[Embed("../../assets/sfx/stopper1.mp3")] private var stopper_0:Class;
		[Embed("../../assets/sfx/stopper2.mp3")] private var stopper_1:Class;
		[Embed("../../assets/sfx/stopper3.mp3")] private var stopper_2:Class;
		[Embed("../../assets/sfx/stopper4.mp3")] private var stopper_3:Class;
		[Embed("../../assets/sfx/stopper5.mp3")] private var stopper_4:Class;
		[Embed("../../assets/sfx/switch1.mp3")] private var switch_0:Class;
		[Embed("../../assets/sfx/switch2.mp3")] private var switch_1:Class;
		[Embed("../../assets/sfx/switch3.mp3")] private var switch_2:Class;
		[Embed("../../assets/sfx/switch4.mp3")] private var switch_3:Class;
		[Embed("../../assets/sfx/switch5.mp3")] private var switch_4:Class;
		[Embed("../../assets/sfx/teleport1.mp3")] private var teleport_0:Class;
		[Embed("../../assets/sfx/teleport2.mp3")] private var teleport_1:Class;
		[Embed("../../assets/sfx/teleport3.mp3")] private var teleport_2:Class;
		[Embed("../../assets/sfx/teleport4.mp3")] private var teleport_3:Class;
		[Embed("../../assets/sfx/teleport5.mp3")] private var teleport_4:Class;
		[Embed("../../assets/sfx/turnwall1.mp3")] private var turnwall_0:Class;
		[Embed("../../assets/sfx/turnwall2.mp3")] private var turnwall_1:Class;
		[Embed("../../assets/sfx/turnwall3.mp3")] private var turnwall_2:Class;
		[Embed("../../assets/sfx/turnwall4.mp3")] private var turnwall_3:Class;
		[Embed("../../assets/sfx/turnwall5.mp3")] private var turnwall_4:Class;
		[Embed("../../assets/sfx/unlock.mp3")] private var unlock:Class;
		[Embed("../../assets/sfx/wall1.mp3")] private var wall_0:Class;
		[Embed("../../assets/sfx/wall2.mp3")] private var wall_1:Class;
		[Embed("../../assets/sfx/wall3.mp3")] private var wall_2:Class;
		[Embed("../../assets/sfx/wall4.mp3")] private var wall_3:Class;
		[Embed("../../assets/sfx/wall5.mp3")] private var wall_4:Class;
		[Embed("../../assets/sfx/waller1.mp3")] private var waller_0:Class;
		[Embed("../../assets/sfx/waller2.mp3")] private var waller_1:Class;
		[Embed("../../assets/sfx/waller3.mp3")] private var waller_2:Class;
		[Embed("../../assets/sfx/waller4.mp3")] private var waller_3:Class;
		[Embed("../../assets/sfx/waller5.mp3")] private var waller_4:Class;
		[Embed("../../assets/music/gldist/GlDist_by_Glitch.mp3")] private var music_1:Class;
		[Embed("../../assets/music/biofuroxyne/biofuroxyne_by_bionic.mp3")] private var music_2:Class;
		[Embed("../../assets/music/chillnrelax/ChillNRelax_by_Chromag.mp3")] private var music_3:Class;
		private static var ARROW_00:Sound;
		private static var ARROW_01:Sound;
		private static var ARROW_02:Sound;
		private static var ARROW_03:Sound;
		private static var ARROW_04:Sound;
		private static var BOUNCE_00:Sound;
		private static var BOUNCE_01:Sound;
		private static var BOUNCE_02:Sound;
		private static var BOUNCE_03:Sound;
		private static var BOUNCE_04:Sound;
		private static var BOUNCE_10:Sound;
		private static var BOUNCE_11:Sound;
		private static var BOUNCE_12:Sound;
		private static var BOUNCE_13:Sound;
		private static var BOUNCE_14:Sound;
		private static var BULLET_00:Sound;
		private static var BULLET_01:Sound;
		private static var BULLET_02:Sound;
		private static var BULLET_03:Sound;
		private static var BULLET_04:Sound;
		private static var CANNON_00:Sound;
		private static var CANNON_01:Sound;
		private static var CANNON_02:Sound;
		private static var CANNON_03:Sound;
		private static var CANNON_04:Sound;
		private static var CANNON_DIE:Sound;
		private static var COMPLETED:Sound;
		private static var CRATE_FALL_00:Sound;
		private static var CRATE_PUSH_00:Sound;
		private static var CRATE_PUSH_01:Sound;
		private static var CRATE_PUSH_02:Sound;
		private static var CRATE_PUSH_03:Sound;
		private static var CRATE_PUSH_04:Sound;
		private static var EAT_00:Sound;
		private static var EAT_01:Sound;
		private static var EAT_02:Sound;
		private static var EAT_03:Sound;
		private static var EAT_04:Sound;
		private static var EAT_05:Sound;
		private static var EXPLOSION_00:Sound;
		private static var EXPLOSION_01:Sound;
		private static var EXPLOSION_02:Sound;
		private static var EXPLOSION_03:Sound;
		private static var KILL_PLAYER_00:Sound;
		private static var KILL_PLAYER_01:Sound;
		private static var KILL_PLAYER_02:Sound;
		private static var KILL_PLAYER_10:Sound;
		private static var MENU_CLICK_1:Sound;
		private static var MENU_CLICK_2:Sound;
		private static var MENU_HOVER_1:Sound;
		private static var MENU_HOVER_2:Sound;
		private static var STOPPER_00:Sound;
		private static var STOPPER_01:Sound;
		private static var STOPPER_02:Sound;
		private static var STOPPER_03:Sound;
		private static var STOPPER_04:Sound;
		private static var SWITCH_00:Sound;
		private static var SWITCH_01:Sound;
		private static var SWITCH_02:Sound;
		private static var SWITCH_03:Sound;
		private static var SWITCH_04:Sound;
		private static var TELEPORT_00:Sound;
		private static var TELEPORT_01:Sound;
		private static var TELEPORT_02:Sound;
		private static var TELEPORT_03:Sound;
		private static var TELEPORT_04:Sound;
		private static var TURNWALL_00:Sound;
		private static var TURNWALL_01:Sound;
		private static var TURNWALL_02:Sound;
		private static var TURNWALL_03:Sound;
		private static var TURNWALL_04:Sound;
		private static var UNLOCK:Sound;
		private static var WALL_00:Sound;
		private static var WALL_01:Sound;
		private static var WALL_02:Sound;
		private static var WALL_03:Sound;
		private static var WALL_04:Sound;
		private static var WALLER_00:Sound;
		private static var WALLER_01:Sound;
		private static var WALLER_02:Sound;
		private static var WALLER_03:Sound;
		private static var WALLER_04:Sound;
		private static var MUSIC_1:Sound
		private static var MUSIC_2:Sound
		private static var MUSIC_3:Sound
		private static var mid:uint = 0
		private static var sch:SoundChannel
		public static var mus:Boolean = true
		public static var sfx:Boolean = true
		public function SFX(){
			ARROW_00 = new arrow_0
			ARROW_01 = new arrow_1
			ARROW_02 = new arrow_2
			ARROW_03 = new arrow_3
			ARROW_04 = new arrow_4
			BOUNCE_00 = new bounce_0
			BOUNCE_01 = new bounce_1
			BOUNCE_02 = new bounce_2
			BOUNCE_03 = new bounce_3
			BOUNCE_04 = new bounce_4
			BOUNCE_10 = new bounce_b0
			BOUNCE_11 = new bounce_b1
			BOUNCE_12 = new bounce_b2
			BOUNCE_13 = new bounce_b3
			BOUNCE_14 = new bounce_b4
			BULLET_00 = new bullet_0
			BULLET_01 = new bullet_1
			BULLET_02 = new bullet_2
			BULLET_03 = new bullet_3
			BULLET_04 = new bullet_4
			CANNON_00 = new cannon_0
			CANNON_01 = new cannon_1
			CANNON_02 = new cannon_2
			CANNON_03 = new cannon_3
			CANNON_04 = new cannon_4
			CANNON_DIE = new cannon_die
			COMPLETED = new completed
			CRATE_FALL_00 = new crate_fall_0
			CRATE_PUSH_00 = new crate_push_0
			CRATE_PUSH_01 = new crate_push_1
			CRATE_PUSH_02 = new crate_push_2
			CRATE_PUSH_03 = new crate_push_3
			CRATE_PUSH_04 = new crate_push_4
			EAT_00 = new eat_0
			EAT_01 = new eat_1
			EAT_02 = new eat_2
			EAT_03 = new eat_3
			EAT_04 = new eat_4
			EAT_05 = new eat_5
			EXPLOSION_00 = new explosion_0
			EXPLOSION_01 = new explosion_1
			EXPLOSION_02 = new explosion_2
			EXPLOSION_03 = new explosion_3
			KILL_PLAYER_00 = new kill_player_0
			KILL_PLAYER_01 = new kill_player_1
			KILL_PLAYER_02 = new kill_player_2
			KILL_PLAYER_10 = new kill_player_b0
			MENU_CLICK_1 = new (Loading.menu_click_1)
			MENU_CLICK_2 = new menu_click_2
			MENU_HOVER_1 = new (Loading.menu_hover_1)
			MENU_HOVER_2 = new menu_hover_2
			STOPPER_00 = new stopper_0
			STOPPER_01 = new stopper_1
			STOPPER_02 = new stopper_2
			STOPPER_03 = new stopper_3
			STOPPER_04 = new stopper_4
			SWITCH_00 = new switch_0
			SWITCH_01 = new switch_1
			SWITCH_02 = new switch_2
			SWITCH_03 = new switch_3
			SWITCH_04 = new switch_4
			TELEPORT_00 = new teleport_0
			TELEPORT_01 = new teleport_1
			TELEPORT_02 = new teleport_2
			TELEPORT_03 = new teleport_3
			TELEPORT_04 = new teleport_4
			TURNWALL_00 = new turnwall_0
			TURNWALL_01 = new turnwall_1
			TURNWALL_02 = new turnwall_2
			TURNWALL_03 = new turnwall_3
			TURNWALL_04 = new turnwall_4
			UNLOCK = new unlock
			WALL_00 = new wall_0
			WALL_01 = new wall_1
			WALL_02 = new wall_2
			WALL_03 = new wall_3
			WALL_04 = new wall_4
			WALLER_00 = new waller_0
			WALLER_01 = new waller_1
			WALLER_02 = new waller_2
			WALLER_03 = new waller_3
			WALLER_04 = new waller_4

			MUSIC_1 = new music_1
			MUSIC_2 = new music_2
			MUSIC_3 = new music_3
		}
		public static function Step():void{
			if (sch){
				if (!mus){
					sch.stop()
					sch.removeEventListener(Event.SOUND_COMPLETE,compl)
					sch = null
				}
			} else {
				if (mus){
					switch(mid){
						case(0):sch = MUSIC_1.play();break;
						case(1):sch = MUSIC_2.play();break;
						case(2):sch = MUSIC_3.play();break;
					}
					mid++
					sch.addEventListener(Event.SOUND_COMPLETE,compl,false,0,true)
					if (mid == 3){mid = 0}
				}
			}
		}
		private static function compl(e:Event):void{
			sch.removeEventListener(Event.SOUND_COMPLETE,compl)
			sch = null
		}
		public static function Play(type:String):void{
			if (!sfx){return}
			switch(type.toLowerCase()){
				case("arrow"):
					switch(Math.floor(Math.random() * 5)){
						case(0):ARROW_00.play();break;
						case(1):ARROW_01.play();break;
						case(2):ARROW_02.play();break;
						case(3):ARROW_03.play();break;
						case(4):ARROW_04.play();break;
					}
					break;
				case("bounce"):
					switch(Math.floor(Math.random() * 5)){
						case(0):BOUNCE_00.play();break;
						case(1):BOUNCE_01.play();break;
						case(2):BOUNCE_02.play();break;
						case(3):BOUNCE_03.play();break;
						case(4):BOUNCE_04.play();break;
					}
					break;
				case("bounce2"):
					switch(Math.floor(Math.random() * 5)){
						case(0):BOUNCE_10.play();break;
						case(1):BOUNCE_11.play();break;
						case(2):BOUNCE_12.play();break;
						case(3):BOUNCE_13.play();break;
						case(4):BOUNCE_14.play();break;
					}
					break;
				case("bullet"):
					switch(Math.floor(Math.random() * 5)){
						case(0):BULLET_00.play();break;
						case(1):BULLET_01.play();break;
						case(2):BULLET_02.play();break;
						case(3):BULLET_03.play();break;
						case(4):BULLET_04.play();break;
					}
					break;
				case("cannon"):
					switch(Math.floor(Math.random() * 5)){
						case(0):CANNON_00.play();break;
						case(1):CANNON_01.play();break;
						case(2):CANNON_02.play();break;
						case(3):CANNON_03.play();break;
						case(4):CANNON_04.play();break;
					}
					break;
				case("completed"):
					COMPLETED.play();
					break;
				case("crate fall"):
					switch(Math.floor(Math.random() * 1)){
						case(0):CRATE_FALL_00.play();break;
					}
					break;
				case("crate push"):
					switch(Math.floor(Math.random() * 1)){
						case(0):CRATE_PUSH_00.play();break;
						case(1):CRATE_PUSH_01.play();break;
						case(2):CRATE_PUSH_02.play();break;
						case(3):CRATE_PUSH_03.play();break;
						case(4):CRATE_PUSH_04.play();break;
					}
					break;
				case("cannon die"):
					CANNON_DIE.play()
					break;
				case("eat"):
					switch(Math.floor(Math.random() * 6)){
						case(0):EAT_03.play();break;
						case(1):EAT_04.play();break;
						case(2):EAT_05.play();break;
						case(3):EAT_03.play();break;
						case(4):EAT_04.play();break;
						case(5):EAT_05.play();break;
					}
					break;
				case("explosion"):
					switch(Math.floor(Math.random() * 4)){
						case(0):EXPLOSION_00.play();break;
						case(1):EXPLOSION_01.play();break;
						case(2):EXPLOSION_02.play();break;
						case(3):EXPLOSION_03.play();break;
					}
					break;
				case("kill player"):
					switch(Math.floor(Math.random() * 3)){
						case(0):KILL_PLAYER_00.play();break;
						case(1):KILL_PLAYER_01.play();break;
						case(2):KILL_PLAYER_02.play();break;
					}
					break;
				case("kill player 2"):
					switch(Math.floor(Math.random() * 1)){
						case(0):KILL_PLAYER_10.play();break;
					}
					break;
				case("menu click"):
				case("menu click 1"):
					MENU_CLICK_1.play()
					break;
				case("menu click 2"):
					MENU_CLICK_2.play()
					break;
				case("menu hover"):
				case("menu hover 1"):
					MENU_HOVER_1.play()
					break;
				case("menu hover 2"):
					MENU_HOVER_2.play()
					break;
				case("stopper"):
					switch(Math.floor(Math.random() * 5)){
						case(0):STOPPER_00.play();break;
						case(1):STOPPER_01.play();break;
						case(2):STOPPER_02.play();break;
						case(3):STOPPER_03.play();break;
						case(4):STOPPER_04.play();break;
					}
					break;
				case("switch"):
					switch(Math.floor(Math.random() * 5)){
						case(0):SWITCH_00.play();break;
						case(1):SWITCH_01.play();break;
						case(2):SWITCH_02.play();break;
						case(3):SWITCH_03.play();break;
						case(4):SWITCH_04.play();break;
					}
					break;
				case("teleport"):
					switch(Math.floor(Math.random() * 5)){
						case(0):TELEPORT_00.play();break;
						case(1):TELEPORT_01.play();break;
						case(2):TELEPORT_02.play();break;
						case(3):TELEPORT_03.play();break;
						case(4):TELEPORT_04.play();break;
					}
					break;
				case("turnwall"):
					switch(Math.floor(Math.random() * 5)){
						case(0):TURNWALL_00.play();break;
						case(1):TURNWALL_01.play();break;
						case(2):TURNWALL_02.play();break;
						case(3):TURNWALL_03.play();break;
						case(4):TURNWALL_04.play();break;
					}
					break;
				case("unlock"):
					UNLOCK.play();
					break;
				case("wall"):
					switch(Math.floor(Math.random() * 5)){
						case(0):WALL_00.play();break;
						case(1):WALL_01.play();break;
						case(2):WALL_02.play();break;
						case(3):WALL_03.play();break;
						case(4):WALL_04.play();break;
					}
					break;
				case("waller"):
					switch(Math.floor(Math.random() * 5)){
						case(0):WALLER_00.play();break;
						case(1):WALLER_01.play();break;
						case(2):WALLER_02.play();break;
						case(3):WALLER_03.play();break;
						case(4):WALLER_04.play();break;
					}
					break;
			}
		}
	}
}