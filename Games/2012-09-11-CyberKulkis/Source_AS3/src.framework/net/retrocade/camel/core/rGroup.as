package net.retrocade.camel.core{
    import net.retrocade.camel.objects.rObject;
    import net.retrocade.utils.Rand;

    public class rGroup extends rObject{
        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Items Array
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * An array of group's objects
         */
        protected var _items:Array;

        /**
         * Returns the amount of not nulled elements in the group
         */
        public function get length():uint{
            return _length - _nulled;
        }

        /**
         * Length of the items arrays
         */
        protected var _length:Number = 0;



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Counts
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * HELPER: Counts how many elements were nulled
         */
        protected var _nulled:uint = 0;

        /**
         * How many objects are nulled right now
         */
        public function get nulled():uint{
            return _nulled;
        }

        /**
         * Amount of Null variables in list which should turn the GC on automatically
         */
        public var gcThreshold:uint = 10;

        /**
         * If true automatic GC will use advanced garbage collection
         */
        public var gcAdvanced :Boolean = false;




        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        /**
         * Constructor
         */
        public function rGroup(){
            _items = [];
            active = true;
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Adding
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Adds an object at the end of the group
         * @param object rObject to be added to the group
         */
        public function add(object:rObject):void{
            _items[_length++] = object;
        }

        /**
         * Adds an object to the group at specified index
         * @param object rObject to be added to the group
         * @param index Index where to add the item to the group
         */
        public function addAt(object:rObject, index:uint):void{
            if (index > _length)
                _items.length = index - 1;

            _items.splice(index, 0, object);
            _length = _items.length;
        }


        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Checking
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Checks if specified object is added to given group
         * @param object Object to check
         * @return True if this object already resides in the group
         */
        public function contains(object:rObject):Boolean{
            return _items.indexOf(object) != -1;
        }

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Garbage Collecting
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Removes all Nulled objects from group and fills gap with items from the end of the list.
         * Order is not retained
         */
        public function garbageCollect():void{
            var l:uint = _length;
            var i:uint = 0;

            for (;i < l; ++i){
                while (_items[i] == null && i < l){
                    _items[i] = _items[--l];
                }
            }

            _items.length = l;
            _nulled       = 0;
            _length       = l;
        }

        /**
         * Splices all Nulled objects from group, Order is retained.
         */
        public function garbageCollectAdvanced():void{
            var l  :uint = _length;
            var i  :uint = 0;
            var gap:uint = 0;

            for (;i < l; i++){
                if (_items[i] == null)
                    gap++;

                else if (gap)
                    _items[i - gap] = _items[i];
            }

            _length       -= gap;
            _items.length -= gap;
            _nulled        = 0;


        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Retrieving
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Retrieves an rObject from a given index position
         * @param    index An index position of the object to be retrieved
         * @return rObject located at given index
         */
        public function getAt(index:uint):rObject {
            if (index < _length)
                return _items[index];
            return null;
        }

        /**
         * Retrieves a randomly selected rObject
         * @return A randomly selected rObject
         */
        public function getRandom():rObject {
            if (length == 0)
                return null;

            var item:*;

            while (!item)
                item = _items[_length * Rand.om | 0]

            return item;
        }

        /**
         * Returns an array of all objects
         * @return Array of all objects
         */
        public function getAll():Array{
            return _items.concat();
        }

        /**
         * Returns an array of all objects, the original array used by group. Do NOT modify it!
         * @return Array of all objects
         */
        public function getAllOriginal():Array{
            return _items.concat();
        }

        /**
         * Returns the first not null object stored
         * @return First not null object, or null if there are none
         */
        public function getFirst():rObject {
            var i:uint = 0;
            while (i < _length) {
                if (_items[i++])
                    return _items[i - 1];
            }
            return null;
        }

        /**
         * Returns the index of the object added or -1 if not found
         * @param object Object which index you want to check
         * @return Index of the object in the group or -1 if the object was not found
         */
        public function getIndexOf(object:rObject):int{
            return _items.indexOf(object);
        }

        /**
         * Returns the index of the object added as if all nullified monsters
         * were already garbage collected or -1 if not found
         * @param object Object which index you want to check
         * @return Index of the object in the group or -1 if the object was not found
         */
        public function getIndexOfExcludingNull(object:rObject):int{
            var i  :uint = 0;
            var pos:uint = 0;
            var l  :uint = _items.length;
            var item:*;

            for (; i < l; i++ ) {
                if ((item = _items[i]) == null)
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
           _items.length = 0;
           _length = 0;
           _nulled = 0;
        }

        /**
         * Nulls the specified object from the group
         * @param object Object to be nulled
         */
        public function nullify(object:rObject):void{
            var index:int = _items.indexOf(object);
            if (index == -1)
                return;

            _nulled++;
            _items[index] = null;
        }

        /**
         * Nulls an object from the group at the specified index
         * @param index Index at which an object has to be nulled
         */
        public function nullifyAt(index:uint):void{
            if (index < _items.length){
                if (_items[index] != null)
                    _nulled++;

                _items[index] = null;
            }
        }

        /**
         * Removes the specified object from the group using splice
         * @param object Object to be removed
         */
        public function remove(object:rObject):void{
            var index:int = _items.indexOf(object);
            if (index == -1)
                return;

            _length--;
            _items.splice(index, 1);
        }

        /**
         * Removes an object from the group at the specified index using splice
         * @param index Index at which an object has to be removed
         */
        public function removeAt(index:uint):void{
            if (index < _length){
                _items.splice(index, 1);
                _length--;
            }
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Updating
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Calls update on all active elements
         */
        override public function update():void{
            for(var o:rObject, i:int = 0, l:int = _length; i < l; i++){
                o = _items[i];
                if (o && o.active)
                    o.update();
            }

            // Garbage Collect
            if (_nulled > gcThreshold) {
                if (gcAdvanced) garbageCollectAdvanced(); else garbageCollect();
            }
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Miscellanous
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Counts amount of objects which returned tru when checked agains given function
         * @param closure Function to be checked against
         * @return Amount of objects which pass the closure call with true
         */
        public function countByFunction(closure:Function):uint{
            var count:uint = 0;

            for(var o:rObject, i:int = 0; i < _length; i++){
                o = _items[i];
                if (o != null && closure.apply(o))
                    count++;
            }

            return count;
        }

        /**
         * Returns an object that matches the function
         * @param closure Function be check the object against
         * @return An instance that returned true for closure
         */
        public function getOneByFunction(closure:Function):rObject{
            for(var o:rObject, i:int = 0; i < _length; i++){
                o = _items[i];
                if (o != null && closure.apply(o))
                    return o;
            }

            return null;
        }

        /**
         * Returns all object that match the function
         * @param closure Function be check the object against
         * @return All objects that returned true for the closure
         */
        public function getAllByFunction(closure:Function):Array{
            var array:Array = [];
            for(var o:rObject, i:int = 0; i < _length; i++){
                o = _items[i];
                if (o != null && closure.apply(o))
                    array.push(o);
            }

            return array;
        }

        /**
         * Calls given function on all objects
         * @param closure Function to be called on each object
         */
        public function callOnAll(closure:Function):void{
            for(var i:int = 0; i < _length; i++)
                closure.apply(_items[i]);
        }

        /**
         * Calls the given function by name on each object and passes the params specified in the array
         * @param functionName Name of the function to call
         * @param params Array of parameters
         */
        public function applyOfAll(functionName:String, params:Array = null):void{
            var item:*;
            for(var i:int = 0; i < _length; i++){
                item = _items[i];
                if (item && item.hasOwnProperty(functionName))
                    Function(item[functionName]).apply(item, params);
            }
        }

        /**
         * Calls the given function by name on each object and passes the params specified
         * @param functionName Name of the function to call
         * @param params Parameters
         */
        public function callOfAll(functionName:String, ...params):void{
            var item:*;
            for(var i:int = 0; i < _length; i++){
                item = _items[i];
                if (item && item.hasOwnProperty(functionName))
                    item[functionName].apply(item, params);
            }
        }
    }
}