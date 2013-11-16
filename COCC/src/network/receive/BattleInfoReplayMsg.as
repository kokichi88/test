package network.receive
{
    import __AS3__.vec.*;
    import bitzero.net.data.*;
    import modules.battle.data.*;

    public class BattleInfoReplayMsg extends BaseMsg
    {
        public var dataList:Array;
        public var dataObstacle:Array;
        public var troopList:Vector.<Troop>;
        public var troopsCell:Vector.<int>;
        public var troopClans:Array;
        public var troopClansHouse:Array;
        public var uId:int = 0;
        public var uName:String = "";
        public var clanName:String = "";
        public var trophy:int = 0;
        public var retTrophy:int = 0;
        public var gold:int = 0;
        public var elixir:int = 0;
        public var darkElixir:int = 0;
        public var nStar:int = 0;
        public var percentLife:int = 0;
        public var startTime:Number = 0;
        public var endTime:Number = 0;
        public var endLoop:int = 0;

        public function BattleInfoReplayMsg(param1:Object = null)
        {
            this.dataList = new Array();
            this.dataObstacle = new Array();
            this.troopList = new Vector.<Troop>;
            this.troopsCell = new Vector.<int>;
            this.troopClans = new Array();
            this.troopClansHouse = new Array();
            if (param1)
            {
                super(param1);
            }
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            var _loc_3:Object = null;
            var _loc_4:Troop = null;
            var _loc_5:int = 0;
            errorCode = readInt();
            this.uId = readInt();
            this.uName = readStr();
            this.clanName = readStr();
            this.gold = readInt();
            this.elixir = readInt();
            this.darkElixir = readInt();
            this.trophy = readInt();
            this.retTrophy = readInt();
            this.nStar = readInt();
            this.percentLife = readInt();
            this.startTime = readLong();
            this.endTime = readLong();
            this.endLoop = readInt();
            _loc_1 = readInt();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new Object();
                _loc_3.objId = readInt();
                _loc_3.objType = readStr();
                _loc_3.cell = readInt();
                _loc_3.level = readInt();
                _loc_3.gold = readInt();
                _loc_3.elixir = readInt();
                _loc_3.darkElixir = readInt();
                _loc_3.status = readInt();
                this.dataList.push(_loc_3);
                _loc_2++;
            }
            _loc_1 = readInt();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_4 = new Troop();
                _loc_4.type = readStr();
                _loc_5 = readInt();
                this.troopsCell.push(_loc_5);
                _loc_4.level = readInt();
                _loc_4.num = readInt();
                this.troopList.push(_loc_4);
                _loc_2++;
            }
            _loc_1 = readInt();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new Object();
                _loc_3.objType = readStr();
                _loc_3.level = readInt();
                _loc_3.num = readInt();
                this.troopClans.push(_loc_3);
                _loc_2++;
            }
            _loc_1 = readInt();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new Object();
                _loc_3.objType = readStr();
                _loc_3.level = readInt();
                _loc_3.num = readInt();
                this.troopClansHouse.push(_loc_3);
                _loc_2++;
            }
            _loc_1 = readInt();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new Object();
                _loc_3.objId = readInt();
                _loc_3.objType = readStr();
                _loc_3.cell = readInt();
                _loc_3.level = 1;
                _loc_3.gold = 0;
                _loc_3.elixir = 0;
                _loc_3.darkElixir = 0;
                this.dataObstacle.push(_loc_3);
                _loc_2++;
            }
            return true;
        }// end function

    }
}
