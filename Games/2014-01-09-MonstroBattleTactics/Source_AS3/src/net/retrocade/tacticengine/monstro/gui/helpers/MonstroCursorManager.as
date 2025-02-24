
package net.retrocade.tacticengine.monstro.gui.helpers {

    import net.retrocade.retrocamel.display.global.RetrocamelCursor;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;

    public class MonstroCursorManager {
        public static function setCursorToGrab():void {
            RetrocamelCursor.setCursorTexture(MonstroGfx.getCursorGrabUnit(), -28, -28);
        }

        public static function setCursorToDragging():void {
            RetrocamelCursor.setCursorTexture(MonstroGfx.getCursorDraggingUnit(), -28, -28);
        }

        public static function setCursorToDraggingBlocked():void {
            RetrocamelCursor.setCursorTexture(MonstroGfx.getCursorCannotDrop(), -28, -28);
        }

        public static function setCursorToAttack():void {
            RetrocamelCursor.setCursorTexture(MonstroGfx.getCursorAttack(), -28, -28);
        }

        public static function setCursorToAttackBlocked():void {
            RetrocamelCursor.setCursorTexture(MonstroGfx.getCursorCannotAttack(), -28, -28);
        }

        public static function setCursorEndUnitTurn():void {
            RetrocamelCursor.setCursorTexture(MonstroGfx.getCursorStopUnit(), -28, -28);
        }

        public static function resetCursor():void {
            RetrocamelCursor.setCursorTexture(MonstroGfx.getCursorDefault(), -9, -10);
        }
    }
}
