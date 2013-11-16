package org.as3commons.reflect
{
    import flash.system.*;
    import flash.utils.*;
    import org.as3commons.lang.*;

    public class Variable extends Field
    {
        private static const _cache:Dictionary = new Dictionary();

        public function Variable(param1:String, param2:String, param3:String, param4:Boolean, param5:ApplicationDomain, param6:HashArray = null)
        {
            super(param1, param2, param3, param4, param5, param6);
            return;
        }// end function

        public static function newInstance(param1:String, param2:String, param3:String, param4:Boolean, param5:ApplicationDomain, param6:HashArray = null) : Variable
        {
            var _loc_7:* = new Variable(param1, param2, param3, param4, param5, param6);
            return doCacheCheck(_loc_7);
        }// end function

        public static function addToCache(param1:Variable) : void
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

        public static function doCacheCheck(param1:Variable) : Variable
        {
            var _loc_3:Boolean = false;
            var _loc_4:Variable = null;
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
