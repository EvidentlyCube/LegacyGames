/*
 * Copyright (c) 2009 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.swiftsuspenders {
    import flash.utils.Dictionary;
    import flash.utils.describeType;
    import flash.utils.setTimeout;

    import org.swiftsuspenders.injectionpoints.ConstructorInjectionPoint;
    import org.swiftsuspenders.injectionpoints.InjectionPointBase;
    import org.swiftsuspenders.injectionpoints.MethodInjectionPoint;
    import org.swiftsuspenders.injectionpoints.NoParamsConstructorInjectionPoint;
    import org.swiftsuspenders.injectionpoints.PostConstructInjectionPoint;
    import org.swiftsuspenders.injectionpoints.PropertyInjectionPoint;

    public class Reflector {
        private var _descriptionsCache:Dictionary = new Dictionary();

        private var _asynchronousClassDescribeQueue:Vector.<Class> = new Vector.<Class>();
        private var _isAsyncOperationRunning:Boolean = false;

        public function getInjectionPoints(clazz:Class):InjecteeDescription {
            if (_descriptionsCache[clazz]) {
                return _descriptionsCache[clazz];
            }

            var injecteeDescription:InjecteeDescription = new InjecteeDescription();

            var typeDescriptionXml:XML = describeType(clazz);
            if (typeDescriptionXml.@name != 'Object' && typeDescriptionXml.factory.extendsClass.length() == 0) {
                throw new InjectorError('Interfaces can\'t be used as instantiatable classes.');
            }

            //get constructor injections
            fillConstructorInjections(injecteeDescription, typeDescriptionXml, clazz);
            fillVariableInjections(injecteeDescription, typeDescriptionXml);
            fillMethodInjections(injecteeDescription, typeDescriptionXml);
            fillPostConstructorInjections(injecteeDescription, typeDescriptionXml);

            _descriptionsCache[clazz] = injecteeDescription;

            return injecteeDescription;
        }

        public function cacheInjectionPointsAsync(clazz:Class):void{
            _asynchronousClassDescribeQueue.push(clazz);

            pushAsyncCacheQueue();
        }

        private function pushAsyncCacheQueue():void{
            if (!_isAsyncOperationRunning){
                _isAsyncOperationRunning = true;

                asyncCacheQueueNextStep(
                    0,
                    new InjecteeDescription(),
                    null,
                    _asynchronousClassDescribeQueue.shift()
                )
            }
        }

        private function asyncCacheQueueNextStep(currentStep:uint, injecteeDescription:InjecteeDescription, typeDescriptionXml:XML, clazz:Class):void{
            switch(currentStep){
                case(0):
                    typeDescriptionXml = describeType(clazz);
                    break;

                case(1):
                    fillConstructorInjections(injecteeDescription, typeDescriptionXml, clazz);
                    break;

                case(2):
                    fillVariableInjections(injecteeDescription, typeDescriptionXml);
                    break;

                case(3):
                    fillMethodInjections(injecteeDescription, typeDescriptionXml);
                    break;

                case(4):
                    fillPostConstructorInjections(injecteeDescription, typeDescriptionXml);
                    break;

                case(5):
                    _isAsyncOperationRunning = false;
                    _descriptionsCache[clazz] = injecteeDescription;
                    return;
            }

            setTimeout(
                asyncCacheQueueNextStep,
                30,
                currentStep + 1,
                injecteeDescription,
                typeDescriptionXml,
                clazz
            );
        }

        private static function fillConstructorInjections(injecteeDescription:InjecteeDescription, typeDescriptionXml:XML, clazz:Class):void {
            var node:XML = typeDescriptionXml.factory.constructor[0];
            if (node) {
                injecteeDescription.constructor = new ConstructorInjectionPoint(node, clazz);
            } else {
                injecteeDescription.constructor = new NoParamsConstructorInjectionPoint();
            }
        }

        private static function fillVariableInjections(injecteeDescription:InjecteeDescription, typeDescriptionXml:XML):void {
            var injectionPoint:InjectionPointBase;
            var nodes:XMLList = typeDescriptionXml.factory.*.(name() == 'variable' || name() == 'accessor').metadata.(@name == 'Inject');

            for each (var node:XML in nodes) {
                injectionPoint = new PropertyInjectionPoint(node);
                injecteeDescription.injectionPoints.push(injectionPoint);
            }
        }

        private static function fillMethodInjections(injecteeDescription:InjecteeDescription, typeDescriptionXml:XML):void {
            var injectionPoint:InjectionPointBase;
            var nodes:XMLList = typeDescriptionXml.factory.method.metadata.(@name == 'Inject');

            for each (var node:XML in nodes) {
                injectionPoint = new MethodInjectionPoint(node);
                injecteeDescription.injectionPoints.push(injectionPoint);
            }
        }

        private static function fillPostConstructorInjections(injecteeDescription:InjecteeDescription, typeDescriptionXml:XML):void {
            var injectionPoint:InjectionPointBase;
            var nodes:XMLList = typeDescriptionXml.factory.method.metadata.(@name == 'PostConstruct');

            var postConstructMethodPoints:Array = [];

            for each (var node:XML in nodes) {
                injectionPoint = new PostConstructInjectionPoint(node);
                postConstructMethodPoints.push(injectionPoint);
            }
            if (postConstructMethodPoints.length > 0) {
                postConstructMethodPoints.sortOn("order", Array.NUMERIC);
                injecteeDescription.injectionPoints.push.apply(injecteeDescription.injectionPoints, postConstructMethodPoints);
            }
        }
    }
}
