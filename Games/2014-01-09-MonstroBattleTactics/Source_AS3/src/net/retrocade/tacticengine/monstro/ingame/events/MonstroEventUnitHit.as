package net.retrocade.tacticengine.monstro.ingame.events
{
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;

	public class MonstroEventUnitHit extends MonstroEvent{
		public static const NAME:String = "unit_hit";

        public var attacker:MonstroEntity;
		public var defender:MonstroEntity;
        public var onFinished:Function;
		
		public function MonstroEventUnitHit(attacker:MonstroEntity, defender:MonstroEntity, onFinished:Function = null){
            this.attacker = attacker;
			this.defender = defender;
            this.onFinished = onFinished;

            dispatch(NAME);
		}
		
		override public function dispose():void{
			defender = null;
            attacker = null;
            onFinished = null;
		}
	}
}