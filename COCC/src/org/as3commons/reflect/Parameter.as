package org.as3commons.reflect
{
    import flash.system.*;
    import flash.utils.*;
    import org.as3commons.lang.*;

    public class Parameter extends Object implements IEquals
    {
        private var _applicationDomain:ApplicationDomain;
        private var _isOptional:Boolean;
        protected var typeName:String;
        private static const _cache:Dictionary = new Dictionary();

        public function Parameter(param1:String, param2:ApplicationDomain, param3:Boolean = false)
        {
            this.typeName = param1;
            this._applicationDomain = param2;
            this._isOptional = param3;
            return;
        }// end function

        public function get isOptional() : Boolean
        {
            return this._isOptional;
        }// end function

        public function get type() : Type
        {
            return this.typeName != null ? (Type.forName(this.typeName, this._applicationDomain)) : (null);
        }// end function

        function setIsOptional(param1:Boolean) : void
        {
            this._isOptional = param1;
            return;
        }// end function

        function setType(param1:String) : void
        {
            this.typeName = param1;
            return;
        }// end function

        public function equals(param1:Object) : Boolean
        {
            var _loc_2:* = param1 as Parameter;
            if (_loc_2 != null)
            {
                return _loc_2._applicationDomain === this._applicationDomain && _loc_2.typeName == this.typeName && _loc_2.isOptional == this.isOptional;
            }
            return false;
        }// end function

        public static function newInstance(param1:String, param2:ApplicationDomain, param3:Boolean = false) : Parameter
        {
            return getFromCache(param1, param2, param3);
        }// end function

        private static function addToCache(param1:Parameter) : void
        {
            var _loc_2:* = param1.typeName.toUpperCase();
            var _loc_3:* = _cache[_loc_2];
            if (_loc_3 == null)
            {
                _loc_3 = [];
                _loc_3[0] = param1;
                _cache[_loc_2] = _loc_3;
            }
            else
            {
                _loc_3[_loc_3.length] = param1;
            }
            return;
        }// end function

        private static function getFromCache(param1:String, param2:ApplicationDomain, param3:Boolean) : Parameter
        {
            var _loc_6:Boolean = false;
            var _loc_7:Parameter = null;
            var _loc_4:* = new Parameter(param1, param2, param3);
            var _loc_5:* = _cache[_loc_4.typeName.toUpperCase()];
            if (_cache[_loc_4.typeName.toUpperCase()] == null)
            {
                addToCache(_loc_4);
            }
            else
            {
                _loc_6 = false;
                for each (_loc_7 in _loc_5)
                {
                    
                    if (_loc_7.equals(_loc_4))
                    {
                        _loc_4 = _loc_7;
                        _loc_6 = true;
                        break;
                    }
                }
                if (!_loc_6)
                {
                    addToCache(_loc_4);
                }
            }
            return _loc_4;
        }// end function

    }
}
