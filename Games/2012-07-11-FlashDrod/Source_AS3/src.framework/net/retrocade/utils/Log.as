package net.retrocade.utils{
    import flash.utils.describeType;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;

    public class Log{
        public function Log(){ new Error("Can't instantiate Log object - please use static methods only!") }

        // ################################################################################################################################################################################ //
        // ##
        // ##                                                                                                                                             S T A T I C   V A R I A B L E S
        // ##
        // ################################################################################################################################################################################ //

        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Trace Method
        // ::::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Function which is used for logging, default is trace()
         */
        private static var _traceMethod:Function = trace;

        /**
         * Function which is used for logging, default is trace()
         */
        public static function get traceMethod():Function {
            return _traceMethod;
        }

        /**
         * @private
         */
        public static function set traceMethod(value:Function):void {
            if (value == null)
                throw new ArgumentError("Value cannot be null");

            _traceMethod = value;
        }

        
        

        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Buffer
        // ::::::::::::::::::::::::::::::::::::::::::::::::

        private static var _buffer:String = "";




        // ################################################################################################################################################################################ //
        // ##
        // ##                                                                                                                                   P U B L I C   S T A T I C   M E T H O D S
        // ##
        // ################################################################################################################################################################################ //

        // ==========================================================================================================================================
        // ==                                                                                                                   LOGGING FUNCTIONS
        // ==========================================================================================================================================

        /**
         * Shortcut to trace
         * @param string String to be traced
         */
        public static function t(string:String):void{
            _trace(string);
        }

        /**
         * Prints all the parameters specified.
         * @param string Title tag to be traced
         * @param rest List of all the other parameters to be comma sepearated and printed
         */
        public static function a(string:String, staticLength:int = 0, ...rest):void{
            var s:String = string;
            if (staticLength)
                s = UString.resizeFromRight(s, staticLength, " ", true);

            s += ": ";

            for (var i:int = 0; i < rest.length; i++){
                if (staticLength)
                    s += UString.resizeFromRight(rest[i].toString(), staticLength, " ", true);
                else
                    s += rest[i].toString();

                if (i != rest.length - 1)
                    s += ", ";
            }

            _trace(s);
        }

        /**
         * Buffers a string to be traced just before next call to any trace
         * @param string String to be buffered
         */
        public static function b(string:String):void{
            _buffer += string;
        }

        /**
         * Outputs a line break
         */
        public static function e(delimiter:String = "=", length:int = 20):void{
            _trace("=====================");
        }

        /**
         * Dumps information about a variable (based on PHP's var_dump)
         * @param to_dump Object to be dumped
         * @param offset Left margin of trace
         */
        public static function var_dump(to_dump:*, complex:Boolean = false, leftOffset:uint = 0):void{
            if (leftOffset >= 10)
                return _trace("Too deep!");

            var offsetL:String = UString.repeat(" ", leftOffset - 2);
            var offsetM:String = UString.repeat(" ", leftOffset);
            var offsetR:String = UString.repeat(" ", leftOffset + 2);

            switch(typeof(to_dump)){
                case("number"):
                case("string"):
                case("boolean"):
                    return _trace("(" + getQualifiedClassName(to_dump) + ") " + to_dump.toString());

                case("xml"):
                    return _trace("(" + getQualifiedClassName(to_dump) + ") " + to_dump.toXMLString());

                case("object"):
                    var name:String = getQualifiedClassName(to_dump);
                    trace(name);
                    if (!complex || to_dump is Array || name == "Object"){
                        _trace("(" + getQualifiedClassName(to_dump) + ") {");
                        for(var key:String in to_dump){
                            b(offsetR + "[" + key + "] => ");
                            var_dump(to_dump[key], complex, leftOffset + 2);
                        }

                    } else {
                        if (name == "null")
                            return _trace("(null)");

                        name = name.substr(name.indexOf("::") + 2);
                        _trace("(" + name + ") {");

                        var xml:* = describeType(to_dump);
                        if (xml.factory != undefined)
                            xml = xml.factory;

                        xml = xml.children();

                        for each(var i:XML in xml){
                            if ((i.name() == "accessor" || i.name() == "variable") && i.@access != "writeonly"){
                                b(offsetR + "[" + i.@name + "] => ");
                                if (to_dump[i.@name] == null)
                                    _trace("(" + i.@type + ") null");
                                else
                                    var_dump(to_dump[i.@name], complex, leftOffset + 2);
                            }
                        }
                    }
                    _trace(offsetM + "}");
            }
        }



        // ################################################################################################################################################################################ //
        // ##
        // ##                                                                                                                                 P R I V A T E   S T A T I C   M E T H O D S
        // ##
        // ################################################################################################################################################################################ //

        /**
         * Checks if session is enabled and traces if yes
         * @param txt Text to be traced
         */
        private static function _trace(txt:String):void{
            _traceMethod(_buffer + txt);

            _buffer = "";
        }

        // ################################################################################################################################################################################ //
        // ##
        // ##                                                                                                                                                 P U B L I C   M E T H O D S
        // ##
        // ################################################################################################################################################################################ //

        public function t(string:String):void{
            Log.t(string);
        }

        public function a(string:String, staticLength:int = 0, ...rest):void{
            Log.a.apply(null, ([string, staticLength]).concat(rest));
        }
    }
}