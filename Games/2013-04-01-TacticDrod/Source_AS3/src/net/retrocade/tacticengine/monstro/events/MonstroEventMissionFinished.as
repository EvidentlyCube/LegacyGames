/**
 * Created with IntelliJ IDEA.
 * User: mzarzycki
 * Date: 17.01.13
 * Time: 10:16
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.events {
    public class MonstroEventMissionFinished extends MonstroEvent{
        public static const NAME:String = "mission_finished";

        public var isVictory:Boolean;

        public function MonstroEventMissionFinished(isVictory:Boolean){
            this.isVictory = isVictory;

            dispatch(NAME);
        }
    }
}
