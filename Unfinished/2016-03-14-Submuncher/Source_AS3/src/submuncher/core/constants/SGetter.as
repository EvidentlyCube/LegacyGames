package submuncher.core.constants {
    public function SGetter():ConstsImpl {
        return ConstsImpl.instance;
    }
}

import net.retrocade.retrocamel.interfaces.IRetrocamelSettings;

class ConstsImpl implements IRetrocamelSettings{
    public static var instance:ConstsImpl = new ConstsImpl();

    public function get debug():Boolean {
        return S.debug;
    }

    public function get eventsCount():uint {
        return S.eventsCount;
    }

    public function get languages():Array {
        return S.languages;
    }

    public function get gameWidth():uint {
        return S.gameWidth;
    }

    public function get gameHeight():uint {
        return S.gameHeight;
    }
}
