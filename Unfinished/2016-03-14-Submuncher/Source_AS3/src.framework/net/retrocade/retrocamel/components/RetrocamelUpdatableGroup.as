/*
 * Copyright (C) 2013 Maurycy Zarzycki
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package net.retrocade.retrocamel.components{
    import net.retrocade.random.Random;

    import net.retrocade.retrocamel.interfaces.IRetrocamelUpdatable;

    final public class RetrocamelUpdatableGroup implements IRetrocamelUpdatable{
        /**
         * An array of group's objects
         */
        protected var _objects:Array;

        /**
         * Returns the amount of not nulled elements in the group
         */
        public function get length():uint{
            return _objectsArrayLength - _nulledObjectsCount;
        }

        /**
         * Length of the items arrays
         */
        protected var _objectsArrayLength:Number = 0;



        /**
         * HELPER: Counts how many elements were nulled
         */
        protected var _nulledObjectsCount:uint = 0;

        /**
         * How many objects are nulled right now
         */
        public function get nulledObjectsCount():uint{
            return _nulledObjectsCount;
        }

        /**
         * Amount of Null variables in list which should turn the GC on automatically
         */
        public var gcThreshold:uint = 10;

        /**
         * If true automatic GC will use advanced garbage collection
         */
        public var useAdvancedGc :Boolean = false;

        /**
         * HELPER: True if the group is currently updating
         */ 
        protected var isUpdating:Boolean = false;

        /**
         * HELPER: Index of the currently updated element
         */ 
        protected var updatingIndex:int = -1;

        /**
         * Constructor
         */
        public function RetrocamelUpdatableGroup(){
            _objects = [];
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Adding
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Adds an object at the end of the group
         * @param object rIUpdatable to be added to the group
         */
        public function add(object:IRetrocamelUpdatable):void{
            _objects[_objectsArrayLength++] = object;
        }

        /**
         * Adds an object to the group at specified index
         * @param object rIUpdatable to be added to the group
         * @param index Index where to add the item to the group
         */
        public function addAt(object:IRetrocamelUpdatable, index:uint):void{
            if (index > _objectsArrayLength){
                _objects.length = index - 1;
            }

            _objects.splice(index, 0, object);
            _objectsArrayLength = _objects.length;
        }


        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Checking
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Checks if specified object is added to given group
         * @param object Object to check
         * @return True if this object already resides in the group
         */
        public function contains(object:IRetrocamelUpdatable):Boolean{
            return _objects.indexOf(object) != -1;
        }
        
        

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Garbage Collecting
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Removes all Nulled objects from group and fills gap with items from the end of the list.
         * Order is not retained
         */
        public function garbageCollect():void{
            var l:uint = _objectsArrayLength;
            var i:uint = 0;

            for (;i < l; ++i){
                while (_objects[i] == null && i < l){
                    _objects[i] = _objects[--l];
                }
            }

            _objects.length = l;
            _nulledObjectsCount       = 0;
            _objectsArrayLength       = l;
        }

        /**
         * Splices all Nulled objects from group, Order is retained.
         */
        public function garbageCollectAdvanced():void{
            var l  :uint = _objectsArrayLength;
            var i  :uint = 0;
            var gap:uint = 0;

            for (;i < l; i++){
                if (_objects[i] == null){
                    gap++;

                } else if (gap){
                    _objects[i - gap] = _objects[i];
                }
            }

            _objectsArrayLength       -= gap;
            _objects.length -= gap;
            _nulledObjectsCount        = 0;
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Retrieving
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Retrieves an rIUpdatable from a given index position
         * @param    index An index position of the object to be retrieved
         * @return net.retrocade.retrocamel.interfaces.IRetrocamelUpdatable located at given index
         */
        public function getAt(index:uint):IRetrocamelUpdatable {
            if (index < _objectsArrayLength){
                return _objects[index];
            }

            return null;
        }

        /**
         * Retrieves a randomly selected rIUpdatable
         * @return A randomly selected rIUpdatable
         */
        public function getRandom():IRetrocamelUpdatable {
            if (length == 0)
                return null;

            var index:uint = Random.defaultEngine.getUintRange(0, _objectsArrayLength);
            var item:* = _objects[index];

            while (!item){
                item = _objects[(index = ((index+1) % _objectsArrayLength))];
            }

            return item;
        }

        /**
         * Returns a copy of an array of all objects (pretty slow)
         * @return Array of all objects
         */
        public function getAll():Array{
            return _objects.concat();
        }

        /**
         * Returns an array of all objects, the original array used by group. Do NOT modify it!
         * @return Array of all objects
         */
        public function getAllOriginal():Array{
            garbageCollect();

            return _objects;
        }

        /**
         * Returns the first not null object stored
         * @return First not null object, or null if there are none
         */
        public function getFirst():IRetrocamelUpdatable {
            var i:uint = 0;
            while (i < _objectsArrayLength) {
                if (_objects[i++]){
                    return _objects[i - 1];
                }
            }
            return null;
        }

        /**
         * Returns the index of the object added or -1 if not found
         * @param object Object which index you want to check
         * @return Index of the object in the group or -1 if the object was not found
         */
        public function getIndexOf(object:IRetrocamelUpdatable):int{
            return _objects.indexOf(object);
        }

        /**
         * Returns the index of the object added as if all nullified entries
         * were already garbage collected or -1 if not found
         * @param object Object which index you want to check
         * @return Index of the object in the group or -1 if the object was not found
         */
        public function getIndexOfExcludingNull(object:IRetrocamelUpdatable):int{
            var i  :uint = 0;
            var pos:uint = 0;
            var l  :uint = _objects.length;
            var item:*;

            for (; i < l; i++ ) {
                if ((item = _objects[i]) == null)
                    continue;

                if (item == object)
                    return pos;

                pos++;
            }

            return -1;
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Removing
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Removes all elements from the group
         */
        public function clear():void{
           _objects.length = 0;
           _objectsArrayLength = 0;
           _nulledObjectsCount = 0;
        }

        /**
         * Nulls the specified object from the group
         * @param object Object to be nulled
         */
        public function nullify(object:IRetrocamelUpdatable):void{
            var index:int = _objects.indexOf(object);
            if (index == -1)
                return;

            _nulledObjectsCount++;
            _objects[index] = null;
        }

        /**
         * Nulls an object from the group at the specified index
         * @param index Index at which an object has to be nulled
         */
        public function nullifyAt(index:uint):void{
            if (index < _objects.length){
                if (_objects[index] != null)
                    _nulledObjectsCount++;

                _objects[index] = null;
            }
        }

        /**
         * Removes the specified object from the group using splice
         * @param object Object to be removed
         */
        public function remove(object:IRetrocamelUpdatable):void{
            var index:int = _objects.indexOf(object);
            if (index == -1)
                return;

            _objectsArrayLength--;
            _objects.splice(index, 1);
            
            if (isUpdating && index < updatingIndex)
                updatingIndex--;
        }

        /**
         * Removes an object from the group at the specified index using splice
         * @param index Index at which an object has to be removed
         */
        public function removeAt(index:uint):void{
            if (index < _objectsArrayLength){
                _objects.splice(index, 1);
                _objectsArrayLength--;
                
                if (isUpdating && index < updatingIndex)
                    updatingIndex--;
            }
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Updating
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Calls update on all active elements
         */
        public function update():void{
            if (isUpdating)
                throw new Error("You can't update group when it is already in the process of updating");
            
            isUpdating = true;
            updatingIndex = 0;
            
            //try{
                for(var o:IRetrocamelUpdatable; updatingIndex < _objectsArrayLength; updatingIndex++){
                    o = _objects[updatingIndex];
                    
                    if (o)
                        o.update();
                }
            //} catch(e:*){
            //    isUpdating = false;
            //    updatingIndex = -1;
            //    
            //    throw e;
            //}
            
            isUpdating = false;
            updatingIndex = -1;

            // Garbage Collect
            if (_nulledObjectsCount > gcThreshold) {
                if (useAdvancedGc) garbageCollectAdvanced(); else garbageCollect();
            }
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Miscellanous
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public function filter(callback:Function):void {
            for (var i:int = 0; i < _objects.length; i++) {
                var object:* = _objects[i];

                if (callback(object) === false){
                    nullifyAt(i);
                }
            }
        }

        public function countBy(callback:Function):uint {
            var count:uint = 0;

            for (var i:int = 0; i < _objects.length; i++) {
                var object:* = _objects[i];

                if (object && callback(object) === true){
                    count++;
                }
            }

            return count;
        }

        public function dispose():void {
            _objects = null;
        }

        public function sort(callback:Function):void {
            this.garbageCollectAdvanced();
            _objects.sort(callback);
        }
    }
}