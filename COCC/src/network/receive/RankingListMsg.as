package network.receive
{
    import __AS3__.vec.*;
    import bitzero.net.data.*;
    import gameData.*;

    public class RankingListMsg extends BaseMsg
    {
        public var topTrophyList:Vector.<PlayerInfo>;
        public var topLevelList:Vector.<PlayerInfo>;

        public function RankingListMsg(param1:Object)
        {
            this.topTrophyList = new Vector.<PlayerInfo>;
            this.topLevelList = new Vector.<PlayerInfo>;
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            var _loc_3:PlayerInfo = null;
            errorCode = readInt();
            var _loc_1:* = readInt();
            var _loc_2:int = 0;
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new PlayerInfo();
                _loc_3.uId = readInt();
                _loc_3.cityName = readStr();
                _loc_3.trophy = readInt();
                _loc_3.level = readInt();
                _loc_3.clanId = readInt();
                _loc_3.clanName = readStr();
                _loc_3.clanIcon = readInt();
                _loc_3.attacksWon = readInt();
                _loc_3.defensesWon = readInt();
                _loc_3.changedRank = readInt();
                this.topTrophyList.push(_loc_3);
                _loc_2++;
            }
            _loc_1 = readInt();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new PlayerInfo();
                _loc_3.uId = readInt();
                _loc_3.cityName = readStr();
                _loc_3.trophy = readInt();
                _loc_3.level = readInt();
                _loc_3.clanId = readInt();
                _loc_3.clanName = readStr();
                _loc_3.clanIcon = readInt();
                _loc_3.attacksWon = readInt();
                _loc_3.defensesWon = readInt();
                _loc_3.changedRank = readInt();
                this.topLevelList.push(_loc_3);
                _loc_2++;
            }
            return true;
        }// end function

    }
}
