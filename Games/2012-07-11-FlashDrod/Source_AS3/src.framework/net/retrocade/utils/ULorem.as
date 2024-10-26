package net.retrocade.utils{
    public class ULorem{
        private static var wordsPerParagraph:int = 100;
        private static var wordsPerSentence:Number = 24.460;
        private static var words:Array =   ['lorem',        'ipsum',        'dolor',        'sit',          'amet',
            'consectetur',  'adipiscing',   'elit',         'curabitur',    'vel',          'hendrerit',    'libero',
            'eleifend',     'blandit',      'nunc',         'ornare',       'odio',         'ut',           'orci',
            'gravida',      'imperdiet',    'nullam',       'purus',        'lacinia',      'a',            'pretium',
            'quis',         'congue',       'praesent',     'sagittis',     'laoreet',      'auctor',       'mauris',
            'non',          'velit',        'eros',         'dictum',       'proin',        'accumsan',     'sapien',
            'nec',          'massa',        'volutpat',     'venenatis',    'sed',          'eu',           'molestie',
            'lacus',        'quisque',      'porttitor',    'ligula',       'dui',          'mollis',       'tempus',
            'at',           'magna',        'vestibulum',   'turpis',       'ac',           'diam',         'tincidunt',
            'id',           'condimentum',  'enim',         'sodales',      'in',           'hac',          'habitasse',
            'platea',       'dictumst',     'aenean',       'neque',        'fusce',        'augue',        'leo',
            'eget',         'semper',       'mattis',       'tortor',       'scelerisque',  'nulla',        'interdum',
            'tellus',       'malesuada',    'rhoncus',      'porta',        'sem',          'aliquet',      'et',
            'nam',          'suspendisse',  'potenti',      'vivamus',      'luctus',       'fringilla',    'erat',
            'donec',        'justo',        'vehicula',     'ultricies',    'varius',       'ante',         'primis',
            'faucibus',     'ultrices',     'posuere',      'cubilia',      'curae',        'etiam',        'cursus',
            'aliquam',      'quam',         'dapibus',      'nisl',         'feugiat',      'egestas',      'class',
            'aptent',       'taciti',       'sociosqu',     'ad',           'litora',       'torquent',     'per',
            'conubia',      'nostra',       'inceptos',     'himenaeos',    'phasellus',    'nibh',         'pulvinar',
            'vitae',        'urna',         'iaculis',      'lobortis',     'nisi',         'viverra',      'arcu',
            'morbi',        'pellentesque', 'metus',        'commodo',      'ut',           'facilisis',    'felis',
            'tristique',    'ullamcorper',  'placerat',     'aenean',       'convallis',    'sollicitudin', 'integer',
            'rutrum',       'duis',         'est',          'etiam',        'bibendum',     'donec',        'pharetra',
            'vulputate',    'maecenas',     'mi',           'fermentum',    'consequat',    'suscipit',     'aliquam',
            'habitant',     'senectus',     'netus',        'fames',        'quisque',      'euismod',      'curabitur',
            'lectus',       'elementum',    'tempor',       'risus',        'cras'];
        private static var wordsCount:int = 178;

        public static function Ipsum(count:int):String{
            if(count <= 0)
                return '';

            return getPlain(count);
        }

        private static function getRandomWord():String{
            return words[Math.random() * wordsCount | 0];
        }

        private static function getWords(count:int):Array{
            var array:Array = new Array;
            var i    :int = 2;
            var word :String;

            array[0] = 'lorem';
            array[1] = 'ipsum';

            for(; i < count; i++){
                word = getRandomWord();

                if(array[i - 1] == word)
                    i--;

                else
                    array[i] = word;
            }

            return array;
        }

        private static function getPlain(count:int):String{
            var output      :String = "";
            var words       :Array  = getWords(count);
            var sentences   :Array  = new Array();
            var delta       :int    = count;
            var curr        :int    = 0;

            var word        :String;
            var sentence    :Array;
            var sentenceSize:int;
            var i           :int;

            while(delta > 0){
                sentenceSize = gaussianSentence();
                //echo $curr . '<br />';
                if((delta - sentenceSize) < 4)
                    sentenceSize = delta;

                delta -= sentenceSize;

                sentence = new Array();
                for(i = curr; i < (curr + sentenceSize); i++)
                    sentence.push(words[i]);

                punctuate(sentence);
                curr = curr + sentenceSize;
                sentences.push(sentence);
            }


            for each(sentence in sentences){
                for each(word in sentence){
                    output += word + " ";
                }
            }

            return output;
        }

        private static function punctuate(sentence:Array):void{
            var count :int   = sentence.length;
            var commas:int;
            var index :int;
            var i     :int;

            sentence[count - 1] = sentence[count - 1] + '.';

            if(count < 4)
                return;

            commas = numberOfCommas(count);

            for(i = 1; i <= commas; i++){
                index = Math.round(i * count / (commas + 1));

                if(index < (count - 1) && index > 0)
                    sentence[index] = sentence[index] + ',';
            }
        }

        private static function numberOfCommas(len:int):int{
            var avg   :Number = Math.log(len) / Math.log(6);
            var stdDev:Number = avg / 6;

            return Math.round(gauss_ms(avg, stdDev));
        }

        private static function gaussianSentence():int{
            return Math.round(gauss_ms(24.460, 5.080));
        }

        private static function gauss():Number{   // N(0,1)
            var x:Number = Math.random();
            var y:Number = Math.random();

            return Math.sqrt( -2 * Math.log(x) * Math.cos(2*Math.PI) * y );
        }

        private static function gauss_ms(m:Number = 0.0, s:Number = 1.0):Number{
            return gauss() * s + m;
        }


    }
}
