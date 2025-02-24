/*
 * Copyright (c) 2009-2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.swiftsuspenders {
    import flash.system.ApplicationDomain;
    import flash.utils.Dictionary;
    import flash.utils.getQualifiedClassName;

    import org.swiftsuspenders.injectionpoints.InjectionPointBase;
    import org.swiftsuspenders.injectionresults.InjectClassResult;
    import org.swiftsuspenders.injectionresults.InjectOtherRuleResult;
    import org.swiftsuspenders.injectionresults.InjectSingletonResult;
    import org.swiftsuspenders.injectionresults.InjectValueResult;

    public class Injector {
        private var m_applicationDomain:ApplicationDomain;
        private var m_mappings:Dictionary;
        private var m_attendedToInjectees:Dictionary;
        private var _reflector:Reflector;

        public function Injector() {
            _reflector = new Reflector();

            m_mappings = new Dictionary();
            m_attendedToInjectees = new Dictionary(true);
        }

        public function mapValue(whenAskedFor:Class, useValue:Object, named:String = ""):* {
            var config:InjectionConfig = getMapping(whenAskedFor, named);
            config.setResult(new InjectValueResult(useValue));
            return config;
        }

        public function mapClass(whenAskedFor:Class, instantiateClass:Class, named:String = ""):* {
            var config:InjectionConfig = getMapping(whenAskedFor, named);
            config.setResult(new InjectClassResult(instantiateClass));
            return config;
        }

        public function mapSingleton(whenAskedFor:Class, named:String = ""):* {
            return mapSingletonOf(whenAskedFor, whenAskedFor, named);
        }

        public function mapSingletonOf(whenAskedFor:Class, useSingletonOf:Class, named:String = ""):* {
            var config:InjectionConfig = getMapping(whenAskedFor, named);
            config.setResult(new InjectSingletonResult(useSingletonOf));
            return config;
        }

        public function mapRule(whenAskedFor:Class, useRule:*, named:String = ""):* {
            var config:InjectionConfig = getMapping(whenAskedFor, named);
            config.setResult(new InjectOtherRuleResult(useRule));
            return useRule;
        }

        public function getMapping(whenAskedFor:Class, named:String = ""):InjectionConfig {
            var requestName:String = getQualifiedClassName(whenAskedFor);
            var config:InjectionConfig = m_mappings[requestName + '#' + named];
            if (!config) {
                config = m_mappings[requestName + '#' + named] = new InjectionConfig(whenAskedFor, named);
            }
            return config;
        }

        public function injectInto(target:Object):void {
            if (m_attendedToInjectees[target]) {
                return;
            }
            m_attendedToInjectees[target] = true;

            //get injection points or cache them if this target's class wasn't encountered before
            var targetClass:Class = getConstructor(target);
            var injecteeDescription:InjecteeDescription = _reflector.getInjectionPoints(targetClass);

            var injectionPoints:Array = injecteeDescription.injectionPoints;
            var length:int = injectionPoints.length;
            for (var i:int = 0; i < length; i++) {
                var injectionPoint:InjectionPointBase = injectionPoints[i];
                injectionPoint.applyInjection(target, this);
            }
        }

        public function instantiate(clazz:Class):* {
            var injecteeDescription:InjecteeDescription = _reflector.getInjectionPoints(clazz);

            var injectionPoint:InjectionPointBase = injecteeDescription.constructor;
            var instance:* = injectionPoint.applyInjection(clazz, this);
            injectInto(instance);
            return instance;
        }

        public function cacheClassMappings(clazz:Class):void{
            _reflector.getInjectionPoints(clazz);
        }

        public function cacheClassMappingsAsync(clazz:Class):void{
            _reflector.cacheInjectionPointsAsync(clazz);
        }

        public function unmap(clazz:Class, named:String = ""):void {
            var mapping:InjectionConfig = getConfigurationForRequest(clazz, named);
            if (!mapping) {
                throw new InjectorError('Error while removing an injector mapping: ' +
                    'No mapping defined for class ' + getQualifiedClassName(clazz) +
                    ', named "' + named + '"');
            }
            mapping.setResult(null);
        }

        public function hasMapping(clazz:Class, named:String = ''):Boolean {
            var mapping:InjectionConfig = getConfigurationForRequest(clazz, named);
            if (!mapping) {
                return false;
            }
            return mapping.hasResponse(this);
        }

        public function getInstance(clazz:Class, named:String = ''):* {
            var mapping:InjectionConfig = getConfigurationForRequest(clazz, named);
            if (!mapping || !mapping.hasResponse(this)) {
                throw new InjectorError('Error while getting mapping response: ' +
                    'No mapping defined for class ' + getQualifiedClassName(clazz) +
                    ', named "' + named + '"');
            }
            return mapping.getResponse(this);
        }

        public function getApplicationDomain():ApplicationDomain {
            return m_applicationDomain ? m_applicationDomain : ApplicationDomain.currentDomain;
        }

        private function getConfigurationForRequest(clazz:Class, named:String):InjectionConfig {
            var requestName:String = getQualifiedClassName(clazz);
            var config:InjectionConfig = m_mappings[requestName + '#' + named];

            return config;
        }
    }
}