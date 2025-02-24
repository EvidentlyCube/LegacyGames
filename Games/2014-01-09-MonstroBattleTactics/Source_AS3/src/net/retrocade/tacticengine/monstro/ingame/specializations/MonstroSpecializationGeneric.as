
package net.retrocade.tacticengine.monstro.ingame.specializations {
    import net.retrocade.retrocamel.locale._;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntityStatistics;

    import starling.textures.Texture;

    public class MonstroSpecializationGeneric implements IMonstroSpecialization{

        private var _type:String;

        public function MonstroSpecializationGeneric(type:String) {
            _type = type;
        }

        public function addToUnit(unit:MonstroEntity):void {
            var stats:MonstroEntityStatistics = unit.getStatistics();

            switch(_type){
                case(MonstroSpecializationFactory.TYPE_ARROW):
                    stats.attackRangeMax += 1;
                    if (stats.attackRangeMin == 1){
                        stats.attackRangeMin = 2;
                    }
                    break;
                case(MonstroSpecializationFactory.TYPE_FOOT):
                    stats.movesMax += 1;
                    stats.movesLeft += 1;
                    break;
                case(MonstroSpecializationFactory.TYPE_HEART):
                    stats.hp += 2;
                    stats.hpMax += 2;
                    break;
                case(MonstroSpecializationFactory.TYPE_SHIELD):
                    stats.defenseMax += 2;
                    stats.defense += 2;
                    break;
                case(MonstroSpecializationFactory.TYPE_SKULL):
                    stats.defense = 0;
                    stats.defenseMax = 0;
                    break;
                case(MonstroSpecializationFactory.TYPE_SWORD):
                    stats.attack += 2;
                    break;
                case(MonstroSpecializationFactory.TYPE_STOP):
                    stats.movesLeft = 0;
                    stats.movesMax = 0;
                    break;
            }

            unit.setStatistics(stats);
        }

        public function getSmallIconTexture():Texture {
            switch(_type){
                case(MonstroSpecializationFactory.TYPE_ARROW):
                    return MonstroGfx.getSpecialtySmallIconArrowTexture();
                case(MonstroSpecializationFactory.TYPE_FOOT):
                    return MonstroGfx.getSpecialtySmallIconFootTexture();
                case(MonstroSpecializationFactory.TYPE_HEART):
                    return MonstroGfx.getSpecialtySmallIconHeartTexture();
                case(MonstroSpecializationFactory.TYPE_SHIELD):
                    return MonstroGfx.getSpecialtySmallIconShieldTexture();
                case(MonstroSpecializationFactory.TYPE_SKULL):
                    return MonstroGfx.getSpecialtySmallIconSkullTexture();
                case(MonstroSpecializationFactory.TYPE_SWORD):
                    return MonstroGfx.getSpecialtySmallIconSwordTexture();
                case(MonstroSpecializationFactory.TYPE_STAR):
                    return MonstroGfx.getSpecialtySmallIconStarTexture();
                case(MonstroSpecializationFactory.TYPE_STOP):
                    return MonstroGfx.getSpecialtySmallIconStopTexture();
                default:
                    throw new Error("Texture not found");
            }
        }

        public function getLargeIconTexture():Texture {
            switch(_type){
                case(MonstroSpecializationFactory.TYPE_ARROW):
                    return MonstroGfx.getSpecialtyLargeIconArrowTexture();
                case(MonstroSpecializationFactory.TYPE_FOOT):
                    return MonstroGfx.getSpecialtyLargeIconFootTexture();
                case(MonstroSpecializationFactory.TYPE_HEART):
                    return MonstroGfx.getSpecialtyLargeIconHeartTexture();
                case(MonstroSpecializationFactory.TYPE_SHIELD):
                    return MonstroGfx.getSpecialtyLargeIconShieldTexture();
                case(MonstroSpecializationFactory.TYPE_SKULL):
                    return MonstroGfx.getSpecialtyLargeIconSkullTexture();
                case(MonstroSpecializationFactory.TYPE_SWORD):
                    return MonstroGfx.getSpecialtyLargeIconSwordTexture();
                case(MonstroSpecializationFactory.TYPE_STAR):
                    return MonstroGfx.getSpecialtyLargeIconStarTexture();
                case(MonstroSpecializationFactory.TYPE_STOP):
                    return MonstroGfx.getSpecialtyLargeIconStopTexture();
                default:
                    throw new Error("Texture not found");
            }
        }

        public function getDescription():String {
            return _("specialization." + _type)
        }

        public function makeDump():Object {
            var dump:Object = {};
            dump.type = _type;

            return dump;
        }

        public function loadFromDump(dump:Object):void {}


        public function dispose():void{
            _type = null;
        }
    }
}
