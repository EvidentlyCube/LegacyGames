/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 17.03.13
 * Time: 01:04
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.core {
    import net.retrocade.camel.global.rSfx;
    import net.retrocade.storage.Storage;
    import net.retrocade.storage.StorageIOHandlerToFile;
    import net.retrocade.storage.StorageIOHandlerToSharedObject;
    import net.retrocade.vault.Safe;

    public class MonstroData {
        private static const FILE_NAME:String = "store.dat";
        private static const CRYPTO_KEY:String = "4yZN2N7sd2x7i3XAcBqmq5lY";
        private static const SALT:String = "p2xp45Z0q7n8NWlQKMzqG1R3";
        private static const SCRAMBLE_KEY:int = 634937;

        private static const STORAGE_NAME_MUSIC:String = "musicVolume";
        private static const STORAGE_NAME_SFX:String = "sfxVolumne";
        private static const STORAGE_NAME_GAME_SPEED:String = "gameSpeed";
        private static const STORAGE_NAME_WAIT_FOR_CONFIRMATION:String = "waitForConfirm";

        public static var isPlayingAsHumans:Boolean = true;

        public static var currentLevel:Safe;
        public static var lostUnits:Safe;
        public static var turnsTaken:Safe;

        public static var gameSpeed:Number;

        public static function init():void{
            //Storage.init(new StorageIOHandlerToFile(FILE_NAME, CRYPTO_KEY, SCRAMBLE_KEY), CRYPTO_KEY, SALT, SCRAMBLE_KEY);
            Storage.init(new StorageIOHandlerToSharedObject("TacticDROD"), CRYPTO_KEY, SALT, SCRAMBLE_KEY);

            currentLevel = new Safe(0, null, cheatFunction);
            lostUnits = new Safe(0, null, cheatFunction);
            turnsTaken = new Safe(0, null, cheatFunction);

            rSfx.musicVolume = getMusicVolume();
            rSfx.soundVolume = getSfxVolume();
            gameSpeed = getGameSpeed();
        }

        public static function setGameSpeed(value:Number, autoCommit:Boolean = false):void{
            Storage.writeNumber(STORAGE_NAME_GAME_SPEED, value);

            if (autoCommit){
                Storage.save();
            }
        }

        public static function getGameSpeed():Number{
            return Storage.readNumber(STORAGE_NAME_GAME_SPEED, 0.091);
        }

        public static function setMusicVolume(value:Number, autoCommit:Boolean = false):void{
            Storage.writeNumber(STORAGE_NAME_MUSIC, value);
            if (autoCommit){
                Storage.save();
            }
        }

        public static function getMusicVolume():Number{
            return Storage.readNumber(STORAGE_NAME_MUSIC, 1);
        }

        public static function setSfxVolume(value:Number, autoCommit:Boolean = false):void{
            Storage.writeNumber(STORAGE_NAME_SFX, value);
            if (autoCommit){
                Storage.save();
            }
        }

        public static function getSfxVolume():Number{
            return Storage.readNumber(STORAGE_NAME_SFX, 1);
        }

        public static function commitData():void{
            Storage.save();
        }

        private static function cheatFunction():void{
            lostUnits.force(lostUnits.get() | 10000);
            turnsTaken.force(turnsTaken.get() | 10000);
        }

        public static function getWaitForConfirmation():Boolean {
            return Storage.readFlag(STORAGE_NAME_WAIT_FOR_CONFIRMATION, true);
        }

        public static function setWaitForConfirmation(value:Boolean):void {
            Storage.writeFlag(STORAGE_NAME_WAIT_FOR_CONFIRMATION, value);
        }
    }
}
