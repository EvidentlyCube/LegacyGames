package submuncher.ingame.vfx.shatter {
    import net.retrocade.random.IRandomEngine;
    import net.retrocade.random.RandomEngineKiss;

    public class ShatterRepository {
        private static var _random:IRandomEngine;
        private static var _shatters:Vector.<Vector.<ShatterData>>;

        {init();}

        private static function init():void {
            _shatters = new Vector.<Vector.<ShatterData>>();
            _random = new RandomEngineKiss();

            var group:Vector.<ShatterData>;
            var shatter:ShatterData;

            // Shatter #1
            group = new Vector.<ShatterData>();
            shatter = new ShatterData(45, 1);
            shatter.addPoint(0.0, 0.0);
            shatter.addPoint(1.0, 0.0);
            shatter.addPoint(0.0, 1.0);
            shatter.addDirection(-135);
            group.push(shatter);
            shatter = new ShatterData(45, 1);
            shatter.addPoint(1.0, 0.0);
            shatter.addPoint(0.0, 1.0);
            shatter.addPoint(1.0, 1.0);
            shatter.addDirection(45);
            group.push(shatter);
            _shatters.push(group);

            // Shatter #2
            group = new Vector.<ShatterData>();
            shatter = new ShatterData(45, 1);
            shatter.addPoint(0.0, 0.0);
            shatter.addPoint(1.0, 0.0);
            shatter.addPoint(1.0, 1.0);
            shatter.addDirection(-45);
            group.push(shatter);
            shatter = new ShatterData(135, 1);
            shatter.addPoint(0.0, 0.0);
            shatter.addPoint(0.0, 1.0);
            shatter.addPoint(1.0, 1.0);
            shatter.addDirection(45);
            group.push(shatter);
            _shatters.push(group);
        }

        public static function get randomShatter():Vector.<ShatterData> {
            return _shatters[_random.getUintRange(0, _shatters.length)];
        }
    }
}
