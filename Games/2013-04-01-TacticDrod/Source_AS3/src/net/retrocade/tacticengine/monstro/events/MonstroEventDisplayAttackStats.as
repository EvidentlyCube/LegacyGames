package net.retrocade.tacticengine.monstro.events{
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
    
    public class MonstroEventDisplayAttackStats extends MonstroEvent{
        public static const NAME:String = 'display_attack_stats';

        public var show:Boolean;
        public var showTapNotification:Boolean;
        public var attacker:MonstroEntity;
        public var defender:MonstroEntity;

        public function MonstroEventDisplayAttackStats(show:Boolean,
                                                       showTabNotification:Boolean = false,
                                                       attacker:MonstroEntity = null,
                                                       defender:MonstroEntity = null){

            this.show = show;
            this.showTapNotification = showTabNotification;
            this.attacker = attacker;
            this.defender = defender;

            dispatch(NAME);
        }
        
        override public function destruct():void{
            attacker = null;
            defender = null;
        }
    }
}