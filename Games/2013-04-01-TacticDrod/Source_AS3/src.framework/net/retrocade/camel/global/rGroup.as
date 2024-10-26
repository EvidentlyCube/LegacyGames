package net.retrocade.camel.global{
    import net.retrocade.camel.interfaces.rIUpdatable;
    import net.retrocade.utils.Rand;

    final public class rGroup implements rIUpdatable{
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

        /**
         * HELPER: True if the group is currently updating
         */ 
        protected var isUpdating:Boolean = false;

        /**
         * HELPER: Index of the currently updated element
         */ 
        protected var updatingIndex:int = -1;


        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        /**
         * Constructor
         */
        public function rGroup(){
            _items = [];
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Adding
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Adds an object at the end of the group
         * @param object rIUpdatable to be added to the group
         */
        public function add(object:rIUpdatable):void{
            _items[_length++] = object;
        }

        /**
         * Adds an object to the group at specified index
         * @param object rIUpdatable to be added to the group
         * @param index Index where to add the item to the group
         */
        public function addAt(object:rIUpdatable, index:uint):void{
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
        public function contains(object:rIUpdatable):Boolean{
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
         * Retrieves an rIUpdatable from a given index position
         * @param    index An index position of the object to be retrieved
         * @return rIUpdatable located at given index
         */
        public function getAt(index:uint):rIUpdatable {
            if (index < _length)
                return _items[index];
            return null;
        }

        /**
         * Retrieves a randomly selected rIUpdatable
         * @return A randomly selected rIUpdatable
         */
        public function getRandom():rIUpdatable {
            if (length == 0)
                return null;

            var index:int = Rand.i(0, _length);
            var item:* = _items[index];

            while (!item)
                item = _items[(index = index+1 % _length)];

            return item;
        }

        /**
         * Returns a copy of an array of all objects (pretty slow)
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
        public function getFirst():rIUpdatable {
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
        public function getIndexOf(object:rIUpdatable):int{
            return _items.indexOf(object);
        }

        /**
         * Returns the index of the object added as if all nullified entries
         * were already garbage collected or -1 if not found
         * @param object Object which index you want to check
         * @return Index of the object in the group or -1 if the object was not found
         */
        public function getIndexOfExcludingNull(object:rIUpdatable):int{
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
        public function nullify(object:rIUpdatable):void{
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
        public function remove(object:rIUpdatable):void{
            var index:int = _items.indexOf(object);
            if (index == -1)
                return;

            _length--;
            _items.splice(index, 1);
            
            if (isUpdating && index < updatingIndex)
                updatingIndex--;
        }

        /**
         * Removes an object from the group at the specified index using splice
         * @param index Index at which an object has to be removed
         */
        public function removeAt(index:uint):void{
            if (index < _length){
                _items.splice(index, 1);
                _length--;
                
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
                for(var o:rIUpdatable; updatingIndex < _length; updatingIndex++){
                    o = _items[updatingIndex];
                    
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
            if (_nulled > gcThreshold) {
                if (gcAdvanced) garbageCollectAdvanced(); else garbageCollect();
            }
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Miscellanous
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Counts amount of objects which returned tru when checked agains given function
         * @param closure Function to be checked against function(o:rIUpdatable):Boolean;
         * @return Amount of objects which pass the closure call with true
         */
        public function countByFunction(closure:Function):uint{
            var count:uint = 0;

            for(var o:rIUpdatable, i:int = 0; i < _length; i++){
                o = _items[i];
                if (o != null && closure.apply(o))
                    count++;
            }

            return count;
        }

        /**
         * Returns an object that matches the function
         * @param closure Function be check the object against function(o:rIUpdatable):Boolean;
         * @return An instance that returned true for closure
         */
        public function getOneByFunction(closure:Function):rIUpdatable{
            for(var o:rIUpdatable, i:int = 0; i < _length; i++){
                o = _items[i];
                if (o != null && closure.apply(o))
                    return o;
            }

            return null;
        }

        /**
         * Returns all object that match the function
         * @param closure Function be check the object against function(o:rIUpdatable):Boolean;
         * @return All objects that returned true for the closure
         */
        public function getAllByFunction(closure:Function):Array{
            var array:Array = [];
            for(var o:rIUpdatable, i:int = 0; i < _length; i++){
                o = _items[i];
                
                if (o != null && closure.apply(o))
                    array.push(o);
            }

            return array;
        }

        /**
         * Calls given function with all objects
         * @param closure Function to be called with each object function(o:rIUpdatable):Boolean;
         */
        public function callOnAll(closure:Function):void{
            for(var i:int = 0; i < _length; i++)
                closure.apply(_items[i]);
        }

        /**
         * Calls the function of given name on each object and passes the params specified in the array
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