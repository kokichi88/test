package network.receive
{
    import __AS3__.vec.*;
    import bitzero.net.data.*;
    import gameData.*;

    public class FriendListMsg extends BaseMsg
    {
        public var list:Vector.<FriendInfo>;

        public function FriendListMsg(param1:Object)
        {
            this.list = new Vector.<FriendInfo>;
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            var _loc_3:FriendInfo = null;
            errorCode = readInt();
            var _loc_1:* = readInt();
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new FriendInfo();
                _loc_3.uId = readInt();
                _loc_3.uName = readStr();
                _loc_3.uAvatar = readStr();
                _loc_3.level = readInt();
                _loc_3.clanId = readInt();
                this.list.push(_loc_3);
                _loc_2++;
            }
            return true;
        }// end function

    }
}
