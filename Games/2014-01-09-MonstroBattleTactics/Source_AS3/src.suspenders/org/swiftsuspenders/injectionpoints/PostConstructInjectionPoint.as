/*
 * Copyright (c) 2009 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.swiftsuspenders.injectionpoints {
    import org.swiftsuspenders.Injector;

    public class PostConstructInjectionPoint extends InjectionPointBase {
        protected var methodName:String;
        protected var orderValue:int;

        public function PostConstructInjectionPoint(node:XML) {
            super(node);
        }

        override public function applyInjection(target:Object, injector:Injector):Object {
            target[methodName]();
            return target;
        }

        override protected function initializeInjection(node:XML):void {
            var orderArg:XMLList = node.arg.(@key == 'order');
            var methodNode:XML = node.parent();
            orderValue = int(orderArg.@value);
            methodName = methodNode.@name.toString();
        }

        public function get order():int {
            return orderValue;
        }
    }
}