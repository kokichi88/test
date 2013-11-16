package network.receive
{
    import __AS3__.vec.*;
    import bitzero.net.data.*;
    import gameData.clan.*;

    public class GetClansMsg extends BaseMsg
    {
        public var list:Vector.<ClanInfo>;

        public function GetClansMsg(param1:Object)
        {
            this.list = new Vector.<ClanInfo>;
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            var _loc_3:ClanInfo = null;
            errorCode = readInt();
            var _loc_1:* = readInt();
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new ClanInfo();
                _loc_3.clanId = readInt();
                _loc_3.name = readStr();
                _loc_3.icon = readInt();
                _loc_3.type = readInt();
                _loc_3.memberSize = readInt();
                _loc_3.trophy = readInt();
                this.list.push(_loc_3);
                _loc_2++;
            }
            return true;
        }// end function

    }
}
