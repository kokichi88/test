package org.as3commons.reflect
{
    import flash.utils.*;
    import org.as3commons.lang.*;

    final public class TypeProviderKind extends Object
    {
        private var _value:String;
        private static var _enumCreated:Boolean = false;
        private static const _items:Dictionary = new Dictionary();
        public static const JSON:TypeProviderKind = new TypeProviderKind(JSON_NAME);
        public static const XML:TypeProviderKind = new TypeProviderKind(XML_NAME);
        private static const JSON_NAME:String = "JSONTypeProvider";
        private static const XML_NAME:String = "XMLTypeProvider";

        public function TypeProviderKind(param1:String)
        {
            Assert.state(!_enumCreated, "TypeProviderKind enumeration has already been created");
            this._value = param1;
            _items[this._value] = this;
            return;
        }// end function

        public function get value() : String
        {
            return this._value;
        }// end function

        public function toString() : String
        {
            return StringUtils.substitute("[TypeProviderKind(value=\'{0}\')]", this.value);
        }// end function

        public static function fromValue(param1:String) : TypeProviderKind
        {
            return _items[param1] as ;
        }// end function

        _enumCreated = true;
    }
}
