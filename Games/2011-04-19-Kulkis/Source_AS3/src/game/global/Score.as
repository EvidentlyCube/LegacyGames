package game.global {
import net.retrocade.vault.Safe;

public class Score {
    public static var level:Safe = new Safe(1);

    public static function resetGameStart():void {
        level.set(1);
    }
}
}