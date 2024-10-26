package submuncher.core.repositories {
    import net.retrocade.retrocamel.locale._;

    import submuncher.core.submuncher_init;

    public class LevelGroupsRepository {
        private static var _groups:Vector.<LevelGroupMetadata>;

        submuncher_init static function init():void {
            _groups = new Vector.<LevelGroupMetadata>();
            addGroup(
                '001',
                'hub-001',
                [
                    getLevel('001-001', true),
                    getLevel('001-002', true),
                    getLevel('001-003', true),
                    getLevel('001-004', true),
                    getLevel('001-005', true),
                    getLevel('001-006', false)
                ]
            );
            addGroup(
                '002',
                'hub-001',
                [
                    getLevel('002-001', true),
                    getLevel('002-002', true),
                    getLevel('002-003', true),
                    getLevel('002-004', true),
                    getLevel('002-005', true),
                    getLevel('002-006', false)
                ]
            );
            addGroup(
                '003',
                'hub-001',
                [
                    getLevel('003-001', true),
                    getLevel('003-002', true),
                    getLevel('003-003', true),
                    getLevel('003-004', true),
                    getLevel('003-005', true),
                    getLevel('003-006', false)
                ]
            );
            addGroup(
                '004',
                'hub-001',
                [
                    getLevel('004-001', true)
                ]
            );
            addGroup(
                '005',
                'hub-001',
                [
                    getLevel('boss-001', false)
                ]
            );
            addGroup(
                '006',
                'hub-001',
                [
                    getLevel('jerzy-001', false),
                    getLevel('jerzy-002', false),
                    getLevel('jerzy-003', false),
                    getLevel('jerzy-004', false),
                    getLevel('jerzy-005', false),
                ]
            );
            addGroup(
                '007',
                'hub-001',
                [
                    getLevel('jerzy-006', false),
                    getLevel('jerzy-007', false),
                    getLevel('jerzy-008', false),
                    getLevel('jerzy-009', false),
                    getLevel('jerzy-010', false),
                ]
            );
            addGroup(
                '008',
                'hub-001',
                [
                    getLevel('jerzy-011', false),
                    getLevel('jerzy-012', false),
                    getLevel('jerzy-013', false),
                    getLevel('jerzy-014', false),
                    getLevel('jerzy-015', false),
                ]
            );
            addGroup(
                '009',
                'hub-001',
                [
                    getLevel('jerzy-016', false),
                    getLevel('jerzy-017', false),
                    getLevel('jerzy-018', false),
                    getLevel('jerzy-019', false),
                    getLevel('jerzy-020', false),
                ]
            );
            addGroup(
                '010',
                'hub-001',
                [
                    getLevel('jerzy-021', false),
                    getLevel('jerzy-022', false),
                    getLevel('jerzy-023', false),
                    getLevel('jerzy-024', false),
                    getLevel('jerzy-025', false),
                ]
            );
            addGroup(
                '011',
                'hub-001',
                [
                    getLevel('jerzy-026', false),
                    getLevel('jerzy-027', false),
                    getLevel('jerzy-028', false),
                    getLevel('jerzy-029', false),
                    getLevel('jerzy-030', false),
                ]
            );
            addGroup(
                '012',
                'hub-001',
                [
                    getLevel('jerzy-031', false),
                    getLevel('jerzy-032', false),
                    getLevel('jerzy-033', false),
                    getLevel('jerzy-034', false),
                    getLevel('jerzy-035', false),
                ]
            );
        }

        public static function getGroupById(id:String):LevelGroupMetadata {
            for each (var groupMetadata:LevelGroupMetadata in _groups) {
                if (groupMetadata.id === id){
                    return groupMetadata;
                }
            }

            throw new ArgumentError("Group of ID " + id + " does not exist.");
        }

        public static function getGroupByLevel(level:LevelMetadata):LevelGroupMetadata {
            for each (var groupMetadata:LevelGroupMetadata in _groups) {
                if (groupMetadata.containsLevel(level)){
                    return groupMetadata;
                }
            }

            throw new ArgumentError("Group containinig level " + level.id + " does not exist.");
        }

        public static function getGroupByIndex(index:int):LevelGroupMetadata {
            return _groups[index];
        }

        public static function getGroupIndex(group:LevelGroupMetadata):int {
            return _groups.indexOf(group);
        }

        public static function getFirstGroupByHub(hubId:String):LevelGroupMetadata {
            for each (var metadata:LevelGroupMetadata in _groups) {
                if (metadata.hubLevelId === hubId){
                    return metadata;
                }
            }

            throw new ArgumentError("Group containing hub " + hubId + " does not exist.");
        }

        public static function getEntryByLevel(level:LevelMetadata):LevelGroupEntryMetadata{
            for each (var groupMetadata:LevelGroupMetadata in _groups) {
                for each (var metadata:LevelGroupEntryMetadata in groupMetadata.levels) {
                    if (metadata.level === level){
                        return metadata;
                    }
                }
            }

            throw new ArgumentError("Group containinig level " + level.id + " does not exist.");
        }

        public static function groupExists(groupId:String):Boolean {
            for each (var groupMetadata:LevelGroupMetadata in _groups) {
                if (groupMetadata.id === groupId){
                    return true;
                }
            }

            return false;
        }

        public static function isLevelInGroup(level:LevelMetadata):Boolean {
            for each (var groupMetadata:LevelGroupMetadata in _groups) {
                if (groupMetadata.containsLevel(level)){
                    return true;
                }
            }

            return false;
        }

        public static function isLevelRequired(level:LevelMetadata):Boolean {
            for each (var group:LevelGroupMetadata in _groups) {
                for each (var entry:LevelGroupEntryMetadata in group.levels) {
                    if (entry.level === level){
                        return entry.required;
                    }
                }
            }

            return false;
        }

        public static function totalGroups():int {
            return _groups.length;
        }

        private static function addGroup(id:String, hubId:String, levels:Array):void {
            for (var i:int = 0; i < levels.length; i++) {
                var entry:LevelGroupEntryMetadata = levels[i];
                entry.name = _('level.name.' + id + "." + i)
            }

            _groups.push(
                new LevelGroupMetadata(
                    id,
                    hubId,
                    _('level.name.' + id),
                    Vector.<LevelGroupEntryMetadata>(levels)
                )
            );
        }

        private static function getLevel(id:String, required:Boolean):LevelGroupEntryMetadata {
            return new LevelGroupEntryMetadata(
                LevelRepository.getLevelById(id),
                required
            );
        }
    }
}
