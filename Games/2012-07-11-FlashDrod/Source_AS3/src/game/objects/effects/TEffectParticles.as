package game.objects.effects{
    import game.global.Room;
    import game.managers.VOCoord;
    import game.managers.effects.VOParticle;

    import net.retrocade.utils.Rand;

    public class TEffectParticles extends TEffect{
        protected var particles:Array;

        protected var origin:VOCoord;
        protected var count :uint;
        protected var minDuration:uint;
        protected var speed:uint;
        protected var types:uint;

        protected var originX:uint;
        protected var originY:uint;

        protected var offsetX:int;
        protected var offsetY:int;

        protected var maxWidth:uint;
        protected var maxHeight:uint;

        protected var spreadX:Number;
        protected var spreadY:Number;

        protected var continous:Boolean;

        protected var fromEdge:Boolean;

        public function TEffectParticles(_origin:VOCoord, _maxWidth:uint, _maxHeight:uint, _types:uint, _minParticles:uint = 25,
                                         _minDuration:uint = 7, _speed:uint = 4, _continous:Boolean = false, _fromEdge:Boolean = false){
            origin      = _origin;
            minDuration = _minDuration;
            speed       = _speed;
            fromEdge    = _fromEdge;
            maxWidth    = _maxWidth;
            maxHeight   = _maxHeight;
            continous   = _continous;
            types       = _types;

            originX = origin.x * S.LEVEL_TILE_WIDTH;
            originY = origin.y * S.LEVEL_TILE_HEIGHT;

            if (fromEdge){
                switch(origin.o){
                    case (C.NW): case (C.W): case (C.SW):
                        originX += (S.LEVEL_TILE_WIDTH - maxWidth);
                        break;

                    case(C.N): case(C.S): case(C.NO_ORIENTATION):
                        originX += (S.LEVEL_TILE_WIDTH - maxWidth) / 2;
                        break;
                }

                switch(origin.o){
                    case (C.NW): case (C.N): case (C.NE):
                        originY += (S.LEVEL_TILE_HEIGHT - maxHeight);
                        break;

                    case(C.W): case(C.E): case(C.NO_ORIENTATION):
                        originY += (S.LEVEL_TILE_HEIGHT - maxHeight) / 2;
                        break;
                }
            } else {
                originX += (S.LEVEL_TILE_WIDTH - maxWidth) / 2;
                originY += (S.LEVEL_TILE_HEIGHT - maxHeight) / 2;
            }

            switch(origin.o){
                case(C.NW): case(C.W): case(C.SW): offsetX = -speed; break;
                case(C.NE): case(C.E): case(C.SE): offsetX = speed;  break;
                case(C.N):  case(C.S): case(C.NO_ORIENTATION): offsetX = 0; break;
            }

            switch(origin.o){
                case(C.NW): case(C.N): case(C.NE): offsetY = -speed; break;
                case(C.SW): case(C.S): case(C.SE): offsetY = speed;  break;
                case(C.W):  case(C.E): case(C.NO_ORIENTATION): offsetY = 0; break;
            }

            switch(origin.o){
                case(C.N): case(C.E):
                case(C.S): case(C.W):
                    spreadX = speed * 1.414;
                    spreadY = speed * 1.414;
                    break;

                case(C.NO_ORIENTATION):
                case(C.NW): case(C.NE):
                case(C.SW): case(C.SE):
                    spreadX = speed;
                    spreadY = speed;
                    break;
            }

            count = _minParticles + Rand.om * _minParticles * 0.5;
            particles = [];

            for (var i:uint = 0; i < count; i++){
                resetParticle(i);
            }
        }

        protected function resetParticle(index:uint):void{
            var particle:VOParticle = new VOParticle();

            particle.x          = originX;
            particle.y          = originY;
            particle.mx         = offsetX + Rand.fmid(spreadX * 0.5);
            particle.my         = offsetY + Rand.fmid(spreadY * 0.5);
            particle.timeLeft   = minDuration;
            particle.type       = Rand.om * types | 0;
            particle.active     = true;

            particles[index] = particle;
        }

        /**
         * Returns false if there are no more active particles
         */
        protected function moveParticles():Boolean{
            var anyActive:Boolean = false;

            for each(var p:VOParticle in particles){
                if (!p.active)
                    continue;

                p.x += p.mx;
                p.y += p.my;

                if (Rand.om * 2 | 0){
                    if (!--p.timeLeft){
                        p.active = false;
                        continue;
                    }
                }

                if (hitsObstacle(p)){
                    reflectParticle(p);
                }

                anyActive = true;
            }

            return anyActive;
        }

        protected function hitsObstacle(particle:VOParticle):Boolean {
            var index   :uint = (particle.x / S.LEVEL_TILE_WIDTH | 0) +
                (particle.y / S.LEVEL_TILE_HEIGHT | 0) * S.LEVEL_WIDTH;
            var oldIndex:uint = ((particle.x - particle.mx) / S.LEVEL_TILE_WIDTH | 0) +
                ((particle.y - particle.my) / S.LEVEL_TILE_HEIGHT | 0) * S.LEVEL_WIDTH;

            if (index == oldIndex)
                return false;

            switch(room.tilesOpaque[index]){
                case(C.T_BRIDGE): case(C.T_BRIDGE_H): case(C.T_BRIDGE_V):
                case(C.T_FLOOR): case(C.T_FLOOR_ALT): case(C.T_FLOOR_DIRT): case(C.T_FLOOR_GRASS):
                case(C.T_FLOOR_IMAGE): case(C.T_FLOOR_MOSAIC): case(C.T_FLOOR_ROAD):
                case(C.T_PLATFORM_P): case(C.T_PLATFORM_W):
                case(C.T_PIT): case(C.T_PIT_IMAGE):
                case(C.T_WATER): case(C.T_GOO):
                case(C.T_DOOR_BO): case(C.T_DOOR_CO): case(C.T_DOOR_GO): case(C.T_DOOR_RO): case(C.T_DOOR_YO):
                case(C.T_TRAPDOOR): case(C.T_TRAPDOOR_WATER):
                case(C.T_STAIRS): case(C.T_STAIRS_UP): case(C.T_HOT): case(C.T_PRESSPLATE):
                    return false;
                default:
                    return true;
            }
        }

        protected function reflectParticle(particle:VOParticle):void{
            particle.x -= particle.mx;
            particle.y -= particle.my;

            if (Rand.om * 2 | 0){
                particle.mx = - particle.mx;
                particle.x += particle.mx;
            } else {
                particle.my = - particle.my;
                particle.y += particle.my;
            }
        }
    }
}