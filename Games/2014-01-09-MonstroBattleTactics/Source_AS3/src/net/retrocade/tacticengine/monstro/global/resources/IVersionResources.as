
package net.retrocade.tacticengine.monstro.global.resources {
    import flash.media.Sound;
    import flash.utils.ByteArray;

	import net.retrocade.retrocamel.sound.RetrocamelSound;

	public interface IVersionResources {
        function getGreenlandHumanMusic():RetrocamelSound;
        function getGreenlandMonsterMusic():RetrocamelSound;
        function getIceHumanMusic():RetrocamelSound;
        function getIceMonsterMusic():RetrocamelSound;
        function getLavaHumanMusic():RetrocamelSound;
        function getLavaMonsterMusic():RetrocamelSound;

        function getOutroMusic():Class;
        function getIntroMusic():Class;
        function playJingleDefeatHumans():void;
        function playJingleDefeatMonsters():void;
        function playJingleVictoryHumans():void;
        function playJingleVictoryMonsters():void;
    }
}
