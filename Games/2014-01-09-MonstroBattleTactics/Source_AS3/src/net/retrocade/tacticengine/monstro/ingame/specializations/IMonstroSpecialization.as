
package net.retrocade.tacticengine.monstro.ingame.specializations {
    import net.retrocade.tacticengine.core.IDisposable;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;

    import starling.textures.Texture;

    public interface IMonstroSpecialization extends IDisposable{
        function addToUnit(unit:MonstroEntity):void;
        function getSmallIconTexture():Texture;
        function getLargeIconTexture():Texture;
        function getDescription():String;

        function makeDump():Object;
        function loadFromDump(dump:Object):void;
    }
}
