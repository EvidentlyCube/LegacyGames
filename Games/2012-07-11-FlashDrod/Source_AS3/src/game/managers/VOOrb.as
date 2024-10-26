package game.managers {
    public class VOOrb {        
        public var x:uint;
        public var y:uint;
        
        public var agents:Array = [];
        
        public function VOOrb(x:uint, y:uint){
            this.x = x;
            this.y = y;
        }
        
        public function addAgent(type:uint, tX:uint, tY:uint):void {
            var agent:VOOrbAgent = new VOOrbAgent();
            agent.type = type;
            agent.tX = tX;
            agent.tY = tY;
            agents.push(agent);
        }
    }
}