package com.mauft{
    import flash.display.Stage;
    import flash.events.KeyboardEvent;
    public class Control{
        public static const KEY_A                   :int = 65; 
        public static const KEY_B                   :int = 66; 
        public static const KEY_C                   :int = 67; 
        public static const KEY_D                   :int = 68; 
        public static const KEY_E                   :int = 69; 
        public static const KEY_F                   :int = 70; 
        public static const KEY_G                   :int = 71; 
        public static const KEY_H                   :int = 72; 
        public static const KEY_I                   :int = 73; 
        public static const KEY_J                   :int = 74; 
        public static const KEY_K                   :int = 75; 
        public static const KEY_L                   :int = 76; 
        public static const KEY_M                   :int = 77; 
        public static const KEY_N                   :int = 78; 
        public static const KEY_O                   :int = 79; 
        public static const KEY_P                   :int = 80; 
        public static const KEY_Q                   :int = 81; 
        public static const KEY_R                   :int = 82; 
        public static const KEY_S                   :int = 83; 
        public static const KEY_T                   :int = 84; 
        public static const KEY_U                   :int = 85; 
        public static const KEY_V                   :int = 86; 
        public static const KEY_W                   :int = 87;
        public static const KEY_X                   :int = 88; 
        public static const KEY_Y                   :int = 89; 
        public static const KEY_Z                   :int = 90;
        
        public static const KEY_DOWN                :int = 40;
        public static const KEY_LEFT                :int = 37; 
        public static const KEY_RIGHT               :int = 39; 
        public static const KEY_UP                  :int = 38; 
        
        public static const KEY_F1                  :int = 112; 
        public static const KEY_F2                  :int = 113; 
        public static const KEY_F3                  :int = 114; 
        public static const KEY_F4                  :int = 115; 
        public static const KEY_F5                  :int = 116; 
        public static const KEY_F6                  :int = 117; 
        public static const KEY_F7                  :int = 118; 
        public static const KEY_F8                  :int = 119; 
        public static const KEY_F9                  :int = 120; 
        public static const KEY_F10                 :int = 121; 
        public static const KEY_F11                 :int = 122; 
        public static const KEY_F12                 :int = 123;
        public static const KEY_F13                 :int = 124;
        public static const KEY_F14                 :int = 125;
        public static const KEY_F15                 :int = 126; 
        
        public static const KEY_0                   :int = 48;
        public static const KEY_1                   :int = 49;
        public static const KEY_2                   :int = 50;
        public static const KEY_3                   :int = 51;
        public static const KEY_4                   :int = 52;
        public static const KEY_5                   :int = 53;
        public static const KEY_6                   :int = 54;
        public static const KEY_7                   :int = 55;
        public static const KEY_8                   :int = 56;
        public static const KEY_9                   :int = 57;
        
        public static const KEY_BACKSPACE           :int = 8;
        public static const KEY_CAPS_LOCK           :int = 20;
        public static const KEY_CONTROL             :int = 17;
        public static const KEY_DELETE              :int = 46;
        public static const KEY_END                 :int = 35;
        public static const KEY_ENTER               :int = 13;
        public static const KEY_ESCAPE              :int = 27;
        public static const KEY_HOME                :int = 36;
        public static const KEY_INSERT              :int = 45;
        public static const KEY_OPTION              :int = 18;
        public static const KEY_PAGE_DOWN           :int = 34;
        public static const KEY_PAGE_UP             :int = 33;
        public static const KEY_SHIFT               :int = 16;
        public static const KEY_SPACE               :int = 32;
        public static const KEY_TAB                 :int = 9;
        
        public static const KEY_BACKQUOTE           :int = 192;
        public static const KEY_BACKSLASH           :int = 220;
        public static const KEY_COMMA               :int = 188;
        public static const KEY_EQUAL               :int = 187;
        public static const KEY_BRACKET_LEFT        :int = 219;
        public static const KEY_MINUS               :int = 189;
        public static const KEY_PERIOD              :int = 190;
        public static const KEY_APOSTROPHE          :int = 222;
        public static const KEY_BRACKET_RIGHT       :int = 221;
        public static const KEY_SEMICOLON           :int = 186;
        public static const KEY_SLASH               :int = 191;
        
        private static var keyHolds:Array = new Array;
        private static var keyHits :Array = new Array;
        
        public function Control(){ new Error("Can't instantiate Control object - please use static methods only!") }
        
        public static function init(stage:Stage):void{
            stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
            stage.addEventListener(KeyboardEvent.KEY_UP,   keyUp);
        }
        
        public static function isKeyDown(keyCode:int):Boolean{
            return keyHolds[keyCode];
        }
        public static function isKeyHit(keyCode:int):Boolean{
            if (keyHits[keyCode]){
                keyHits[keyCode] = false;
                return true;
            }
            return false;
        }
        
        private static function keyDown(e:KeyboardEvent):void{
            keyHolds[e.keyCode] = true;
            keyHits [e.keyCode] = true;
        }
        
        private static function keyUp(e:KeyboardEvent):void{
            keyHolds[e.keyCode] = false;
            keyHits [e.keyCode] = false;
        }
    }
}