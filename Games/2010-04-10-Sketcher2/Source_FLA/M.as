package{
    import com.mauft.DataVault.Vault;

    import flash.display.*;
    import flash.events.*;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.net.*;
    import flash.text.*;
    import flash.utils.getDefinitionByName;

    dynamic public class M extends MovieClip{
        public static var init:Boolean = false
        public static var self:M;


        public static var musicChannel:SoundChannel;

        public static var $sfx$             :Boolean = true;
        public static var $music$           :Boolean = true;
        public static var $sleepBody$       :Boolean = true;
        public static var $canMiss$         :Boolean = true;
        public static var $timerBase$       :Number  = 240;
        public static var $timerNewBody$    :Number  = 480;
        public static var $scoreMultiplier$ :Number  = 0.25;
        public static var $difficulty$      :Number  = 0;

        public static var completion        :Number  = 0;

        public function M():void{
        	self = this;

        	reset();

        	load();
        	save();

			ModernDisplay.Init(this, stage, 600, 600);
        }

        public static function save():void{
            var so:SharedObject = SharedObject.getLocal("mz_2010_03_11");

            for(var i:Number = 0; i < 12; i++){
                so.data["argilion_six_" + i.toString()] = Vault.getSafeAsString("score" + i.toString());
            }

            so.data['kompletariusz'] = M.completion;

            so.flush();

            saveOptions();
        }

        public static function load():void{
            var so:SharedObject = SharedObject.getLocal("mz_2010_03_11");

            if (so.data["argilion_six_0"]){
                for(var i:Number = 0; i < 12; i++){
                    Vault.setSafeFromString( "score" + i.toString(), so.data["argilion_six_" + i.toString()]);
                }
            }

            if (so.data['kompletariusz']){
                M.completion = so.data['kompletariusz'];
            }

            loadOptions();
        }


        public static function saveOptions():void{
            var so:SharedObject = SharedObject.getLocal("mz_2010_03_11");

            so.data['sfx']        = $sfx$;
            so.data['music']      = $music$;
            so.data['difficulty'] = $difficulty$;
            so.data['completion'] = completion;

            so.flush();
        }

        public static function loadOptions():void{
             var so:SharedObject = SharedObject.getLocal("mz_2010_03_11");

            if (so.data['sfx']        != undefined){ $sfx$        = so.data['sfx'];        }
            if (so.data['music']      != undefined){ $music$      = so.data['music'];      }
            if (so.data['difficulty'] != undefined){ $difficulty$ = so.data['difficulty']; }
            if (so.data['completion'] != undefined){ completion   = so.data['completion']; }
        }


        public static function reset():void{
            trace("RESET");
            for( var i:int = 0; i < 12; i++){
                Vault.forceValue("score" + i.toString(), 0);
            }
            Level.endLevel();
            Vault.forceValue("timer", 0);

            $canMiss$         = true;
            $timerBase$       = 240;
            $timerNewBody$    = 480;
            $scoreMultiplier$ = 0;
            $difficulty$      = 0
        }

        public static function playSketch():void{
            if ($sfx$){
                var className:String = "SKETCH_" + Math.floor(Math.random()*16 + 1).toString();
                var classLink:Class  = getDefinitionByName(className) as Class;
                Sound(new classLink).play();
            }
        }

        public static function checkDifficulty():void{
            if ($difficulty$ < 0 || $difficulty$ > 2){
                reset();
            }
            if ($difficulty$ == 0){
                if ($canMiss$ == false || $timerBase$ != 240 || $timerNewBody$ != 480 || $scoreMultiplier$ != 0.25){
                    reset();
                }
            }
            if ($difficulty$ == 1){
                if ($canMiss$ == true  || $timerBase$ != 120 || $timerNewBody$ != 360 || $scoreMultiplier$ != 1){
                    reset();
                }
            }
            if ($difficulty$ == 2){
                if ($canMiss$ == true  || $timerBase$ != 60  || $timerNewBody$ != 240 || $scoreMultiplier$ != 6){
                    reset();
                }
            }
        }
    }
}