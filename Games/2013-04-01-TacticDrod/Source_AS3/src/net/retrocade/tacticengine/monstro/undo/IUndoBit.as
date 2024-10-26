/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 06.04.13
 * Time: 19:12
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.undo {
    import net.retrocade.tacticengine.core.IDestruct;

    public interface IUndoBit extends IDestruct{
        function undo():void;
    }
}
