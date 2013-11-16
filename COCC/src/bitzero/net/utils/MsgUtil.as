package bitzero.net.utils
{
    import flash.utils.*;

    public class MsgUtil extends Object
    {

        public function MsgUtil()
        {
            return;
        }// end function

        public static function getTypeId(param1:ByteArray) : int
        {
            param1.position = 0;
            return param1.readInt();
        }// end function

        public static function getHeadData(param1:ByteArray, param2:int) : int
        {
            param1.position = param2 * 4;
            return param1.readInt();
        }// end function

        public static function creatByteArray() : ByteArray
        {
            var _loc_1:* = new ByteArray();
            _loc_1.endian = Endian.BIG_ENDIAN;
            return _loc_1;
        }// end function

    }
}
