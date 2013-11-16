package avmplus
{

    final public class DescribeType extends Object
    {
        public static const HIDE_NSURI_METHODS:uint = 1;
        public static const INCLUDE_BASES:uint = 2;
        public static const INCLUDE_INTERFACES:uint = 4;
        public static const INCLUDE_VARIABLES:uint = 8;
        public static const INCLUDE_ACCESSORS:uint = 16;
        public static const INCLUDE_METHODS:uint = 32;
        public static const INCLUDE_METADATA:uint = 64;
        public static const INCLUDE_CONSTRUCTOR:uint = 128;
        public static const INCLUDE_TRAITS:uint = 256;
        public static const USE_ITRAITS:uint = 512;
        public static const HIDE_OBJECT:uint = 1024;
        public static const FLASH10_FLAGS:uint = FLASH10_FLAGS;
        public static const ACCESSOR_FLAGS:uint = INCLUDE_TRAITS | INCLUDE_ACCESSORS;
        public static const INTERFACE_FLAGS:uint = INCLUDE_TRAITS | INCLUDE_INTERFACES;
        public static const METHOD_FLAGS:uint = INCLUDE_TRAITS | INCLUDE_METHODS;
        public static const VARIABLE_FLAGS:uint = INCLUDE_TRAITS | INCLUDE_VARIABLES;
        public static const GET_INSTANCE_INFO:uint = INCLUDE_BASES | INCLUDE_INTERFACES | INCLUDE_VARIABLES | INCLUDE_ACCESSORS | INCLUDE_METHODS | INCLUDE_METADATA | INCLUDE_CONSTRUCTOR | INCLUDE_TRAITS | USE_ITRAITS;
        public static const GET_CLASS_INFO:uint = INCLUDE_INTERFACES | INCLUDE_VARIABLES | INCLUDE_ACCESSORS | INCLUDE_METHODS | INCLUDE_METADATA | INCLUDE_TRAITS | HIDE_OBJECT;

        public function DescribeType()
        {
            return;
        }// end function

        public static function getJSONFunction() : Function
        {
            try
            {
                return describeTypeJSON;
            }
            catch (e)
            {
            }
            return null;
        }// end function

    }
}
