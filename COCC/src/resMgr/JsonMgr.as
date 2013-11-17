package resMgr
{
    import gameData.*;
    import resMgr.data.*;
    import utility.*;

    public class JsonMgr extends Object
    {
        public var armyCamp:Object;
        public var barrack:Object;
        public var laboratory:Object;
        public var resource:Object;
        public var spellFactory:Object;
        public var storage:Object;
        public var townHall:Object;
        public var troop:Object;
        public var troopBase:Object;
        public var wall:Object;
        public var defense:Object;
        public var defenseBase:Object;
        public var clanCastle:Object;
        public var buildCap:Object;
        public var builderHut:Object;
        public var contentName:Object;
        public var sound:Object;
        public var music:Object;
        public var ambience:Array;
        public var singleBattle:Object;
        public var findPrice:Object;
        public var obstacles:Object;
        public var sideQuest:Object;
        public var sideQuestReward:Object;
        public var levelUser:Object;
        public var trap:Object;
        public var shields:Object;
        private static var _inst:JsonMgr;

        public function JsonMgr()
        {
            return;
        }// end function

        public function setArmyCampConfig(param1:Object) : void
        {
            this.armyCamp = param1;
            return;
        }// end function

        public function setSound(param1:Object) : void
        {
            this.sound = param1;
            return;
        }// end function

        public function getSoundRandom(param1:String) : DataSound
        {
            var _loc_2:* = new DataSound();
            var _loc_3:* = this.sound[param1];
            var _loc_4:* = Math.random() * _loc_3.length;
            _loc_2.name = _loc_3[_loc_4].Name;
            _loc_2.volume = _loc_3[_loc_4].Volume;
            return _loc_2;
        }// end function

        public function getMusic(param1:String) : DataSound
        {
            var _loc_2:* = new DataSound();
            var _loc_3:* = this.music[param1];
            _loc_2.name = _loc_3.Name;
            _loc_2.volume = _loc_3.Volume;
            return _loc_2;
        }// end function

        public function getAmbienceRandom() : DataSound
        {
            var _loc_1:* = new DataSound();
            var _loc_2:* = int(Math.random() * this.ambience.length);
            var _loc_3:* = this.ambience[_loc_2];
            _loc_1.name = _loc_3.Name;
            _loc_1.volume = _loc_3.Volume;
            return _loc_1;
        }// end function

        public function setContentName(param1:Object) : void
        {
            this.contentName = param1;
            return;
        }// end function

        public function setBarrackConfig(param1:Object) : void
        {
            this.barrack = param1;
            return;
        }// end function

        public function setLaboratoryConfig(param1:Object) : void
        {
            this.laboratory = param1;
            return;
        }// end function

        public function setResourceConfig(param1:Object) : void
        {
            this.resource = param1;
            return;
        }// end function

        public function setSpellFactoryConfig(param1:Object) : void
        {
            this.spellFactory = param1;
            return;
        }// end function

        public function setStorageConfig(param1:Object) : void
        {
            this.storage = param1;
            return;
        }// end function

        public function setTownHallConfig(param1:Object) : void
        {
            this.townHall = param1;
            return;
        }// end function

        public function setTroopConfig(param1:Object) : void
        {
            this.troop = param1;
            return;
        }// end function

        public function setTroopBaseConfig(param1:Object) : void
        {
            this.troopBase = param1;
            return;
        }// end function

        public function setWallConfig(param1:Object) : void
        {
            this.wall = param1;
            return;
        }// end function

        public function setDefenseConfig(param1:Object) : void
        {
            this.defense = param1;
            return;
        }// end function

        public function setDefenseBaseConfig(param1:Object) : void
        {
            this.defenseBase = param1;
            return;
        }// end function

        public function setClanCastleConfig(param1:Object) : void
        {
            this.clanCastle = param1;
            return;
        }// end function

        public function setBuildCapConfig(param1:Object) : void
        {
            this.buildCap = param1;
            return;
        }// end function

        public function setBuilderHutConfig(param1:Object) : void
        {
            this.builderHut = param1;
            return;
        }// end function

        public function getTownHallData(param1:int) : DataTownHall
        {
            var _loc_2:* = this.townHall[BuildingType.TOWN_HALL][param1.toString()];
            var _loc_3:* = new DataTownHall();
            Utility.setData(_loc_3, _loc_2);
            return _loc_3;
        }// end function

        public function getBarrackData(param1:int) : DataBarrack
        {
            var _loc_2:* = this.barrack[BuildingType.BARRACK][param1.toString()];
            var _loc_3:* = new DataBarrack();
            Utility.setData(_loc_3, _loc_2);
            return _loc_3;
        }// end function

        public function getArmyCampData(param1:int) : DataArmyCamp
        {
            var _loc_2:* = this.armyCamp[BuildingType.ARMY_CAMP][param1.toString()];
            var _loc_3:* = new DataArmyCamp();
            Utility.setData(_loc_3, _loc_2);
            return _loc_3;
        }// end function

        public function getResourcesData(param1:String, param2:int) : DataResources
        {
            var _loc_3:* = this.resource[param1][param2.toString()];
            var _loc_4:* = new DataResources();
            Utility.setData(_loc_4, _loc_3);
            return _loc_4;
        }// end function

        public function getStoragesData(param1:String, param2:int) : DataStorages
        {
            var _loc_3:* = this.storage[param1][param2.toString()];
            var _loc_4:* = new DataStorages();
            Utility.setData(_loc_4, _loc_3);
            return _loc_4;
        }// end function

        public function getDefensesData(param1:String, param2:int) : DataDefenses
        {
            var _loc_3:* = this.defense[param1][param2.toString()];
            var _loc_4:* = new DataDefenses();
            Utility.setData(_loc_4, _loc_3);
            Utility.setData(_loc_4, this.defenseBase[param1]);
            _loc_4.id = param1;
            return _loc_4;
        }// end function

        public function getObstacleData(param1:String) : DataObctacle
        {
            var _loc_2:* = this.obstacles[param1];
            var _loc_3:* = new DataObctacle();
            Utility.setData(_loc_3, _loc_2);
            _loc_3.id = param1;
            return _loc_3;
        }// end function

        public function getWallData(param1:int) : DataWall
        {
            var _loc_2:* = this.wall["WAL_1"][param1.toString()];
            var _loc_3:* = new DataWall();
            Utility.setData(_loc_3, _loc_2);
            return _loc_3;
        }// end function

        public function getInfoTroop(param1:String, param2:int) : TroopInfo
        {
            var _loc_3:* = new TroopInfo();
            Utility.setData(_loc_3, this.troopBase[param1]);
            Utility.setData(_loc_3, this.troop[param1][param2.toString()]);
            _loc_3.level = param2;
            _loc_3.id = param1;
            return _loc_3;
        }// end function

        public function getLaboratoryData(param1:int) : DataLaboratory
        {
            var _loc_2:* = this.laboratory[BuildingType.LABORATORY][param1.toString()];
            var _loc_3:* = new DataLaboratory();
            Utility.setData(_loc_3, _loc_2);
            return _loc_3;
        }// end function

        public function getClanCastleData(param1:int) : DataClanCastle
        {
            var _loc_2:* = this.clanCastle[BuildingType.CLAN_CASTLE][param1.toString()];
            var _loc_3:* = new DataClanCastle();
            Utility.setData(_loc_3, _loc_2);
            return _loc_3;
        }// end function

        public function getBuilderHutData(param1:int) : DataBuilderHut
        {
            var _loc_2:* = this.builderHut[BuildingType.BUILDER_HUT][param1.toString()];
            var _loc_3:* = new DataBuilderHut();
            Utility.setData(_loc_3, _loc_2);
            return _loc_3;
        }// end function

        public function getTroopBase() : Object
        {
            return this.troopBase;
        }// end function

        public function getTroop() : Object
        {
            return this.troop;
        }// end function

        public function getMaxConfigTownHall() : DataTownHall
        {
            var _loc_1:* = this.getConfigMaxLevel(BuildingType.TOWN_HALL);
            return this.getTownHallData(_loc_1);
        }// end function

        public function getMaxConfigBarrack() : DataBarrack
        {
            var _loc_1:* = this.getConfigMaxLevel(BuildingType.BARRACK);
            return this.getBarrackData(_loc_1);
        }// end function

        public function getMaxConfigInfoTroop(param1:String) : TroopInfo
        {
            var _loc_2:* = this.getConfigMaxLevel(param1);
            return this.getInfoTroop(param1, _loc_2);
        }// end function

        public function getMaxConfigLaboratory() : DataLaboratory
        {
            var _loc_1:* = this.getConfigMaxLevel(BuildingType.LABORATORY);
            return this.getLaboratoryData(_loc_1);
        }// end function

        public function getMaxConfigResources(param1:String) : DataResources
        {
            var _loc_2:* = this.getConfigMaxLevel(param1);
            return this.getResourcesData(param1, _loc_2);
        }// end function

        public function getMaxConfigDefense(param1:String) : DataDefenses
        {
            var _loc_2:* = this.getConfigMaxLevel(param1);
            return this.getDefensesData(param1, _loc_2);
        }// end function

        public function getMaxConfigStorage(param1:String) : DataStorages
        {
            var _loc_2:* = this.getConfigMaxLevel(param1);
            return this.getStoragesData(param1, _loc_2);
        }// end function

        public function getMaxConfigArmyCamp() : DataArmyCamp
        {
            var _loc_1:* = this.getConfigMaxLevel(BuildingType.ARMY_CAMP);
            return this.getArmyCampData(_loc_1);
        }// end function

        public function getMaxConfigClanCastle() : DataClanCastle
        {
            var _loc_1:* = this.getConfigMaxLevel(BuildingType.CLAN_CASTLE);
            return this.getClanCastleData(_loc_1);
        }// end function

        public function getMaxConfigWall() : DataWall
        {
            var _loc_1:* = this.getConfigMaxLevel(BuildingType.WALL);
            return this.getWallData(_loc_1);
        }// end function

        public function getConfigMaxLevel(param1:String) : int
        {
            return this.buildCap[param1];
        }// end function

        public function setSingleBattle(param1:Object) : void
        {
            this.singleBattle = param1;
            return;
        }// end function

        public function getMaxConfigSingleBattle() : int
        {
            return this.buildCap["singlePlayerMap"];
        }// end function

        public function getMaxConfigSideQuest(param1:String) : int
        {
            var _loc_2:String = null;
            var _loc_3:int = 0;
            for (_loc_2 in this.sideQuest[param1])
            {
                
                _loc_3++;
            }
            return _loc_3;
        }// end function

        public function setFindPrice(param1:Object) : void
        {
            this.findPrice = param1;
            return;
        }// end function

        public function setMusic(param1:Object) : void
        {
            this.music = param1;
            return;
        }// end function

        public function setAmbience(param1:Object) : void
        {
            this.ambience = param1 as Array;
            return;
        }// end function

        public function setObstacles(param1:Object) : void
        {
            this.obstacles = param1;
            return;
        }// end function

        public function setSideQuest(param1:Object) : void
        {
            this.sideQuest = param1;
            return;
        }// end function

        public function getDataQuest(param1:String, param2:int) : DataSideQuest
        {
            var _loc_4:String = null;
            var _loc_3:* = new DataSideQuest();
            for (_loc_4 in this.sideQuest[param1])
            {
                
                if (this.sideQuest[param1][_loc_4]["id"] == param2)
                {
                    Utility.setData(_loc_3, this.sideQuest[param1][_loc_4]);
                    Utility.setData(_loc_3, this.sideQuestReward[param1][_loc_4]);
                    return _loc_3;
                }
            }
            return null;
        }// end function

        public function setSideQuestReward(param1:Object) : void
        {
            this.sideQuestReward = param1;
            return;
        }// end function

        public function setLevelUser(param1:Object) : void
        {
            this.levelUser = param1;
            return;
        }// end function

        public function setTrap(param1:Object) : void
        {
            this.trap = param1;
            return;
        }// end function

        public function getTrapData(param1:String) : DataTrap
        {
            var _loc_2:* = this.trap[param1];
            var _loc_3:* = new DataTrap();
            Utility.setData(_loc_3, _loc_2);
            _loc_3.id = param1;
            return _loc_3;
        }// end function

        public function setShieldPrice(param1:Object) : void
        {
            this.shields = param1;
            return;
        }// end function

        public function getShieldData(param1:int) : DataShield
        {
            var _loc_2:* = this.shields[param1];
            var _loc_3:* = new DataShield();
            Utility.setData(_loc_3, _loc_2);
            return _loc_3;
        }// end function

        public function getLevelForGetMoreBuildings(param1:String, param2:int) : int
        {
            var _loc_3:String = null;
            var _loc_4:String = null;
            for (_loc_3 in this.townHall[BuildingType.TOWN_HALL])
            {
                
                for (_loc_4 in this.townHall[BuildingType.TOWN_HALL][_loc_3])
                {
                    
                    if (_loc_4 == param1 && this.townHall[BuildingType.TOWN_HALL][_loc_3][_loc_4] > param2)
                    {
                        return parseInt(_loc_3, 10);
                    }
                }
            }
            return -1;
        }// end function

        public static function getInstance() : JsonMgr
        {
            if (_inst == null)
            {
                _inst = new JsonMgr;
            }
            return _inst;
        }// end function

    }
}
