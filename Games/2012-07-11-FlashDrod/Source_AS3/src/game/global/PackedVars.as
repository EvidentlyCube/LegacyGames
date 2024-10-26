package game.global{
    import flash.utils.ByteArray;
    import flash.utils.Endian;

    import net.retrocade.utils.UByteArray;

    public class PackedVars{
        private var vars:Array = [];

        public function PackedVars(buffer:ByteArray = null) {
            if (buffer)
                unpack(buffer);
        }

        public function unpack(buffer:ByteArray):void{
            if (buffer.length < 4)
                return;

            buffer.endian = Endian.LITTLE_ENDIAN;

            var varNameLength:uint = 0;
            var newVar:UnpackedVar;

            //Packed variable buffer format is:
            //{VarNameSize1 UINT}{VarName1 SZ}{VarType1 int}{VarValueSize1 DWORD}{VarValue1}
            //{VarNameSize2 UINT}...
            //{EndCode UINT}

            //Remove any vars that have been previously unpacked.
            clear();

            //Check for empty buffer.
            var index:uint = 0;

            if (buffer.length == 0) return;// goto Cleanup;  //Success--nothing to unpack.
            if (buffer[index] == 0) return;// goto Cleanup; //Success--nothing to unpack.

            buffer.position = index;
            varNameLength   = buffer.readUnsignedInt();

            index += 4;

            while (varNameLength != 0)
            {
                ASSERT(varNameLength < 256); //256 = reasonable limit to var name size.
                if (varNameLength >= 256) {
                    clear();
                    return;
                }

                //Get var name.
                var varName:String = "";

                buffer.position = index;
                varName = buffer.readUTFBytes(varNameLength);

                /*ASSERT(varName.charCodeAt(varNameLength - 1) == 0); //Var name s/b null-terminated.
                if (varName.charCodeAt(varNameLength - 1) != 0) {
                clear();
                return;
                }*/

                index += varNameLength;

                //Create new packed var.
                newVar = new UnpackedVar();
                newVar.name = varName;

                // Get var type
                buffer.position = index;
                newVar.type = buffer.readUnsignedInt();
                index += 4;

                // Get var size
                buffer.position = index;
                newVar.length = buffer.readInt();
                index += 4;

                // Get actual var
                buffer.position = index;
                switch(newVar.type){
                    case(C.UVT_bool):
                        newVar.value = buffer.readBoolean();
                        index += 1;
                        break;

                    case(C.UVT_byte):
                        newVar.value = buffer.readByte();
                        index += 1;
                        break;

                    case(C.UVT_byte_buffer):
                        (newVar.value = new ByteArray()).writeBytes(buffer, index, newVar.length);
                        index += newVar.length;
                        break;

                    case(C.UVT_char_string):
                        newVar.value = buffer.readUTFBytes(newVar.length);
                        index += newVar.length;
                        break;

                    case(C.UVT_int):
                        newVar.value = buffer.readInt();
                        index += 4;
                        break;

                    case(C.UVT_uint):
                        newVar.value = buffer.readUnsignedInt();
                        index += 4;
                        break;

                    case(C.UVT_wchar_string):
                        newVar.value = UByteArray.readWChar(buffer, index, newVar.length);
                        index += newVar.length;
                        break;
                }

                vars[newVar.name] = newVar;

                if (index >= buffer.length -1)
                    varNameLength = 0;

                else {
                    buffer.position = index;
                    varNameLength = buffer.readUnsignedInt();
                    index += 4;
                }
            }
        }

        public function pack():ByteArray {
            var buffer:ByteArray = new ByteArray();

            buffer.endian = Endian.LITTLE_ENDIAN;

            for each(var variable:UnpackedVar in vars) {
                buffer.writeUnsignedInt(variable.name.length + 1);
                buffer.writeUTFBytes   (variable.name);
                buffer.writeByte       (0); // Null terminated string

                buffer.writeUnsignedInt(variable.type);
                switch(variable.type) {
                    case(C.UVT_bool):
                        buffer.writeUnsignedInt(1);
                        buffer.writeUnsignedInt(variable.value);
                    break;
                    case(C.UVT_byte):
                        buffer.writeUnsignedInt(1);
                        buffer.writeUnsignedInt(variable.value);
                    break;
                    case(C.UVT_byte_buffer):
                        var _ba:ByteArray = variable.value as ByteArray;
                        _ba.position = 0;
                        buffer.writeUnsignedInt(_ba.length);
                        buffer.writeBytes(_ba);
                    break;
                    case(C.UVT_char_string):
                        var _s:String = variable.value as String;
                        buffer.writeUnsignedInt(_s.length);
                        buffer.writeUTFBytes   (_s);
                    break;
                    case(C.UVT_int):
                        buffer.writeUnsignedInt(4);
                        buffer.writeInt(variable.value);
                    break;
                    case(C.UVT_uint):
                        buffer.writeUnsignedInt(4);
                        buffer.writeUnsignedInt(variable.value);
                    break;
                    case(C.UVT_wchar_string):
                        var _sw:String = variable.value as String;
                        buffer.writeUnsignedInt(_sw.length * 2);
                        UByteArray.writeWChar(buffer, _sw);
                    break;
                }
            }

            buffer.writeByte(0);

            buffer.position = 0;

            return buffer;
        }

        public function clone():PackedVars {
            var c:PackedVars = new PackedVars();

            for (var i:String in vars) {
                c.vars[i] = UnpackedVar(vars[i]).clone();
            }

            return c;
        }

        public function clear():void{
            for each(var unpackedVar:UnpackedVar in vars) {
                unpackedVar.clear();
            }

            vars = [];
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Setters
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public function setInt(name:String, to:int):void{
            var unpackedVar:UnpackedVar = vars[name] || null;
            if (!unpackedVar || unpackedVar.type != C.UVT_int){
                unpackedVar        = new UnpackedVar();
                unpackedVar.name   = name;
                unpackedVar.length = 4;
                unpackedVar.type   = C.UVT_int;

                vars[name] = unpackedVar;
            }

            unpackedVar.value = to;
        }

        public function setUint(name:String, to:uint):void {
            var unpackedVar:UnpackedVar = vars[name] || null;
            if (!unpackedVar || unpackedVar.type != C.UVT_uint){
                unpackedVar        = new UnpackedVar();
                unpackedVar.name   = name;
                unpackedVar.length = 4;
                unpackedVar.type   = C.UVT_uint;

                vars[name] = unpackedVar;
            }

            unpackedVar.value = to;
        }

        public function setString(name:String, to:String):void{
            var unpackedVar:UnpackedVar = vars[name] || null;
            if (!unpackedVar || unpackedVar.type != C.UVT_char_string){
                unpackedVar        = new UnpackedVar();
                unpackedVar.name   = name;
                unpackedVar.type   = C.UVT_char_string;

                vars[name] = unpackedVar;
            }

            unpackedVar.value = to;
            unpackedVar.length = to.length;
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Getters
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public function getBool(name:String, def:Boolean = false):Boolean {
            if (vars[name]) {
                ASSERT(vars[name].type == C.UVT_bool);
                return vars[name].value;
            }

            return def;
        }

        public function getByte(name:String, def:uint = 0):uint {
            ASSERT(def < 256);

            if (vars[name]) {
                ASSERT(vars[name].type == C.UVT_byte);
                return vars[name].value;
            }

            return def;
        }

        public function getByteArray(name:String, def:ByteArray = null):ByteArray {
            if (vars[name]) {
                ASSERT(vars[name].type == C.UVT_byte_buffer);
                vars[name].value.position = 0;
                return vars[name].value;
            }

            return def;
        }

        public function getString(name:String, def:String = ""):String {
            if (vars[name]) {
                ASSERT(vars[name].type == C.UVT_char_string ||
                    vars[name].type == C.UVT_wchar_string);
                return vars[name].value;
            }

            return def;
        }

        public function getInt(name:String, def:int = 0):int {
            if (vars[name]) {
                ASSERT(vars[name].type == C.UVT_int);
                return vars[name].value;
            }

            return def;
        }

        public function getUint(name:String, def:uint = 0):uint {
            if (vars[name]) {
                ASSERT(vars[name].type == C.UVT_uint);
                return vars[name].value;
            }

            return def;
        }

        public function typeOf(name:String):uint{
            var unpackedVar:UnpackedVar = vars[name] || null;

            return (unpackedVar ? unpackedVar.type : C.UVT_unknown);
        }
    }
}
import flash.utils.ByteArray;
import net.retrocade.utils.UByteArray;

internal class UnpackedVar{
    public var name  :String;
    public var length:uint;
    public var value :*;
    public var type  :int;

    public function clear():void {
        name   = null;
        length = 0;
        value  = undefined;
        type   = 0;
    }

    public function clone():UnpackedVar {
        var c:UnpackedVar = new UnpackedVar;
        c.name   = name;
        c.length = length;
        c.type   = type;

        if (value is ByteArray)
            c.value = UByteArray.clone(value);
        else
            c.value = value;

        return c;
    }
}