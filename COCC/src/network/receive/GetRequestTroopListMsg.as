package network.receive
{
    import bitzero.net.data.*;
    import gameData.donation.*;
    import modules.battle.data.*;

    public class GetRequestTroopListMsg extends BaseMsg
    {
        public var playerId:int;
        public var troopRequests:Object;

        public function GetRequestTroopListMsg(param1:Object)
        {
            this.troopRequests = new Object();
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            var _loc_3:int = 0;
            var _loc_4:TroopRequestInfo = null;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:Troop = null;
            errorCode = readInt();
            var _loc_1:* = readInt();
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = readInt();
                _loc_4 = new TroopRequestInfo();
                _loc_4.msg = readStr();
                _loc_4.created = readDouble();
                _loc_4.curCapacity = readInt();
                _loc_4.maxCapacity = readInt();
                _loc_5 = readInt();
                _loc_6 = 0;
                while (_loc_6 < _loc_5)
                {
                    
                    _loc_7 = new Troop();
                    _loc_7.type = readStr();
                    _loc_7.level = readInt();
                    _loc_7.num = readInt();
                    _loc_4.myDonation.push(_loc_7);
                    _loc_6++;
                }
                this.troopRequests[_loc_3] = _loc_4;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
