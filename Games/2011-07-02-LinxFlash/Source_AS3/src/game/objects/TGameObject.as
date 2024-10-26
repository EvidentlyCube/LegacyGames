package game.objects{
    import game.global.Level;
    import net.retrocade.camel.core.rGroup;


    import net.retrocade.camel.objects.rObjectDisplay;
    import game.global.Game;

    public class TGameObject extends rObjectDisplay{
        /**
         * X of the left edge of the level
         */
        public function get levelLeft():Number{
            return 0;
        }

        /**
         * Y of the top edge of the level
         */
        public function get levelTop():Number{
            return 0;
        }

        /**
         * X of the right edge of the level
         */
        public function get levelRight():Number{
            return S().levelWidth;
        }

        /**
         * Y of the bottom edge of the level
         */
        public function get levelBottom():Number{
            return S().levelHeight;
        }


        public function get maxX():Number{
            return S().levelWidth - _width;
        }

        public function get maxY():Number{
            return S().levelHeight - _height;
        }

        override public function get defaultGroup():rGroup {
            return Game.gAll;
        }
    }
}