/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 30.03.13
 * Time: 13:29
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.core {
    import flash.display.DisplayObjectContainer;
    import flash.display.Stage;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.geom.Rectangle;
    import flash.utils.setTimeout;

    import net.retrocade.camel.global.rCore;

    import net.retrocade.starling.rStarling;
    import net.retrocade.tacticengine.monstro.core.MonstroData;

    import starling.core.Starling;

    public class CoreInit {
        private static var _isInitialized:Boolean = false;

        public static function init(root:DisplayObjectContainer):void{
            if (_isInitialized){
                return;
            }

            _isInitialized = true;

            MonstroData.init();

            var stage:Stage = root.stage;
            stage.scaleMode = StageScaleMode.SHOW_ALL;
            // stage.align     = StageAlign.TOP_LEFT;
            stage.frameRate = 60;

            if (stage.loaderInfo.parameters.Level){
                MonstroData.currentLevel.set(stage.loaderInfo.parameters.Level);
                MonstroData.turnsTaken.set(stage.loaderInfo.parameters.TurnsPlayed);
                MonstroData.lostUnits.set(stage.loaderInfo.parameters.UnitsLost);
            }

            rCore.initFlash(stage, root, S());

            Starling.handleLostContext = true;
            setTimeout(rStarling.initialize, 1000, MonstroRoot, stage, new Rectangle(0, 0, S().gameFullscreenWidth, S().gameFullscreenHeight));
        }
    }
}
