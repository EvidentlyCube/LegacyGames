
package net.retrocade.tacticengine.monstro.levelCompress {
    import flash.display.Sprite;
    import flash.utils.ByteArray;

    import net.retrocade.utils.UtilsBase64;

    public class LevelCompressor extends Sprite {
        public function LevelCompressor() {
            var result:ByteArray = LevelCompressorTool.compress("");
            result.position = 0;

            trace(UtilsBase64.encodeByteArray(result));
        }
    }
}
