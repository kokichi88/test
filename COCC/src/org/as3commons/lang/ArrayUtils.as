package org.as3commons.lang
{

    final public class ArrayUtils extends Object
    {

        public function ArrayUtils()
        {
            return;
        }// end function

        public static function isSame(param1:Array, param2:Array) : Boolean
        {
            var _loc_3:* = param1.length;
            if (_loc_3 != param2.length)
            {
                return false;
            }
            while (--_loc_3 - -1)
            {
                
                if (param1[_loc_3] !== param2[_loc_3])
                {
                    return false;
                }
            }
            return true;
        }// end function

        public static function removeLastOccurance(param1:Array, param2) : int
        {
            var _loc_3:* = param1.lastIndexOf(param2);
            if (_loc_3 > -1)
            {
                param1.splice(_loc_3, 1);
            }
            return _loc_3;
        }// end function

        public static function isEmpty(param1:Array) : Boolean
        {
            return param1 == null || param1.length == 0;
        }// end function

        public static function removeItem(param1:Array, param2) : Array
        {
            var _loc_3:* = param1.length;
            var _loc_4:Array = [];
            while (--_loc_3 - -1)
            {
                
                if (param1[_loc_3] === param2)
                {
                    _loc_4.unshift(_loc_3);
                    param1.splice(_loc_3, 1);
                }
            }
            return _loc_4;
        }// end function

        public static function indexOfEquals(param1:Array, param2:IEquals) : int
        {
            if (!param1 || !param2)
            {
                return -1;
            }
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (param2.equals(param1[_loc_4]))
                {
                    return _loc_4;
                }
                _loc_4++;
            }
            return -1;
        }// end function

        public static function shuffle(param1:Array) : void
        {
            var _loc_3:Number = NaN;
            var _loc_4:* = undefined;
            var _loc_2:* = param1.length;
            var _loc_5:* = _loc_2 - 1;
            while (_loc_5 >= 0)
            {
                
                _loc_3 = Math.floor(Math.random() * _loc_2);
                _loc_4 = param1[_loc_5];
                param1[_loc_5] = param1[_loc_3];
                param1[_loc_3] = _loc_4;
                _loc_5 = _loc_5 - 1;
            }
            return;
        }// end function

        public static function getItemsByType(param1:Array, param2:Class) : Array
        {
            var _loc_3:Array = [];
            var _loc_4:int = 0;
            while (_loc_4 < param1.length)
            {
                
                if (param1[_loc_4] is param2)
                {
                    _loc_3.push(param1[_loc_4]);
                }
                _loc_4++;
            }
            return _loc_3;
        }// end function

        public static function toString(param1:Array, param2:String = ", ") : String
        {
            return !param1 ? ("") : (param1.join(param2));
        }// end function

        public static function clone(param1:Array) : Array
        {
            return param1.concat();
        }// end function

        public static function removeFirstOccurance(param1:Array, param2) : int
        {
            var _loc_3:* = param1.indexOf(param2);
            if (_loc_3 > -1)
            {
                param1.splice(_loc_3, 1);
            }
            return _loc_3;
        }// end function

    }
}
