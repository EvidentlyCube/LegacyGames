package core {
	import core.preloader.IGalagian;
	import core.preloader.IHud;
	import core.preloader.IWeapon;

	import enemies.TAsteroid;

	import flash.display.Bitmap;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.net.SharedObject;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;



	import net.retrocade.retrocamel.core.RetrocamelInputManager;

	import net.retrocade.retrocamel.display.layers.RetrocamelLayerFlashSprite;

	import other.TPlayer;
	import other.Waves;

	public class CheatCodes {
        private static var _lastChars: Array;
        private static var _cheats: Array;

        public static function Init(): void {
            _lastChars = [];
            _cheats = [];

            RetrocamelInputManager.keyDownSignal.add(function (keyCode:int, event: KeyboardEvent):void {
                _lastChars.push(String.fromCharCode(keyCode));

                ResolveCheats();
            });
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