package game.global{
    import net.retrocade.camel.core.rSave;
    import net.retrocade.camel.core.rSound;

    public class Sfx{
        [Embed(source="/../assets/sfx/arrow1.mp3")] private static var _arrow0:Class;
        [Embed(source="/../assets/sfx/arrow2.mp3")] private static var _arrow1:Class;
        [Embed(source="/../assets/sfx/arrow3.mp3")] private static var _arrow2:Class;
        [Embed(source="/../assets/sfx/arrow4.mp3")] private static var _arrow3:Class;
        [Embed(source="/../assets/sfx/arrow5.mp3")] private static var _arrow4:Class;

        [Embed(source="/../assets/sfx/bounce1.mp3")] private static var _bounce0:Class;
        [Embed(source="/../assets/sfx/bounce2.mp3")] private static var _bounce1:Class;
        [Embed(source="/../assets/sfx/bounce3.mp3")] private static var _bounce2:Class;
        [Embed(source="/../assets/sfx/bounce4.mp3")] private static var _bounce3:Class;
        [Embed(source="/../assets/sfx/bounce5.mp3")] private static var _bounce4:Class;

        [Embed(source="/../assets/sfx/bullet1.mp3")] private static var _bullet0:Class;
        [Embed(source="/../assets/sfx/bullet2.mp3")] private static var _bullet1:Class;
        [Embed(source="/../assets/sfx/bullet3.mp3")] private static var _bullet2:Class;
        [Embed(source="/../assets/sfx/bullet4.mp3")] private static var _bullet3:Class;
        [Embed(source="/../assets/sfx/bullet5.mp3")] private static var _bullet4:Class;

        [Embed(source="/../assets/sfx/cannon_die.mp3")] private static var _cannondie:Class;

        [Embed(source="/../assets/sfx/cannon1.mp3")] private static var _cannon0:Class;
        [Embed(source="/../assets/sfx/cannon2.mp3")] private static var _cannon1:Class;
        [Embed(source="/../assets/sfx/cannon3.mp3")] private static var _cannon2:Class;
        [Embed(source="/../assets/sfx/cannon4.mp3")] private static var _cannon3:Class;
        [Embed(source="/../assets/sfx/cannon5.mp3")] private static var _cannon4:Class;

        [Embed(source="/../assets/sfx/completed.mp3")] private static var _completed:Class;

        [Embed(source="/../assets/sfx/crate_fall_1.mp3")] private static var _cratefall:Class;

        [Embed(source="/../assets/sfx/crate_push_1.mp3")] private static var _cratepush0:Class;
        [Embed(source="/../assets/sfx/crate_push_2.mp3")] private static var _cratepush1:Class;
        [Embed(source="/../assets/sfx/crate_push_3.mp3")] private static var _cratepush2:Class;
        [Embed(source="/../assets/sfx/crate_push_4.mp3")] private static var _cratepush3:Class;
        [Embed(source="/../assets/sfx/crate_push_5.mp3")] private static var _cratepush4:Class;

        [Embed(source="/../assets/sfx/eat1.mp3")] private static var _eat0:Class;
        [Embed(source="/../assets/sfx/eat2.mp3")] private static var _eat1:Class;
        [Embed(source="/../assets/sfx/eat3.mp3")] private static var _eat2:Class;
        [Embed(source="/../assets/sfx/eat4.mp3")] private static var _eat3:Class;
        [Embed(source="/../assets/sfx/eat5.mp3")] private static var _eat4:Class;
        [Embed(source="/../assets/sfx/eat6.mp3")] private static var _eat5:Class;

        [Embed(source="/../assets/sfx/explosion1.mp3")] private static var _explosion0:Class;
        [Embed(source="/../assets/sfx/explosion2.mp3")] private static var _explosion1:Class;
        [Embed(source="/../assets/sfx/explosion3.mp3")] private static var _explosion2:Class;
        [Embed(source="/../assets/sfx/explosion4.mp3")] private static var _explosion3:Class;

        [Embed(source="/../assets/sfx/kill_player_0.mp3")] private static var _killplayer0:Class;
        [Embed(source="/../assets/sfx/kill_player_1.mp3")] private static var _killplayer1:Class;
        [Embed(source="/../assets/sfx/kill_player_2.mp3")] private static var _killplayer2:Class;

        [Embed(source="/../assets/music/music4.mp3")] public static var _music:Class;

        [Embed(source="/../assets/sfx/stopper1.mp3")] private static var _stopper0:Class;
        [Embed(source="/../assets/sfx/stopper2.mp3")] private static var _stopper1:Class;
        [Embed(source="/../assets/sfx/stopper3.mp3")] private static var _stopper2:Class;
        [Embed(source="/../assets/sfx/stopper4.mp3")] private static var _stopper3:Class;
        [Embed(source="/../assets/sfx/stopper5.mp3")] private static var _stopper4:Class;

        [Embed(source="/../assets/sfx/switch1.mp3")] private static var _switch0:Class;
        [Embed(source="/../assets/sfx/switch2.mp3")] private static var _switch1:Class;
        [Embed(source="/../assets/sfx/switch3.mp3")] private static var _switch2:Class;
        [Embed(source="/../assets/sfx/switch4.mp3")] private static var _switch3:Class;
        [Embed(source="/../assets/sfx/switch5.mp3")] private static var _switch4:Class;

        [Embed(source="/../assets/sfx/teleport1.mp3")] private static var _teleport0:Class;
        [Embed(source="/../assets/sfx/teleport2.mp3")] private static var _teleport1:Class;
        [Embed(source="/../assets/sfx/teleport3.mp3")] private static var _teleport2:Class;
        [Embed(source="/../assets/sfx/teleport4.mp3")] private static var _teleport3:Class;
        [Embed(source="/../assets/sfx/teleport5.mp3")] private static var _teleport4:Class;

        [Embed(source="/../assets/sfx/turnwall1.mp3")] private static var _turnwall0:Class;
        [Embed(source="/../assets/sfx/turnwall2.mp3")] private static var _turnwall1:Class;
        [Embed(source="/../assets/sfx/turnwall3.mp3")] private static var _turnwall2:Class;
        [Embed(source="/../assets/sfx/turnwall4.mp3")] private static var _turnwall3:Class;
        [Embed(source="/../assets/sfx/turnwall5.mp3")] private static var _turnwall4:Class;

        [Embed(source="/../assets/sfx/unlock.mp3")] private static var _unlock:Class;

        [Embed(source="/../assets/sfx/wall1.mp3")] private static var _wall0:Class;
        [Embed(source="/../assets/sfx/wall2.mp3")] private static var _wall1:Class;
        [Embed(source="/../assets/sfx/wall3.mp3")] private static var _wall2:Class;
        [Embed(source="/../assets/sfx/wall4.mp3")] private static var _wall3:Class;
        [Embed(source="/../assets/sfx/wall5.mp3")] private static var _wall4:Class;

        [Embed(source="/../assets/sfx/waller1.mp3")] private static var _waller0:Class;
        [Embed(source="/../assets/sfx/waller2.mp3")] private static var _waller1:Class;
        [Embed(source="/../assets/sfx/waller3.mp3")] private static var _waller2:Class;
        [Embed(source="/../assets/sfx/waller4.mp3")] private static var _waller3:Class;
        [Embed(source="/../assets/sfx/waller5.mp3")] private static var _waller4:Class;

        [Embed(source="/../assets/sfx/sfxClick.mp3")] private static var _sfxClick:Class;
        [Embed(source="/../assets/sfx/sfxRollOver.mp3")] private static var _sfxRollOver:Class;

        public static function click        ():void{ play("_sfxClick",          0); }
        public static function rollOver     ():void{ play("_sfxRollOver",       0); }
        public static function arrow        ():void{ play("_arrow",             5); }
        public static function bounce       ():void{ play("_bounce",            5); }
        public static function bullet       ():void{ play("_bullet",            5); }
        public static function cannon       ():void{ play("_cannon",            5); }
        public static function cannonAlarm  ():void{ play("_cannondie",         0); }
        public static function completed    ():void{ play("_completed",         0); }
        public static function crateFall    ():void{ play("_cratefall",         0); }
        public static function cratePush    ():void{ play("_cratepush",         5); }
        public static function eat          ():void{ play("_eat",               6); }
        public static function explosion    ():void{ play("_explosion",         4); }
        public static function killPlayer   ():void{ play("_killplayer",        3); }
        public static function stopper      ():void{ play("_stopper",           5); }
        public static function switchPush   ():void{ play("_switch",            5); }
        public static function teleport     ():void{ play("_teleport",          1); }
        public static function turnwall     ():void{ play("_turnwall",          5); }
        public static function exitOpened   ():void{ play("_unlock",            0); }
        public static function wall         ():void{ play("_wall",              5); }
        public static function growingWall  ():void{ play("_waller",            5); }

        private static function play(name:String, count:uint = 0):void{
            if (count)
                rSound.playSound(Sfx[name + (Math.random() * count | 0).toString()]);
            else
                rSound.playSound(Sfx[name]);
        }
    }
}