
package net.retrocade.tacticengine.monstro.ingame.tutorial.cards {
    import net.retrocade.tacticengine.core.IDisposable;

    import starling.display.Sprite;

    import starling.errors.AbstractMethodError;

    public class MonstroTutorialCardBase extends Sprite implements IDisposable {
        public function get id():int{
            throw new AbstractMethodError("Method not implemented");
        }

        public function get requiresConstantUpdate():Boolean{
            throw new AbstractMethodError("Method not implemented");
        }

        public function update():Boolean{
            return false;
        }

        public function checkIfAppear():Boolean{
            throw new AbstractMethodError("Method not implemented");
        }

        public function onAppear():void{}

        public function checkIfHide():Boolean{
            throw new AbstractMethodError("Method not implemented");
        }

        public function onHide():void{}

        public function getText():String{
            throw new AbstractMethodError("Method not implemented");
        }
    }
}
