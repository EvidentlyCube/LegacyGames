package objects
{
   import flash.media.SoundChannel;

   public class SFX
   {


      [Embed(source="../../assets/sfx/SFX_BOWSERHIT.mp3")] private var SFX_BOWSERHIT:Class;
      [Embed(source="../../assets/sfx/SFX_BOWSERKILL.mp3")] private var SFX_BOWSERKILL:Class;
      [Embed(source="../../assets/sfx/SFX_BRICK.mp3")] private var SFX_BRICK:Class;
      [Embed(source="../../assets/sfx/SFX_BUMP.mp3")] private var SFX_BUMP:Class;
      [Embed(source="../../assets/sfx/SFX_CANNON.mp3")] private var SFX_CANNON:Class;
      [Embed(source="../../assets/sfx/SFX_COIN.mp3")] private var SFX_COIN:Class;
      [Embed(source="../../assets/sfx/SFX_DEATH.mp3")] private var SFX_DEATH:Class;
      [Embed(source="../../assets/sfx/SFX_FIREBALL.mp3")] private var SFX_FIREBALL:Class;
      [Embed(source="../../assets/sfx/SFX_GAMEOVER.mp3")] private var SFX_GAMEOVER:Class;
      [Embed(source="../../assets/sfx/SFX_GROWL.mp3")] private var SFX_GROWL:Class;
      [Embed(source="../../assets/sfx/SFX_HURRY.mp3")] private var SFX_HURRY:Class;
      [Embed(source="../../assets/sfx/SFX_JUMP.mp3")] private var SFX_JUMP:Class;
      [Embed(source="../../assets/sfx/SFX_KICK.mp3")] private var SFX_KICK:Class;
      [Embed(source="../../assets/sfx/SFX_LIFE.mp3")] private var SFX_LIFE:Class;
      [Embed(source="../../assets/music/SFX_LEVEL_COMPLETE.mp3")] private var SFX_LEVEL_COMPLETE:Class;
      [Embed(source="../../assets/music/SFX_MUS1.mp3")] private var SFX_MUS1:Class;
      [Embed(source="../../assets/music/SFX_MUS2.mp3")] private var SFX_MUS2:Class;
      [Embed(source="../../assets/music/SFX_MUS3.mp3")] private var SFX_MUS3:Class;
      [Embed(source="../../assets/music/SFX_MUS6.mp3")] private var SFX_MUS6:Class;
      [Embed(source="../../assets/music/SFX_MUS7.mp3")] private var SFX_MUS7:Class;
      [Embed(source="../../assets/music/SFX_MUS9.mp3")] private var SFX_MUS9:Class;
      [Embed(source="../../assets/sfx/SFX_POINTS.mp3")] private var SFX_POINTS:Class;
      [Embed(source="../../assets/sfx/SFX_POWERDOWN.mp3")] private var SFX_POWERDOWN:Class;
      [Embed(source="../../assets/sfx/SFX_POWERUP.mp3")] private var SFX_POWERUP:Class;
      [Embed(source="../../assets/sfx/SFX_SPROUT.mp3")] private var SFX_SPROUT:Class;
      [Embed(source="../../assets/sfx/SFX_STOMP.mp3")] private var SFX_STOMP:Class;
      [Embed(source="../../assets/sfx/SFX_STOMP2.mp3")] private var SFX_STOMP2:Class;

      public var Musics:Array;
      public var playingMus:SoundChannel;

      public function SFX()
      {
         Musics = new Array(6);
         super();
         Musics[0] = new SFX_MUS1();
         Musics[1] = new SFX_MUS2();
         Musics[2] = new SFX_MUS3();
         Musics[5] = new SFX_MUS6();
         Musics[6] = new SFX_MUS7();
         Musics[8] = new SFX_MUS9();
      }

      public function accessSFX(param1:String) : Class
      {
         switch(param1)
         {
            case "bowser_hit":
               return SFX_BOWSERHIT;
            case "bowser_kill":
               return SFX_BOWSERKILL;
            case "brick":
               return SFX_BRICK;
            case "bump":
               return SFX_BUMP;
            case "coin":
               return SFX_COIN;
            case "cannon":
               return SFX_CANNON;
            case "death":
               return SFX_DEATH;
            case "radish":
               return SFX_FIREBALL;
            case "gameover":
               return SFX_GAMEOVER;
            case "growl":
               return SFX_GROWL;
            case "hurry":
               return SFX_HURRY;
            case "jump":
               return SFX_JUMP;
            case "kick":
               return SFX_KICK;
            case "level_complete":
               return SFX_LEVEL_COMPLETE;
            case "life":
               return SFX_LIFE;
            case "points":
               return SFX_POINTS;
            case "powerdown":
               return SFX_POWERDOWN;
            case "powerup":
               return SFX_POWERUP;
            case "sprout":
               return SFX_SPROUT;
            case "stomp":
               return SFX_STOMP;
            case "stompduck":
               return SFX_STOMP2;
            default:
               return new Class();
         }
      }

      public function Play(param1:int = -1, param2:uint = 100) : void
      {
         if(playingMus != null)
         {
            playingMus.stop();
         }
         if(Mario.music == false)
         {
            return;
         }
         if(param1 > -1)
         {
            playingMus = Musics[param1].play(0,param2);
         }
      }
   }
}
