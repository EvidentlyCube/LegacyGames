
package net.retrocade.tacticengine.monstro.global.core {
    public class MonstroGameplayDefinition {
        private static var _instance:MonstroGameplayDefinition = new MonstroGameplayDefinition();

        public static function get instance():MonstroGameplayDefinition{
            return _instance;
        }

        public var centerBeforeUnitMoves:Boolean = true;
        public var gameSpeed:Number = 0.091;

        public var displayPhaseImages:Boolean = true;
        public var waitForAttackConfirmation:Boolean = true;

        public function MonstroGameplayDefinition() {
            if (_instance !== null){
                throw new SyntaxError("Cannot manually instantiate singleton.");
            }

            gameSpeed = MonstroData.getGameSpeed();
            waitForAttackConfirmation = MonstroData.getWaitForConfirmation();
            centerBeforeUnitMoves = MonstroData.getCenterBeforeUnitMove();
        }
    }
}
