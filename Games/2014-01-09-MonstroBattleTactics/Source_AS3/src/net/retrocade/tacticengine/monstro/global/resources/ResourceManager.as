

package net.retrocade.tacticengine.monstro.global.resources {
    public class ResourceManager {
        private static var _instance:IVersionResources;
        public static function get instance():IVersionResources{
            if (!_instance){
                initialize();
            }

            return _instance;
        }

        private static function initialize():void {
			_instance = new ResourcesFull();
        }
    }
}
