package org.as3commons.reflect
{
    import flash.utils.*;
    import org.as3commons.lang.*;

    public class MetadataArgument extends Object implements IEquals
    {
        public var key:String;
        public var value:String;
        private static const _cache:Dictionary = new Dictionary();

        public function MetadataArgument(param1:String, param2:String)
        {
            this.key = param1;
            this.value = param2;
            return;
        }// end function

        public function equals(param1:Object) : Boolean
        {
            Assert.state(param1 is MetadataArgument, "other argument must be of type MetadataArgument");
            var _loc_2:* = MetadataArgument(param1);
            return _loc_2.key == this.key && _loc_2.value == this.value;
        }// end function

        public static function newInstance(param1:String, param2:String) : MetadataArgument
        {
            return getFromCache(param1, param2);
        }// end function

        private static function addToCache(param1:MetadataArgument) : void
        {
            var _loc_2:* = param1.key.toUpperCase();
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

        private static function getFromCache(param1:String, param2:String) : MetadataArgument
        {
            var _loc_5:Boolean = false;
            var _loc_6:MetadataArgument = null;
            var _loc_3:* = new MetadataArgument(param1, param2);
            var _loc_4:* = _cache[param1.toUpperCase()];
            if (_cache[param1.toUpperCase()] == null)
            {
                addToCache(_loc_3);
            }
            else
            {
                _loc_5 = false;
                for each (_loc_6 in _loc_4)
                {
                    
                    if (_loc_6.equals(_loc_3))
                    {
                        _loc_3 = _loc_6;
                        _loc_5 = true;
                        break;
                    }
                }
                if (!_loc_5)
                {
                    addToCache(_loc_3);
                }
            }
            return _loc_3;
        }// end function

    }
}
