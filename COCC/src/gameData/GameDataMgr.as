package gameData
{
    import __AS3__.vec.*;
    import component.avatar.model.animation.*;
    import flash.display.*;
    import flash.geom.*;
    import gameData.clan.*;
    import map.*;
    import modules.*;
    import modules.battle.*;
    import modules.battle.data.*;
    import modules.city.*;
    import modules.city.logic.*;
    import network.receive.*;
    import resMgr.*;
    import utility.*;

    public class GameDataMgr extends Object
    {
        public var uInfo:UserInfo;
        public var townHall:TownHallObject;
        public var clanCastle:ClanObject;
        public var laboratory:LaboratoryObject;
        public var spellFactory:SpellFactoryObject;
        public var armyCampList:Vector.<ArmyCampObject>;
        public var barrackList:Vector.<BarrackObject>;
        public var defenseList:Vector.<DefenseObject>;
        public var resourceList:Vector.<ResourceObject>;
        public var storageList:Vector.<StorageObject>;
        public var wallList:Vector.<WallObject>;
        public var builderHutList:Vector.<BuilderObject>;
        public var obstacleList:Vector.<ObstacleObject>;
        public var trapList:Vector.<TrapObject>;
        public var graveStoneList:Vector.<Sprite>;
        public var troopList:Vector.<Troop>;
        public var spellList:Vector.<Troop>;
        public var curObject:MapObject;
        public var myInfo:UserInfo;
        public var myClanDetial:ClanInfo;
        public var myClanMembers:Object;
        public var getRequestClanList:Boolean = false;
        public var singleMapLevel:int;
        public var singleMapInfo:Vector.<PointMap>;
        public var maxGoldCapacity:int = 0;
        public var maxElixirCapacity:int = 0;
        public var maxDarkElixirCapacity:int = 0;
        public var curTroopType:String;
        public var tempObject:MapObject;
        public var clanInfo:ClanInfo;
        public var saveObjPosX:int = -1;
        public var saveObjPosY:int = -1;
        public var fnCallBack:Function;
        public var lackingMoney:MoneyType;
        public var quickFinishType:String;
        public var quickFinishCost:int = 0;
        public var curBarrackId:int;
        public var tutorialStep:int;
        public var saveBuilderId:int;
        public var saveShieldId:int;
        public var hasSentFinishTroop:Boolean = false;
        private static var _inst:GameDataMgr;

        public function GameDataMgr()
        {
            this.uInfo = new UserInfo();
            this.townHall = new TownHallObject();
            this.clanCastle = new ClanObject();
            this.laboratory = new LaboratoryObject();
            this.spellFactory = new SpellFactoryObject();
            this.armyCampList = new Vector.<ArmyCampObject>;
            this.barrackList = new Vector.<BarrackObject>;
            this.defenseList = new Vector.<DefenseObject>;
            this.resourceList = new Vector.<ResourceObject>;
            this.storageList = new Vector.<StorageObject>;
            this.wallList = new Vector.<WallObject>;
            this.builderHutList = new Vector.<BuilderObject>;
            this.obstacleList = new Vector.<ObstacleObject>;
            this.trapList = new Vector.<TrapObject>;
            this.graveStoneList = new Vector.<Sprite>;
            this.troopList = new Vector.<Troop>;
            this.spellList = new Vector.<Troop>;
            this.curObject = new MapObject();
            this.myInfo = new UserInfo();
            this.myClanDetial = new ClanInfo();
            this.myClanMembers = new Object();
            this.singleMapInfo = new Vector.<PointMap>;
            this.tempObject = new MapObject();
            this.clanInfo = new ClanInfo();
            this.lackingMoney = new MoneyType();
            return;
        }// end function

        public function updateList(param1:MapObject) : void
        {
            var _loc_2:* = Utility.getTypeObject(param1.type);
            switch(_loc_2)
            {
                case BuildingType.WAL:
                {
                    this.wallList.push(param1);
                    break;
                }
                case BuildingType.BAR:
                {
                    this.barrackList.push(param1);
                    break;
                }
                case BuildingType.LAB:
                {
                    this.laboratory = param1 as LaboratoryObject;
                    break;
                }
                case BuildingType.TOW:
                {
                    this.townHall = param1 as TownHallObject;
                    break;
                }
                case BuildingType.CAT:
                {
                    this.clanCastle = param1 as ClanObject;
                    break;
                }
                case BuildingType.SPF:
                {
                    this.spellFactory = param1 as SpellFactoryObject;
                    break;
                }
                case BuildingType.RES:
                {
                    this.resourceList.push(param1);
                    break;
                }
                case BuildingType.STO:
                {
                    this.storageList.push(param1);
                    break;
                }
                case BuildingType.AMC:
                {
                    this.armyCampList.push(param1);
                    break;
                }
                case BuildingType.DEF:
                {
                    this.defenseList.push(param1);
                    break;
                }
                case BuildingType.BH:
                {
                    this.builderHutList.push(param1);
                    break;
                }
                case BuildingType.OBS:
                {
                    this.obstacleList.push(param1);
                    break;
                }
                case BuildingType.TRA:
                {
                    this.trapList.push(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function removeBuilding(param1:MapObject) : void
        {
            var _loc_2:* = Utility.getTypeObject(param1.type);
            switch(_loc_2)
            {
                case BuildingType.TOW:
                {
                    this.removeTownHall();
                    break;
                }
                case BuildingType.LAB:
                {
                    this.removeLaboratory();
                    break;
                }
                case BuildingType.AMC:
                {
                    this.removeArmyCamp(param1.autoId);
                    break;
                }
                case BuildingType.BAR:
                {
                    this.removeBarrack(param1.autoId);
                    break;
                }
                case BuildingType.RES:
                {
                    this.removeResource(param1.autoId);
                    break;
                }
                case BuildingType.DEF:
                {
                    this.removeDefense(param1.autoId);
                    break;
                }
                case BuildingType.STO:
                {
                    this.removeStorage(param1.autoId);
                    break;
                }
                case BuildingType.WAL:
                {
                    this.removeWall(param1.autoId);
                    break;
                }
                case BuildingType.TRA:
                {
                    this.removeTrap(param1.autoId);
                    break;
                }
                default:
                {
                    break;
                }
            }
            MapMgr.getInstance().unSetBuilding(param1);
            return;
        }// end function

        private function removeTrap(param1:int) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.trapList.length)
            {
                
                if (this.trapList[_loc_2].autoId == param1)
                {
                    this.trapList[_loc_2].destroy();
                    this.trapList[_loc_2] = null;
                    break;
                }
                _loc_2++;
            }
            this.trapList.splice(_loc_2, 1);
            return;
        }// end function

        private function removeTownHall() : void
        {
            if (this.townHall)
            {
                this.townHall.destroy();
                this.townHall = null;
            }
            return;
        }// end function

        private function removeLaboratory() : void
        {
            if (this.laboratory)
            {
                this.laboratory.destroy();
                this.laboratory = null;
            }
            return;
        }// end function

        private function removeClanCastle() : void
        {
            if (this.clanCastle)
            {
                this.clanCastle.destroy();
                this.clanCastle = null;
            }
            return;
        }// end function

        private function removeArmyCamp(param1:int) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.armyCampList.length)
            {
                
                if (this.armyCampList[_loc_2].autoId == param1)
                {
                    this.armyCampList[_loc_2].destroy();
                    this.armyCampList[_loc_2] = null;
                    break;
                }
                _loc_2++;
            }
            this.armyCampList.splice(_loc_2, 1);
            return;
        }// end function

        private function removeBarrack(param1:int) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.barrackList.length)
            {
                
                if (this.barrackList[_loc_2].autoId == param1)
                {
                    this.barrackList[_loc_2].destroy();
                    this.barrackList[_loc_2] = null;
                    break;
                }
                _loc_2++;
            }
            this.barrackList.splice(_loc_2, 1);
            return;
        }// end function

        private function removeResource(param1:int) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.resourceList.length)
            {
                
                if (this.resourceList[_loc_2].autoId == param1)
                {
                    this.resourceList[_loc_2].destroy();
                    this.resourceList[_loc_2] = null;
                    break;
                }
                _loc_2++;
            }
            this.resourceList.splice(_loc_2, 1);
            return;
        }// end function

        private function removeStorage(param1:int) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.storageList.length)
            {
                
                if (this.storageList[_loc_2].autoId == param1)
                {
                    this.storageList[_loc_2].destroy();
                    this.storageList[_loc_2] = null;
                    break;
                }
                _loc_2++;
            }
            this.storageList.splice(_loc_2, 1);
            return;
        }// end function

        private function removeDefense(param1:int) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.defenseList.length)
            {
                
                if (this.defenseList[_loc_2].autoId == param1)
                {
                    this.defenseList[_loc_2].destroy();
                    this.defenseList[_loc_2] = null;
                    break;
                }
                _loc_2++;
            }
            this.defenseList.splice(_loc_2, 1);
            return;
        }// end function

        private function removeWall(param1:int) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.wallList.length)
            {
                
                if (this.wallList[_loc_2].autoId == param1)
                {
                    this.wallList[_loc_2].destroy();
                    this.wallList[_loc_2] = null;
                    break;
                }
                _loc_2++;
            }
            this.wallList.splice(_loc_2, 1);
            return;
        }// end function

        public function resetDataCity() : void
        {
            this.removeTownHall();
            this.curObject = null;
            var _loc_1:int = 0;
            _loc_1 = 0;
            while (_loc_1 < this.armyCampList.length)
            {
                
                this.armyCampList[_loc_1].destroy();
                this.armyCampList[_loc_1] = null;
                _loc_1++;
            }
            this.armyCampList.splice(0, this.armyCampList.length);
            this.armyCampList = new Vector.<ArmyCampObject>;
            _loc_1 = 0;
            while (_loc_1 < this.barrackList.length)
            {
                
                this.barrackList[_loc_1].destroy();
                this.barrackList[_loc_1] = null;
                _loc_1++;
            }
            this.barrackList.splice(0, this.barrackList.length);
            this.barrackList = new Vector.<BarrackObject>;
            _loc_1 = 0;
            while (_loc_1 < this.defenseList.length)
            {
                
                this.defenseList[_loc_1].destroy();
                this.defenseList[_loc_1] = null;
                _loc_1++;
            }
            this.defenseList.splice(0, this.defenseList.length);
            this.defenseList = new Vector.<DefenseObject>;
            _loc_1 = 0;
            while (_loc_1 < this.resourceList.length)
            {
                
                this.resourceList[_loc_1].destroy();
                this.resourceList[_loc_1] = null;
                _loc_1++;
            }
            this.resourceList.splice(0, this.resourceList.length);
            this.resourceList = new Vector.<ResourceObject>;
            _loc_1 = 0;
            while (_loc_1 < this.storageList.length)
            {
                
                this.storageList[_loc_1].destroy();
                this.storageList[_loc_1] = null;
                _loc_1++;
            }
            this.storageList.splice(0, this.storageList.length);
            this.storageList = new Vector.<StorageObject>;
            _loc_1 = 0;
            while (_loc_1 < this.wallList.length)
            {
                
                this.wallList[_loc_1].destroy();
                this.wallList[_loc_1] = null;
                _loc_1++;
            }
            this.wallList.splice(0, this.wallList.length);
            this.wallList = new Vector.<WallObject>;
            this.removeLaboratory();
            this.removeClanCastle();
            this.removeSpellFactory();
            _loc_1 = 0;
            while (_loc_1 < this.builderHutList.length)
            {
                
                this.builderHutList[_loc_1].destroy();
                this.builderHutList[_loc_1] = null;
                _loc_1++;
            }
            this.builderHutList.splice(0, this.builderHutList.length);
            this.builderHutList = new Vector.<BuilderObject>;
            _loc_1 = 0;
            while (_loc_1 < this.obstacleList.length)
            {
                
                this.obstacleList[_loc_1].destroy();
                this.obstacleList[_loc_1] = null;
                _loc_1++;
            }
            this.obstacleList.splice(0, this.obstacleList.length);
            this.obstacleList = new Vector.<ObstacleObject>;
            _loc_1 = 0;
            while (_loc_1 < this.trapList.length)
            {
                
                this.trapList[_loc_1].destroy();
                this.trapList[_loc_1] = null;
                _loc_1++;
            }
            this.trapList.splice(0, this.trapList.length);
            this.trapList = new Vector.<TrapObject>;
            _loc_1 = 0;
            while (_loc_1 < this.graveStoneList.length)
            {
                
                this.graveStoneList[_loc_1].parent.removeChild(this.graveStoneList[_loc_1]);
                this.graveStoneList[_loc_1] = null;
                _loc_1++;
            }
            this.graveStoneList.splice(0, this.graveStoneList.length);
            this.graveStoneList = new Vector.<Sprite>;
            this.troopList.splice(0, this.troopList.length);
            this.troopList = new Vector.<Troop>;
            MapMgr.getInstance().clearMap();
            BattleModule.getInstance().battleData.clearAllObj();
            CityMgr.getInstance().destroySpriteList();
            return;
        }// end function

        private function removeSpellFactory() : void
        {
            if (this.spellFactory)
            {
                this.spellFactory.destroy();
                this.spellFactory = null;
            }
            return;
        }// end function

        public function addMoney(param1:String, param2:int) : void
        {
            var _loc_4:int = 0;
            var _loc_5:ResourceObject = null;
            var _loc_3:int = 0;
            var _loc_6:String = null;
            switch(param1)
            {
                case MoneyType.GOLD:
                {
                    _loc_3 = this.maxGoldCapacity;
                    this.myInfo.gold = this.myInfo.gold + param2;
                    if (this.myInfo.gold >= _loc_3)
                    {
                        this.showIconHarvest(true, BuildingType.GOLD_MINE);
                    }
                    else
                    {
                        this.showIconHarvest(false, BuildingType.GOLD_MINE);
                    }
                    if (param2 != 0)
                    {
                        CityMgr.getInstance().guiMainTopRight.runMoneyEffect();
                    }
                    _loc_6 = BuildingType.GOLD_STORAGE;
                    break;
                }
                case MoneyType.ELIXIR:
                {
                    _loc_3 = this.maxElixirCapacity;
                    this.myInfo.elixir = this.myInfo.elixir + param2;
                    if (this.myInfo.elixir >= _loc_3)
                    {
                        this.showIconHarvest(true, BuildingType.ELIXIR_COLLECTOR);
                    }
                    else
                    {
                        this.showIconHarvest(false, BuildingType.ELIXIR_COLLECTOR);
                    }
                    if (param2 != 0)
                    {
                        CityMgr.getInstance().guiMainTopRight.runElixirEffect();
                    }
                    _loc_6 = BuildingType.ELIXIR_STORAGE;
                    break;
                }
                case MoneyType.DARK_ELIXIR:
                {
                    this.myInfo.darkElixir = this.myInfo.darkElixir + param2;
                    _loc_3 = this.maxDarkElixirCapacity;
                    this.myInfo.darkElixir = Math.min(this.myInfo.darkElixir, _loc_3);
                    if (this.myInfo.darkElixir >= _loc_3)
                    {
                        this.showIconHarvest(true, BuildingType.DARK_ELIXIR_COLLECTOR);
                    }
                    else
                    {
                        this.showIconHarvest(false, BuildingType.DARK_ELIXIR_COLLECTOR);
                    }
                    _loc_6 = BuildingType.DARK_ELIXIR_STORAGE;
                    break;
                }
                case MoneyType.COIN:
                {
                    this.myInfo.coin = this.myInfo.coin + param2;
                    if (param2 != 0)
                    {
                        CityMgr.getInstance().guiMainTopRight.runEffectG();
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_6 && GlobalVar.state == GlobalVar.STATE_MYHOME)
            {
                GameDataMgr.getInstance().splitResources(_loc_6);
            }
            return;
        }// end function

        public function addExp(param1:int) : void
        {
            this.myInfo.exp = this.myInfo.exp + param1;
            var _loc_2:* = JsonMgr.getInstance().levelUser;
            while (_loc_2[(this.myInfo.level + 1)] && this.myInfo.exp > _loc_2[(this.myInfo.level + 1)])
            {
                
                (this.myInfo.level + 1);
                this.myInfo.exp = this.myInfo.exp - _loc_2[this.myInfo.level];
            }
            return;
        }// end function

        public function getMoney(param1:String) : int
        {
            switch(param1)
            {
                case MoneyType.GOLD:
                {
                    return this.myInfo.gold;
                }
                case MoneyType.ELIXIR:
                {
                    return this.myInfo.elixir;
                }
                case MoneyType.DARK_ELIXIR:
                {
                    return this.myInfo.darkElixir;
                }
                case MoneyType.COIN:
                {
                    return this.myInfo.coin;
                }
                default:
                {
                    break;
                }
            }
            return -1;
        }// end function

        public function setMoney(param1:String, param2:int) : void
        {
            switch(param1)
            {
                case MoneyType.GOLD:
                {
                    this.myInfo.gold = param2;
                    break;
                }
                case MoneyType.ELIXIR:
                {
                    this.myInfo.elixir = param2;
                    break;
                }
                case MoneyType.DARK_ELIXIR:
                {
                    this.myInfo.darkElixir = param2;
                    break;
                }
                case MoneyType.COIN:
                {
                    this.myInfo.coin = param2;
                    CityMgr.getInstance().guiMainTopRight.runEffectG();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function isMaxResource(param1:String) : Boolean
        {
            var _loc_2:* = this.getMoney(param1);
            var _loc_3:* = this.getMaxCapacity(param1);
            return _loc_2 >= _loc_3;
        }// end function

        public function refreshBuilderList() : void
        {
            var _loc_2:int = 0;
            var _loc_1:int = 0;
            while (_loc_1 < this.myInfo.builderList.length)
            {
                
                _loc_2 = Utility.getCurTime();
                if (this.myInfo.builderList[_loc_1].endTime < _loc_2)
                {
                    this.myInfo.builderList[_loc_1].buildingAutoId = 0;
                    this.myInfo.builderList[_loc_1].endTime = 0;
                }
                _loc_1++;
            }
            return;
        }// end function

        public function getFreeBuilderNumer() : int
        {
            this.refreshBuilderList();
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            while (_loc_2 < this.myInfo.builderList.length)
            {
                
                if (this.myInfo.builderList[_loc_2].endTime == 0)
                {
                    _loc_1++;
                }
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function getFreeBuilder() : int
        {
            var _loc_2:int = 0;
            var _loc_1:int = 0;
            while (_loc_1 < this.myInfo.builderList.length)
            {
                
                _loc_2 = 1;
                if (this.myInfo.builderList[_loc_1].endTime <= _loc_2)
                {
                    return _loc_1;
                }
                _loc_1++;
            }
            return -1;
        }// end function

        public function getNearestBusyBuilder() : int
        {
            var _loc_1:int = 0;
            var _loc_2:int = 1;
            while (_loc_2 < this.myInfo.builderList.length)
            {
                
                if (this.myInfo.builderList[_loc_1].endTime > this.myInfo.builderList[_loc_2].endTime)
                {
                    _loc_1 = _loc_2;
                }
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function takeBuilder(param1:int, param2:int, param3:Number, param4:Boolean = true) : void
        {
            this.myInfo.builderList[param1].endTime = param3;
            this.myInfo.builderList[param1].buildingAutoId = param2;
            if (param4)
            {
                CityMgr.getInstance().createBuilder(param1, this.getBuildingByAutoId(param2), 1);
            }
            ModuleMgr.getInstance().doFunction(CityMgr.UPDATE_BUILDER_LIST);
            return;
        }// end function

        public function updateBuilder(param1:int, param2:Number) : void
        {
            var _loc_3:int = 0;
            while (_loc_3 < this.myInfo.builderList.length)
            {
                
                if (this.myInfo.builderList[_loc_3].buildingAutoId == param1)
                {
                    this.myInfo.builderList[_loc_3].endTime = param2;
                    break;
                }
                _loc_3++;
            }
            return;
        }// end function

        public function freeBuilder(param1:int) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.myInfo.builderList.length)
            {
                
                if (this.myInfo.builderList[_loc_2].buildingAutoId == param1)
                {
                    this.myInfo.builderList[_loc_2].buildingAutoId = 0;
                    this.myInfo.builderList[_loc_2].endTime = 0;
                }
                _loc_2++;
            }
            CityMgr.getInstance().updateBuilder();
            return;
        }// end function

        public function getTroopLevel(param1:String) : int
        {
            if (this.laboratory)
            {
                return this.laboratory.getTroopLevel(param1);
            }
            return 1;
        }// end function

        public function getResearchTime(param1:String, param2:int) : int
        {
            return JsonMgr.getInstance().troop[param1][param2]["researchTime"];
        }// end function

        public function troopLevelUp(param1:String) : void
        {
            var _loc_4:DataResearch = null;
            var _loc_5:int = 0;
            var _loc_2:int = 0;
            while (_loc_2 < this.laboratory.researchList.length)
            {
                
                _loc_4 = this.laboratory.researchList[_loc_2];
                if (_loc_4.researchType == param1)
                {
                    var _loc_6:* = _loc_4;
                    var _loc_7:* = _loc_4.researchLevel + 1;
                    _loc_6.researchLevel = _loc_7;
                    _loc_5 = 0;
                    while (_loc_5 < this.troopList.length)
                    {
                        
                        if (this.troopList[_loc_5].type == param1)
                        {
                            this.troopList[_loc_5].level = _loc_4.researchLevel;
                            break;
                        }
                        _loc_5++;
                    }
                    return;
                }
                _loc_2++;
            }
            var _loc_3:* = new DataResearch();
            _loc_3.researchType = param1;
            _loc_3.researchLevel = 2;
            this.laboratory.researchList.push(_loc_3);
            _loc_5 = 0;
            while (_loc_5 < this.troopList.length)
            {
                
                if (this.troopList[_loc_5].type == param1)
                {
                    this.troopList[_loc_5].level = _loc_3.researchLevel;
                    break;
                }
                _loc_5++;
            }
            return;
        }// end function

        public function loop() : void
        {
            var _loc_1:int = 0;
            _loc_1 = 0;
            while (_loc_1 < this.resourceList.length)
            {
                
                this.resourceList[_loc_1].loop();
                _loc_1++;
            }
            this.loopTrainBarrack();
            _loc_1 = 0;
            while (_loc_1 < this.barrackList.length)
            {
                
                this.barrackList[_loc_1].loop();
                _loc_1++;
            }
            if (this.townHall)
            {
                this.townHall.loop();
            }
            if (this.laboratory)
            {
                this.laboratory.loop();
            }
            _loc_1 = 0;
            while (_loc_1 < this.defenseList.length)
            {
                
                this.defenseList[_loc_1].loop();
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.armyCampList.length)
            {
                
                this.armyCampList[_loc_1].loop();
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.storageList.length)
            {
                
                this.storageList[_loc_1].loop();
                _loc_1++;
            }
            if (this.clanCastle)
            {
                this.clanCastle.loop();
            }
            _loc_1 = 0;
            while (_loc_1 < this.obstacleList.length)
            {
                
                this.obstacleList[_loc_1].loop();
                _loc_1++;
            }
            if (this.spellFactory)
            {
                this.spellFactory.loop();
            }
            return;
        }// end function

        public function getCurrentBuildingNumber(param1:String) : int
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:* = Utility.getTypeObject(param1);
            switch(_loc_4)
            {
                case BuildingType.TOW:
                {
                    return 1;
                }
                case BuildingType.LAB:
                {
                    return this.laboratory != null && this.laboratory.autoId > 0 ? (1) : (0);
                }
                case BuildingType.BAR:
                {
                    return this.barrackList.length;
                }
                case BuildingType.AMC:
                {
                    return this.armyCampList.length;
                }
                case BuildingType.DEF:
                {
                    _loc_3 = 0;
                    while (_loc_3 < this.defenseList.length)
                    {
                        
                        if (this.defenseList[_loc_3].type == param1)
                        {
                            _loc_2++;
                        }
                        _loc_3++;
                    }
                    break;
                }
                case BuildingType.RES:
                {
                    _loc_3 = 0;
                    while (_loc_3 < this.resourceList.length)
                    {
                        
                        if (this.resourceList[_loc_3].type == param1)
                        {
                            _loc_2++;
                        }
                        _loc_3++;
                    }
                    break;
                }
                case BuildingType.STO:
                {
                    _loc_3 = 0;
                    while (_loc_3 < this.storageList.length)
                    {
                        
                        if (this.storageList[_loc_3].type == param1)
                        {
                            _loc_2++;
                        }
                        _loc_3++;
                    }
                    break;
                }
                case BuildingType.WAL:
                {
                    return this.wallList.length;
                }
                case BuildingType.BH:
                {
                    return this.myInfo.builderList.length;
                }
                case BuildingType.TRA:
                {
                    _loc_3 = 0;
                    while (_loc_3 < this.trapList.length)
                    {
                        
                        if (this.trapList[_loc_3].type == param1)
                        {
                            _loc_2++;
                        }
                        _loc_3++;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function arrangeWalls() : void
        {
            var _loc_3:Point = null;
            var _loc_1:* = new Vector.<Point>;
            var _loc_2:int = 0;
            _loc_2 = 0;
            while (_loc_2 < this.wallList.length)
            {
                
                _loc_3 = new Point(this.wallList[_loc_2].posX, this.wallList[_loc_2].posY);
                _loc_1.push(_loc_3);
                _loc_2++;
            }
            _loc_1.sort(this.comparePoint);
            _loc_2 = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                this.wallList[_loc_2].avatar.setAction(AnConst.STAND, 5);
                this.wallList[_loc_2].setPos(_loc_1[_loc_2].x, _loc_1[_loc_2].y);
                this.wallList[_loc_2].updateStatus();
                _loc_2++;
            }
            return;
        }// end function

        private function comparePoint(param1:Point, param2:Point) : int
        {
            if (param1.x > param2.x)
            {
                return 1;
            }
            if (param1.x < param2.x)
            {
                return -1;
            }
            if (param1.y > param2.y)
            {
                return 1;
            }
            if (param1.y < param2.y)
            {
                return -1;
            }
            return 0;
        }// end function

        public function getTotalTroopCapacity() : int
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            while (_loc_2 < this.armyCampList.length)
            {
                
                if (this.armyCampList[_loc_2].status == MapObject.PRODUCING || this.armyCampList[_loc_2].status == MapObject.UPGRADING)
                {
                    _loc_1 = _loc_1 + this.armyCampList[_loc_2].info.capacity;
                }
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function getTotalResourceStorage(param1:String) : int
        {
            var _loc_2:int = 1000;
            if (param1 == BuildingType.DARK_ELIXIR_STORAGE)
            {
                _loc_2 = 0;
            }
            var _loc_3:int = 0;
            while (_loc_3 < this.storageList.length)
            {
                
                if (this.storageList[_loc_3].type == param1)
                {
                    if (this.storageList[_loc_3].status == MapObject.PRODUCING || this.storageList[_loc_3].status == MapObject.UPGRADING)
                    {
                        _loc_2 = _loc_2 + this.storageList[_loc_3].info.capacity;
                    }
                }
                _loc_3++;
            }
            return _loc_2;
        }// end function

        public function getCurrentHousingSpace() : int
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            while (_loc_2 < this.troopList.length)
            {
                
                _loc_1 = _loc_1 + this.troopList[_loc_2].num * Utility.getHousingSpace(this.troopList[_loc_2].type);
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function getClanId() : int
        {
            return this.myClanDetial.clanId;
        }// end function

        public function setClanId(param1:int) : void
        {
            this.myClanDetial.clanId = param1;
            return;
        }// end function

        public function leaveClan() : void
        {
            this.myClanDetial.clanId = 0;
            this.clanCastle.removeClanIcon();
            this.clanCastle.hideStatusBar();
            this.clanCastle.statusIcon.hide();
            this.getRequestClanList = false;
            CityMgr.getInstance().guiContentChat.hide();
            return;
        }// end function

        public function getBuildingList() : Vector.<MapObject>
        {
            var _loc_1:* = new Vector.<MapObject>;
            if (this.townHall)
            {
                _loc_1.push(this.townHall);
            }
            if (this.laboratory)
            {
                _loc_1.push(this.laboratory);
            }
            if (this.clanCastle)
            {
                _loc_1.push(this.clanCastle);
            }
            var _loc_2:int = 0;
            _loc_2 = 0;
            while (_loc_2 < this.armyCampList.length)
            {
                
                _loc_1.push(this.armyCampList[_loc_2]);
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < this.resourceList.length)
            {
                
                _loc_1.push(this.resourceList[_loc_2]);
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < this.storageList.length)
            {
                
                _loc_1.push(this.storageList[_loc_2]);
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < this.defenseList.length)
            {
                
                _loc_1.push(this.defenseList[_loc_2]);
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < this.wallList.length)
            {
                
                _loc_1.push(this.wallList[_loc_2]);
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < this.barrackList.length)
            {
                
                _loc_1.push(this.barrackList[_loc_2]);
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < this.builderHutList.length)
            {
                
                _loc_1.push(this.builderHutList[_loc_2]);
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < this.obstacleList.length)
            {
                
                _loc_1.push(this.obstacleList[_loc_2]);
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < this.trapList.length)
            {
                
                _loc_1.push(this.trapList[_loc_2]);
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function getHouseList() : Vector.<MapObject>
        {
            var _loc_1:* = new Vector.<MapObject>;
            if (this.laboratory)
            {
                _loc_1.push(this.laboratory);
            }
            var _loc_2:int = 0;
            _loc_2 = 0;
            while (_loc_2 < this.resourceList.length)
            {
                
                _loc_1.push(this.resourceList[_loc_2]);
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < this.storageList.length)
            {
                
                _loc_1.push(this.storageList[_loc_2]);
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < this.defenseList.length)
            {
                
                _loc_1.push(this.defenseList[_loc_2]);
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < this.builderHutList.length)
            {
                
                _loc_1.push(this.builderHutList[_loc_2]);
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < this.obstacleList.length)
            {
                
                _loc_1.push(this.obstacleList[_loc_2]);
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function saveMyClan(param1:GetClanDetailMsg) : void
        {
            var _loc_3:ClanMemberInfo = null;
            this.myClanDetial = param1.clanObj;
            this.myClanMembers = new Object();
            var _loc_2:int = 0;
            while (_loc_2 < param1.members.length)
            {
                
                _loc_3 = param1.members[_loc_2];
                this.myClanMembers[_loc_3.uId] = _loc_3;
                _loc_2++;
            }
            if (this.clanCastle)
            {
                this.clanCastle.details = this.myClanDetial;
                this.clanCastle.loadSymbol();
                this.clanCastle.title = ClanMemberInfo(this.myClanMembers[this.myInfo.uId]).clanTitle;
            }
            return;
        }// end function

        public function getTroopHousingSpaceOfClan() : int
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            while (_loc_2 < this.clanCastle.troopList.length)
            {
                
                _loc_1 = _loc_1 + this.clanCastle.troopList[_loc_2].num * Utility.getHousingSpace(this.clanCastle.troopList[_loc_2].type);
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function findAvaiableBarrack() : int
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.barrackList.length)
            {
                
                if (this.barrackList[_loc_1].status == MapObject.PRODUCING)
                {
                    return _loc_1;
                }
                _loc_1++;
            }
            return -1;
        }// end function

        public function splitResources(param1:String) : void
        {
            var _loc_6:Object = null;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_2:Array = [];
            _loc_2.push(this.townHall);
            this.townHall.curResource = 0;
            var _loc_3:int = 0;
            _loc_3 = 0;
            while (_loc_3 < this.storageList.length)
            {
                
                if (this.storageList[_loc_3].type == param1)
                {
                    this.storageList[_loc_3].curResource = 0;
                    _loc_2.push(this.storageList[_loc_3]);
                }
                _loc_3++;
            }
            var _loc_4:* = Localization.getInstance().getString(param1 + "_MONEY");
            var _loc_5:* = this.getMoney(_loc_4);
            while (_loc_5 > 0)
            {
                
                _loc_7 = 0;
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    _loc_6 = _loc_2[_loc_3];
                    if (_loc_6.curResource < _loc_6.info.capacity)
                    {
                        _loc_7++;
                    }
                    _loc_3++;
                }
                _loc_8 = int(_loc_5 / _loc_7);
                if (_loc_7 == 0 || _loc_8 == 0)
                {
                    break;
                }
                _loc_9 = 0;
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    if (_loc_2[_loc_3].curResource < _loc_2[_loc_3].info.capacity)
                    {
                        if (_loc_2[_loc_3].curResource + _loc_8 < _loc_2[_loc_3].info.capacity)
                        {
                            _loc_2[_loc_3].curResource = _loc_2[_loc_3].curResource + _loc_8;
                        }
                        else
                        {
                            _loc_9 = _loc_9 + (_loc_8 + _loc_2[_loc_3].curResource - _loc_2[_loc_3].info.capacity);
                            _loc_2[_loc_3].curResource = _loc_2[_loc_3].info.capacity;
                        }
                    }
                    _loc_3++;
                }
                _loc_5 = _loc_5 - _loc_8 * _loc_7 + _loc_9;
            }
            _loc_3 = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_6 = _loc_2[_loc_3];
                if (_loc_6.curResource < _loc_6.info.capacity)
                {
                    _loc_6.curResource = _loc_6.curResource + _loc_5;
                    break;
                }
                _loc_3++;
            }
            this.updateStorageState();
            return;
        }// end function

        public function updateMaxCapacity() : void
        {
            this.maxGoldCapacity = this.getTotalResourceStorage(BuildingType.GOLD_STORAGE);
            this.maxElixirCapacity = this.getTotalResourceStorage(BuildingType.ELIXIR_STORAGE);
            return;
        }// end function

        public function getMaxCapacity(param1:String) : int
        {
            switch(param1)
            {
                case MoneyType.GOLD:
                {
                    return this.maxGoldCapacity;
                }
                case MoneyType.ELIXIR:
                {
                    return this.maxElixirCapacity;
                }
                case MoneyType.DARK_ELIXIR:
                {
                    return this.maxDarkElixirCapacity;
                }
                default:
                {
                    break;
                }
            }
            return 0;
        }// end function

        public function updateStorageState() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.storageList.length)
            {
                
                this.storageList[_loc_1].update();
                _loc_1++;
            }
            return;
        }// end function

        public function getPointSingleMapInfo(param1:int) : PointMap
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.singleMapInfo.length)
            {
                
                if (this.singleMapInfo[_loc_2].pId == param1)
                {
                    return this.singleMapInfo[_loc_2];
                }
                _loc_2++;
            }
            var _loc_3:* = JsonMgr.getInstance().singleBattle;
            var _loc_4:PointMap = null;
            if (_loc_3[param1])
            {
                _loc_4 = new PointMap();
                _loc_4.pId = param1;
                _loc_4.nStar = 0;
                _loc_4.gold = _loc_3[param1]["gold"];
                _loc_4.elixir = _loc_3[param1]["elixir"];
                _loc_4.level = _loc_3[param1]["level"];
                this.singleMapInfo.push(_loc_4);
            }
            return _loc_4;
        }// end function

        public function addNewClanMember(param1:ClanMemberInfo) : void
        {
            this.myClanMembers[param1.uId] = param1;
            return;
        }// end function

        public function removeObstacle(param1:int) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.obstacleList.length)
            {
                
                if (this.obstacleList[_loc_2].autoId == param1)
                {
                    MapMgr.getInstance().unSetBuilding(this.obstacleList[_loc_2]);
                    this.obstacleList[_loc_2].effectRemoveObstacle();
                    this.obstacleList[_loc_2] = null;
                    this.obstacleList.splice(_loc_2, 1);
                    GameDataMgr.getInstance().freeBuilder(param1);
                    break;
                }
                _loc_2++;
            }
            return;
        }// end function

        public function getBuildingByAutoId(param1:int) : MapObject
        {
            var _loc_2:* = GameDataMgr.getInstance().getBuildingList();
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                if (_loc_2[_loc_3].autoId == param1)
                {
                    return _loc_2[_loc_3];
                }
                _loc_3++;
            }
            return null;
        }// end function

        public function showIconHarvest(param1:Boolean, param2:String) : void
        {
            var _loc_3:int = 0;
            var _loc_4:ResourceObject = null;
            _loc_3 = 0;
            while (_loc_3 < this.resourceList.length)
            {
                
                _loc_4 = this.resourceList[_loc_3];
                if (_loc_4.type == param2)
                {
                    _loc_4.loadHarvestIcon(param1);
                }
                _loc_3++;
            }
            return;
        }// end function

        public function changeMemberTitle(param1:int, param2:int, param3:int) : void
        {
            if (this.myClanMembers[param1])
            {
                ClanMemberInfo(this.myClanMembers[param1]).clanTitle = param2;
            }
            if (this.myInfo.uId == param1)
            {
                this.clanCastle.title = param2;
            }
            return;
        }// end function

        public function addShieldTime(param1:Number) : void
        {
            var _loc_2:* = Utility.getCurTime();
            if (this.myInfo.shieldTime < _loc_2)
            {
                this.myInfo.shieldTime = _loc_2;
            }
            this.myInfo.shieldTime = this.myInfo.shieldTime + param1;
            CityMgr.getInstance().guiMainTop.updateShield();
            return;
        }// end function

        public function getWallAt(param1:int, param2:int) : WallObject
        {
            var _loc_3:int = 0;
            while (_loc_3 < this.wallList.length)
            {
                
                if (this.wallList[_loc_3].posX == param1 && this.wallList[_loc_3].posY == param2)
                {
                    return this.wallList[_loc_3];
                }
                _loc_3++;
            }
            return null;
        }// end function

        private function loopTrainBarrack() : void
        {
            var _loc_4:Number = NaN;
            if (GlobalVar.state != GlobalVar.STATE_MYHOME)
            {
                return;
            }
            var _loc_1:int = -1;
            var _loc_2:* = Number.MAX_VALUE;
            var _loc_3:int = 0;
            while (_loc_3 < this.barrackList.length)
            {
                
                _loc_4 = this.barrackList[_loc_3].getEndTimeForTrain();
                if (_loc_4 < _loc_2)
                {
                    _loc_2 = _loc_4;
                    _loc_1 = _loc_3;
                }
                _loc_3++;
            }
            if (_loc_1 != -1 && _loc_2 < Number.MAX_VALUE)
            {
                if (!this.hasSentFinishTroop)
                {
                    CityMgr.getInstance().sendFinishTraningTroop(this.barrackList[_loc_1].trainingTroop[0]["type"], this.barrackList[_loc_1].autoId);
                    this.hasSentFinishTroop = true;
                }
            }
            return;
        }// end function

        public static function getInstance() : GameDataMgr
        {
            if (_inst == null)
            {
                _inst = new GameDataMgr;
            }
            return _inst;
        }// end function

    }
}
