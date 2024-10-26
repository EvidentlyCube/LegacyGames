package game.managers {
    import game.objects.TGameObject;
    import game.objects.actives.TMonster;
    
    import net.retrocade.camel.objects.rObject;

	/**
     * ...
     * @author 
     */
    public class VOSpeechCommand extends rObject{
        public var command  :VOCharacterCommand;
        public var text     :String;
        public var playSound:Boolean = true;
        public var flush    :Boolean;
        public var turnNo   :uint;
        public var scriptID :uint;
        public var commandIndex:uint;
        
        public var speakingEntity:TMonster;
        public var executingNPC  :TMonster;
        
        public function VOSpeechCommand(monster:TMonster, command:VOCharacterCommand,
                turnNo:uint, scriptID:uint, commandIndex:uint) {
            this.speakingEntity = this.executingNPC = monster;
            this.command        = command;
            this.turnNo         = turnNo;
            this.scriptID       = scriptID;
            this.commandIndex   = commandIndex;
        }
    }
}