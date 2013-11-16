package org.as3commons.reflect
{
    import flash.system.*;
    import flash.utils.*;
    import org.as3commons.lang.*;

    public class Accessor extends Field implements IEquals
    {
        private var _access:AccessorAccess;
        private static const _cache:Dictionary = new Dictionary();

        public function Accessor(param1:String, param2:AccessorAccess, param3:String, param4:String, param5:Boolean, param6:ApplicationDomain, param7:HashArray = null)
        {
            super(param1, param3, param4, param5, param6, param7);
            this._access = param2;
            return;
        }// end function

        public function get access() : AccessorAccess
        {
            return this._access;
        }// end function

        public function get readable() : Boolean
        {
            return this.isReadable();
        }// end function

        public function get writeable() : Boolean
        {
            return this.isWriteable();
        }// end function

        public function isReadable() : Boolean
        {
            return this._access == AccessorAccess.READ_ONLY || this._access == AccessorAccess.READ_WRITE;
        }// end function

        public function isWriteable() : Boolean
        {
            return this._access == AccessorAccess.WRITE_ONLY || this._access == AccessorAccess.READ_WRITE;
        }// end function

        function setAccess(param1:AccessorAccess) : void
        {
            this._access = param1;
            return;
        }// end function

        override public function equals(param1:Object) : Boolean
        {
            var _loc_2:* = param1 as Accessor;
            var _loc_3:Boolean = false;
            if (_loc_2 != null)
            {
                _loc_3 = super.equals(param1);
                if (_loc_3)
                {
                    _loc_3 = _loc_2.access === this.access;
                }
                if (_loc_3)
                {
                    _loc_3 = compareMetadata(_loc_2.metadata);
                }
            }
            return _loc_3;
        }// end function

        public static function newInstance(param1:String, param2:AccessorAccess, param3:String, param4:String, param5:Boolean, param6:ApplicationDomain, param7:HashArray = null) : Accessor
        {
            var _loc_8:* = new Accessor(param1, param2, param3, param4, param5, param6, param7);
            return doCacheCheck(_loc_8);
        }// end function

        public static function addToCache(param1:Accessor) : void
        {
            var _loc_2:* = param1.name.toUpperCase();
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

        public static function doCacheCheck(param1:Accessor) : Accessor
        {
            var _loc_3:Boolean = false;
            var _loc_4:Accessor = null;
            var _loc_2:* = _cache[param1.name.toUpperCase()];
            if (_loc_2 == null)
            {
                addToCache(param1);
            }
            else
            {
                _loc_3 = false;
                for each (_loc_4 in _loc_2)
                {
                    
                    if (_loc_4.equals(param1))
                    {
                        param1 = _loc_4;
                        _loc_3 = true;
                        break;
                    }
                }
                if (!_loc_3)
                {
                    addToCache(param1);
                }
            }
            return param1;
        }// end function

    }
}
