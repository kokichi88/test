package network.receive
{
    import __AS3__.vec.*;
    import bitzero.net.data.*;
    import modules.battle.data.*;

    public class BattleInfoMsg extends BaseMsg
    {
        public var dataList:Array;
        public var dataObstacle:Array;
        public var troopList:Vector.<Troop>;
        public var troopClans:Array;
        public var troopClansHouse:Array;
        public var uId:int = 0;
        public var uName:String = "";
        public var uAvatar:String = "";
        public var trophyReceive:int = 0;
        public var trophyLost:int = 0;
        public var revenge:Boolean = false;
        public var clanIcon:int = 0;
        public var clanName:String = "";

        public function BattleInfoMsg(param1:Object = null)
        {
            this.dataList = new Array();
            this.dataObstacle = new Array();
            this.troopList = new Vector.<Troop>;
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
            errorCode = readInt();
            this.uId = readInt();
            this.uName = readStr();
            this.uAvatar = readStr();
            this.trophyReceive = readInt();
            this.trophyLost = readInt();
            this.revenge = readBoolean();
            this.clanName = readStr();
            this.clanIcon = readInt();
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
