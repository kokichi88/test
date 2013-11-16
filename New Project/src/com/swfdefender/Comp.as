package com.swfdefender
{
    import flash.display.*;
    import flash.utils.*;

    public class Comp extends Sprite
    {

        public function Comp()
        {
            ;
            ;
            if (false)
            {
                if (false)
                {
                }
            }
            return;
        }// end function

        public static function C1(param1:ByteArray, param2:ByteArray, param3:int) : void
        {
            ;
            if (false)
            {
            }
            var _loc_4:int = 0;
            var _loc_5:* = param1.length < param3 ? (param1.length) : (param3);
            var _loc_6:int = 0;
            while (_loc_6 < _loc_5)
            {
                
                param1[_loc_6] = param1[_loc_6] ^ param2[_loc_4];
                _loc_4++;
                if (_loc_4 >= param2.length)
                {
                    _loc_4 = 0;
                }
                _loc_6++;
            }
            ;
            if (false)
            {
            }
            return;
        }// end function

        public static function C2(param1:ByteArray, param2:ByteArray, param3:int) : void
        {
            if (false)
            {
            }
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_4:* = param1.length < param3 ? (param1.length) : (param3);
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:* = new ByteArray();
            _loc_8 = 0;
            while (_loc_8 < 256)
            {
                
                _loc_7[_loc_8] = _loc_8;
                _loc_8++;
            }
            _loc_9 = 0;
            _loc_8 = 0;
            while (_loc_8 < 256)
            {
                
                _loc_9 = _loc_9 + _loc_7[_loc_8] + param2[_loc_8 % param2.length] & 255;
                _loc_10 = _loc_7[_loc_8];
                _loc_7[_loc_8] = _loc_7[_loc_9];
                _loc_7[_loc_9] = _loc_10;
                _loc_8++;
            }
            _loc_8 = 0;
            while (_loc_8 < _loc_4)
            {
                
                _loc_5 = (_loc_5 + 1) & 255;
                _loc_6 = _loc_6 + _loc_7[_loc_5] & 255;
                _loc_9 = _loc_7[_loc_5];
                _loc_7[_loc_5] = _loc_7[_loc_6];
                _loc_7[_loc_6] = _loc_9;
                param1[_loc_8] = param1[_loc_8] ^ _loc_7[_loc_9 + _loc_7[_loc_5] & 255];
                _loc_8++;
            }
            if (false)
            {
            }
            return;
        }// end function

        if (false)
        {
            if (false)
            {
            }
        }
        ;
        if (false)
        {
        }
    }
}
