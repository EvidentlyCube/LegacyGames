
package net.retrocade.tacticengine.core.injector {
    public function injectCreate(clazz:Class, ...initParams):* {
        initParams.unshift(clazz);

        return MonstroInjector.create.apply(null, initParams);
    }
}
