package objects {
		import flash.media.Sound
		import flash.media.SoundChannel;
	/**
	* ...
	* @author Default
	*/
	public class SFX {
		public var playingMus:SoundChannel
		public var Musics:Array=new Array(6);
		[Embed(source='../../assets/sfx/BowserHit.mp3')]				private var SFX_BOWSERHIT:Class;
		[Embed(source='../../assets/sfx/DeadBowser.mp3')]				private var SFX_BOWSERKILL:Class;
		[Embed(source='../../assets/sfx/brickshatter.mp3')]			private var SFX_BRICK:Class;
		[Embed(source='../../assets/sfx/Bump.mp3')]					private var SFX_BUMP:Class;
		[Embed(source='../../assets/sfx/cannon.mp3')]					private var SFX_CANNON:Class;
		[Embed(source='../../assets/sfx/coin.mp3')]					private var SFX_COIN:Class;
		[Embed(source='../../assets/sfx/die.mp3')]					private var SFX_DEATH:Class;
		[Embed(source='../../assets/sfx/fireball.mp3')]				private var SFX_FIREBALL:Class;
		[Embed(source='../../assets/sfx/GameOver.mp3')]				private var SFX_GAMEOVER:Class;
		[Embed(source='../../assets/sfx/Growl.mp3')]					private var SFX_GROWL:Class;
		[Embed(source='../../assets/sfx/hurry.mp3')]					private var SFX_HURRY:Class;
		[Embed(source='../../assets/sfx/jump.mp3')]					private var SFX_JUMP:Class;
		[Embed(source='../../assets/sfx/kick.mp3')]					private var SFX_KICK:Class;
		[Embed(source='../../assets/music/levelcomplete.mp3')]			private var SFX_LEVEL_COMPLETE:Class;
		[Embed(source='../../assets/sfx/1up.mp3')]					private var SFX_LIFE:Class;
		[Embed(source='../../assets/sfx/Points.mp3')]					private var SFX_POINTS:Class;
		[Embed(source='../../assets/sfx/powerdown.mp3')]				private var SFX_POWERDOWN:Class;
		[Embed(source='../../assets/sfx/powerup.mp3')]				private var SFX_POWERUP:Class;
		[Embed(source='../../assets/sfx/itemsprout.mp3')]				private var SFX_SPROUT:Class;
		[Embed(source='../../assets/sfx/stomp.mp3')]					private var SFX_STOMP:Class;
		[Embed(source='../../assets/sfx/stomp2.mp3')]					private var SFX_STOMP2:Class;
		[Embed(source='../../assets/music/mus1.mp3')]					private var SFX_MUS1:Class;
		[Embed(source='../../assets/music/mus2.mp3')]					private var SFX_MUS2:Class;
		[Embed(source='../../assets/music/mus3.mp3')]					private var SFX_MUS3:Class;
		[Embed(source='../../assets/music/mus6.mp3')]					private var SFX_MUS6:Class;
		[Embed(source='../../assets/music/mus7.mp3')]					private var SFX_MUS7:Class;
		[Embed(source='../../assets/music/mus9.mp3')]					private var SFX_MUS9:Class;
		public function SFX() {
			Musics[0]=new SFX_MUS1
			Musics[1]=new SFX_MUS2
			Musics[2]=new SFX_MUS3
			Musics[5]=new SFX_MUS6
			Musics[6]=new SFX_MUS7
			Musics[8]=new SFX_MUS9
		}
		public function accessSFX(text:String):Class{
			switch(text){
				case("bowser_hit"):				return SFX_BOWSERHIT;
				case("bowser_kill"):			return SFX_BOWSERKILL;
				case("brick"):					return SFX_BRICK;
				case("bump"):					return SFX_BUMP;
				case("coin"):					return SFX_COIN;
				case("cannon"):					return SFX_CANNON;
				case("death"):					return SFX_DEATH;
				case("radish"):					return SFX_FIREBALL;
				case("gameover"):				return SFX_GAMEOVER;
				case("growl"):					return SFX_GROWL;
				case("hurry"):					return SFX_HURRY;
				case("jump"):					return SFX_JUMP;
				case("kick"):					return SFX_KICK;
				case("level_complete"):			return SFX_LEVEL_COMPLETE;
				case("life"):					return SFX_LIFE;
				case("points"):					return SFX_POINTS;
				case("powerdown"):				return SFX_POWERDOWN;
				case("powerup"):				return SFX_POWERUP;
				case("sprout"):					return SFX_SPROUT;
				case("stomp"):					return SFX_STOMP;
				case("stompduck"):				return SFX_STOMP2;
			}
			return new Class;
		}
		public function Play(music:int=-1,loops:uint=100):void{
			if (playingMus!=null){
				playingMus.stop()
			}
			if (Mario.music==false){
				return;
			}
			if (music>-1){
				playingMus=Musics[music].play(0,loops)
			}
		}
	}

}