package network.receive
{
    import __AS3__.vec.*;
    import bitzero.net.data.*;
    import modules.battle.data.*;
    import modules.replay.data.*;

    public class ReplayBattleListMsg extends BaseMsg
    {
        public var listLog:Vector.<LogBattleData>;
        public var listLogAttack:Vector.<LogBattleData>;

        public function ReplayBattleListMsg(param1:Object)
        {
            this.listLog = new Vector.<LogBattleData>;
            this.listLogAttack = new Vector.<LogBattleData>;
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            var _loc_3:LogBattleData = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:Troop = null;
            errorCode = readInt();
            var _loc_1:* = readInt();
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new LogBattleData();
                _loc_3.keyLog = readInt();
                _loc_3.uId = readInt();
                _loc_3.uName = readStr();
                _loc_3.clanName = readStr();
                _loc_3.clanIcon = readInt();
                _loc_3.gold = readInt();
                _loc_3.elixir = readInt();
                _loc_3.darkElixir = readInt();
                _loc_3.trophy = readInt();
                _loc_3.retTrophy = readInt();
                _loc_3.nStar = readInt();
                _loc_3.percentLife = readInt();
                _loc_3.startTime = readLong();
                _loc_3.endTime = readLong();
                _loc_3.useClan = readBoolean();
                _loc_3.level = readInt();
                _loc_3.isReplay = readBoolean();
                _loc_3.isRevenge = readBoolean();
                _loc_4 = readInt();
                _loc_5 = 0;
                while (_loc_5 < _loc_4)
                {
                    
                    _loc_6 = new Troop();
                    _loc_6.type = readStr();
                    _loc_6.level = readInt();
                    _loc_6.num = readInt();
                    _loc_3.listTroop.push(_loc_6);
                    _loc_5++;
                }
                this.listLog.push(_loc_3);
                _loc_2++;
            }
            _loc_1 = readInt();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new LogBattleData();
                _loc_3.keyLog = readInt();
                _loc_3.uId = readInt();
                _loc_3.uName = readStr();
                _loc_3.clanName = readStr();
                _loc_3.clanIcon = readInt();
                _loc_3.gold = readInt();
                _loc_3.elixir = readInt();
                _loc_3.darkElixir = readInt();
                _loc_3.trophy = readInt();
                _loc_3.retTrophy = readInt();
                _loc_3.nStar = readInt();
                _loc_3.percentLife = readInt();
                _loc_3.startTime = readLong();
                _loc_3.endTime = readLong();
                _loc_3.useClan = readBoolean();
                _loc_3.level = readInt();
                _loc_3.isReplay = readBoolean();
                _loc_3.isRevenge = readBoolean();
                _loc_4 = readInt();
                _loc_5 = 0;
                while (_loc_5 < _loc_4)
                {
                    
                    _loc_6 = new Troop();
                    _loc_6.type = readStr();
                    _loc_6.level = readInt();
                    _loc_6.num = readInt();
                    _loc_3.listTroop.push(_loc_6);
                    _loc_5++;
                }
                this.listLogAttack.push(_loc_3);
                _loc_2++;
            }
            return true;
        }// end function

    }
}
