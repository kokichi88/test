package network.receive
{
    import __AS3__.vec.*;
    import bitzero.net.data.*;
    import gameData.clan.*;

    public class GetClanDetailMsg extends BaseMsg
    {
        public var clanObj:ClanInfo;
        public var members:Vector.<ClanMemberInfo>;

        public function GetClanDetailMsg(param1:Object)
        {
            this.clanObj = new ClanInfo();
            this.members = new Vector.<ClanMemberInfo>;
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            var _loc_3:ClanMemberInfo = null;
            errorCode = readInt();
            this.clanObj.clanId = readInt();
            this.clanObj.name = readStr();
            this.clanObj.icon = readInt();
            this.clanObj.type = readInt();
            this.clanObj.requiredTrophy = readInt();
            this.clanObj.description = readStr();
            this.clanObj.trophy = readInt();
            var _loc_1:* = readInt();
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new ClanMemberInfo();
                _loc_3.uId = readInt();
                _loc_3.clanTitle = readInt();
                _loc_3.level = readInt();
                _loc_3.trophy = readInt();
                _loc_3.name = readStr();
                _loc_3.troopsDonate = readInt();
                _loc_3.troopsReceive = readInt();
                this.members.push(_loc_3);
                _loc_2++;
            }
            return true;
        }// end function

    }
}
