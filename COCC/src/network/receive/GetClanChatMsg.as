package network.receive
{
    import __AS3__.vec.*;
    import bitzero.net.data.*;

    public class GetClanChatMsg extends BaseMsg
    {
        public var data:Vector.<Object>;

        public function GetClanChatMsg(param1:Object)
        {
            this.data = new Vector.<Object>;
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            var _loc_3:Object = null;
            errorCode = readInt();
            _loc_1 = readInt();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new Object();
                _loc_3.sender = readInt();
                _loc_3.msg = readStr();
                _loc_3.created = readLong();
                this.data.push(_loc_3);
                _loc_2++;
            }
            return true;
        }// end function

    }
}
