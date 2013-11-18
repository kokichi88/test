package network.receive
{
    import bitzero.net.data.*;
    import gameData.*;
    import modules.battle.data.*;
    import modules.city.logic.*;

    public class BuildingInfoMsg extends BaseMsg
    {
        public var townHall:Object;
        public var barrackList:Array;
        public var armyCampList:Array;
        public var resourceList:Array;
        public var storageList:Array;
        public var defenceList:Array;
        public var wallList:Array;
        public var laboratory:LaboratoryObject;
        public var clanCastle:ClanObject;
        public var builderHutList:Array;
        public var obstaclesList:Array;
        public var trapList:Array;
        public var gravestoneList:Array;

        public function BuildingInfoMsg(param1:Object)
        {
            this.townHall = new Object();
            this.barrackList = new Array();
            this.armyCampList = new Array();
            this.resourceList = new Array();
            this.storageList = new Array();
            this.defenceList = new Array();
            this.wallList = new Array();
            this.laboratory = new LaboratoryObject();
            this.clanCastle = new ClanObject();
            this.builderHutList = new Array();
            this.obstaclesList = new Array();
            this.trapList = new Array();
            this.gravestoneList = new Array();
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
			
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            var _loc_3:Object = null;
            var _loc_5:int = 0;
            var _loc_6:Array = null;
            var _loc_7:int = 0;
            var _loc_8:Object = null;
            var _loc_9:DataResearch = null;
            var _loc_10:Troop = null;
            errorCode = readInt();
            this.townHall.autoId = readInt();
            this.townHall.type = readStr();
            this.townHall.posX = readInt();
            this.townHall.posY = readInt();
            this.townHall.level = readInt();
            this.townHall.status = readInt();
            this.townHall.startTime = readLong();
            _loc_1 = readInt();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new Object();
                _loc_3.autoId = readInt();
                _loc_3.type = readStr();
                _loc_3.posX = readInt();
                _loc_3.posY = readInt();
                _loc_3.level = readInt();
                _loc_3.status = readInt();
                _loc_3.startTime = readLong();
                _loc_3.deltaPauseTime = readLong();
                _loc_5 = readInt();
                _loc_6 = new Array();
                if (_loc_5 > 0)
                {
                    _loc_7 = 0;
                    while (_loc_7 < _loc_5)
                    {
                        
                        _loc_8 = new Object();
                        _loc_8.type = readStr();
                        _loc_8.num = readInt();
                        _loc_6.push(_loc_8);
                        _loc_7++;
                    }
                }
                _loc_3.trainingTroop = _loc_6;
                this.barrackList.push(_loc_3);
                _loc_2++;
            }
            _loc_1 = readInt();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new Object();
                _loc_3.autoId = readInt();
                _loc_3.type = readStr();
                _loc_3.posX = readInt();
                _loc_3.posY = readInt();
                _loc_3.level = readInt();
                _loc_3.status = readInt();
                _loc_3.startTime = readLong();
                this.armyCampList.push(_loc_3);
                _loc_2++;
            }
            _loc_1 = readInt();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new Object();
                _loc_3.autoId = readInt();
                _loc_3.type = readStr();
                _loc_3.posX = readInt();
                _loc_3.posY = readInt();
                _loc_3.level = readInt();
                _loc_3.status = readInt();
                _loc_3.startTime = readLong();
                _loc_3.deltaPauseTime = readLong();
                this.resourceList.push(_loc_3);
                _loc_2++;
            }
            _loc_1 = readInt();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new Object();
                _loc_3.autoId = readInt();
                _loc_3.type = readStr();
                _loc_3.posX = readInt();
                _loc_3.posY = readInt();
                _loc_3.level = readInt();
                _loc_3.status = readInt();
                _loc_3.startTime = readLong();
                this.storageList.push(_loc_3);
                _loc_2++;
            }
            _loc_1 = readInt();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new Object();
                _loc_3.autoId = readInt();
                _loc_3.type = readStr();
                _loc_3.posX = readInt();
                _loc_3.posY = readInt();
                _loc_3.level = readInt();
                _loc_3.status = readInt();
                _loc_3.startTime = readLong();
                this.defenceList.push(_loc_3);
                _loc_2++;
            }
            _loc_1 = readInt();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new Object();
                _loc_3.autoId = readInt();
                _loc_3.type = readStr();
                _loc_3.posX = readInt();
                _loc_3.posY = readInt();
                _loc_3.level = readInt();
                _loc_3.status = readInt();
                _loc_3.startTime = readLong();
                this.wallList.push(_loc_3);
                _loc_2++;
            }
            var _loc_4:* = readInt();
            if (readInt())
            {
                this.laboratory.autoId = readInt();
                this.laboratory.type = readStr();
                this.laboratory.posX = readInt();
                this.laboratory.posY = readInt();
                this.laboratory.level = readInt();
                this.laboratory.status = readInt();
                this.laboratory.startTime = readLong();
                this.laboratory.deltaPauseTime = readLong();
                this.laboratory.troopType = readStr();
                _loc_1 = readInt();
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    _loc_9 = new DataResearch();
                    _loc_9.researchType = readStr();
                    _loc_9.researchLevel = readInt();
                    this.laboratory.researchList.push(_loc_9);
                    _loc_2++;
                }
            }
            this.clanCastle.autoId = readInt();
            this.clanCastle.type = readStr();
            this.clanCastle.posX = readInt();
            this.clanCastle.posY = readInt();
            this.clanCastle.level = readInt();
            this.clanCastle.status = readInt();
            this.clanCastle.startTime = readLong();
            this.clanCastle.details.clanId = readInt();
            if (this.clanCastle.details.clanId > 0)
            {
                this.clanCastle.details.icon = readInt();
                this.clanCastle.details.name = readStr();
                this.clanCastle.title = readInt();
            }
            _loc_1 = readInt();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_10 = new Troop();
                _loc_10.type = readStr();
                _loc_10.level = readInt();
                _loc_10.num = readInt();
                this.clanCastle.troopList.push(_loc_10);
                _loc_2++;
            }
            this.clanCastle.lastRequestTime = readLong();
            _loc_1 = readInt();
            _loc_2 = 0;
			return true;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new Object();
                _loc_3.autoId = readInt();
                _loc_3.type = readStr();
                _loc_3.posX = readInt();
                _loc_3.posY = readInt();
                _loc_3.level = readInt();
                _loc_3.status = readInt();
                _loc_3.startTime = readLong();
                this.builderHutList.push(_loc_3);
                _loc_2++;
            }
            _loc_1 = readInt();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new Object();
                _loc_3.autoId = readInt();
                _loc_3.type = readStr();
                _loc_3.posX = readInt();
                _loc_3.posY = readInt();
                _loc_3.startTime = readLong();
                this.obstaclesList.push(_loc_3);
                _loc_2++;
            }
            _loc_1 = readInt();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new Object();
                _loc_3.autoId = readInt();
                _loc_3.type = readStr();
                _loc_3.posX = readInt();
                _loc_3.posY = readInt();
                this.trapList.push(_loc_3);
                _loc_2++;
            }
            _loc_1 = readInt();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new Object();
                _loc_3.cell = readInt();
                this.gravestoneList.push(_loc_3);
                _loc_2++;
            }
            return true;
        }// end function

    }
}
