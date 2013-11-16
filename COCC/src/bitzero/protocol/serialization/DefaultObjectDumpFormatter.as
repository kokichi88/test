package bitzero.protocol.serialization
{
    import flash.utils.*;

    public class DefaultObjectDumpFormatter extends Object
    {
        public static const DOT:String = ".";
        public static const TOKEN_INDENT_CLOSE:String = "}";
        public static const TOKEN_DIVIDER:String = ";";
        public static const TAB:String = "\t";
        public static const TOKEN_INDENT_OPEN:String = "{";
        public static const NEW_LINE:String = "\n";
        public static const HEX_BYTES_PER_LINE:int = 16;

        public function DefaultObjectDumpFormatter()
        {
            return;
        }// end function

        public static function prettyPrintDump(param1:String) : String
        {
            return "dum";
        }// end function

        public static function hexDump(param1:ByteArray, param2:int = -1) : String
        {
            return param1.toString();
        }// end function

        private static function strFill(param1:String, param2:int) : String
        {
            return param1;
        }// end function

        private static function getFormatTabs(param1:int) : String
        {
            return strFill(TAB, param1);
        }// end function

    }
}
