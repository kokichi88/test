package org.as3commons.reflect
{
    import flash.utils.*;
    import org.as3commons.lang.*;

    final public class AccessorAccess extends Object
    {
        private var _name:String;
        private static const _lookup:Dictionary = new Dictionary();
        private static var _enumCreated:Boolean = false;
        public static const READ_ONLY:AccessorAccess = new AccessorAccess(READ_ONLY_VALUE);
        public static const WRITE_ONLY:AccessorAccess = new AccessorAccess(WRITE_ONLY_VALUE);
        public static const READ_WRITE:AccessorAccess = new AccessorAccess(READ_WRITE_VALUE);
        private static const READ_ONLY_VALUE:String = "readonly";
        private static const WRITE_ONLY_VALUE:String = "writeonly";
        private static const READ_WRITE_VALUE:String = "readwrite";

        public function AccessorAccess(param1:String)
        {
            Assert.state(!_enumCreated, "AccessorAccess enum was already created");
            this._name = param1;
            _lookup[this._name] = this;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public static function fromString(param1:String) : AccessorAccess
        {
            return _lookup[param1] as AccessorAccess;
        }// end function

        _enumCreated = true;
    }
}
