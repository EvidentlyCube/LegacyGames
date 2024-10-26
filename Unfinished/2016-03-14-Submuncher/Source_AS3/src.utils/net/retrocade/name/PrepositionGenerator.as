package net.retrocade.name {
    public class PrepositionGenerator {
        private static var _prepositions:Array;

        {
            init();
        }

        public static function get preposition():String{
            return _prepositions[Math.random() * _prepositions.length | 0];
        }

        private static function init():void{
            var string:String = "aboard,about,above,across,after,against,along,amid,among,anti,around,as,at,before,behind,below,beneath,beside,besides," +
                "between,beyond,but,by,concerning,considering,despite,down,during,except,excepting,excluding,following,for,from,in,inside,into,like," +
                "minus,near,of,off,on,onto,opposite,outside,over,past,per,plus,regarding,round,save,since,than,through,to,toward,towards,under,underneath," +
                "unlike,until,up,upon,versus,via,with,within,without";

            _prepositions = string.split(",");
        }
    }
}
