package {
	import flash.events.KeyboardEvent;

	public class CheatCodes {
        private static var _lastChars: Array;
        private static var _cheats: Array;

        public static function Init(): void {
            _lastChars = [];
            _cheats = [];
        }

        public static function HandleKey(event: KeyboardEvent): void {
            _lastChars.push(String.fromCharCode(event.keyCode));

            ResolveCheats();
        }

        public static function AddCheat(text: String, callback: *): void {
            _cheats.push([text.toLowerCase(), callback]);
        }

        private static function ResolveCheats(): void {
            while (_lastChars.length > 100) {
                _lastChars.shift();
            }

            var text: String = _lastChars.join("").toLowerCase();

            for (var i: Number = 0; i < _cheats.length; i++) {
                var cheat: * = _cheats[i];
                var index: * = text.indexOf(cheat[0]);

                if (index !== -1 && index === text.length - cheat[0].length) {
                    cheat[1]();
                    _lastChars.length = 0;
                    return;
                }
            }
        }
    }
}