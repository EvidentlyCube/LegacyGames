
package net.retrocade.tacticengine.core {
    public interface IDumpable {
        function makeDump():Object;
        function loadFromDump(dump:Object):void;
    }
}
