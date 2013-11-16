package modules.city.graphics.build
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import modules.city.*;
    import modules.city.logic.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class GuiUpgradeBuilding extends BaseGui
    {
        public var labelMoneyNeed:TextField;
        public var labelUpgradeLevel:TextField;
        public var labelBuildTime:TextField;
        public var labelNotice:TextField;
        public var labelRequire:TextField;
        public var labelUnlock:TextField;
        public var bmpUpgrade:BitmapButton;
        private var imgIconMoney:Sprite = null;
        private var isEnoughMoney:Boolean;
        private var curMoneyType:String;
        private var moneyNeed:int;
        private var endTime:int;
        private var gemNeed:int;
        private var listItem:Vector.<GuiUpgradeBuildingItem>;
        private var unlockList:GuiUnlockBuildingsList;
        private var curObject:MapObject = null;
        private var imageBuilding:Sprite = null;
        public static var startIconX:int = 231;
        public static var startIconY:int = 65;
        private static const BTN_UPGRADE:String = "bmpUpgrade";
        private static const BTN_CLOSE:String = "bmpCloseUpgrade";

        public function GuiUpgradeBuilding()
        {
            this.listItem = new Vector.<GuiUpgradeBuildingItem>;
            super(ResMgr.getInstance().getMovieClip("UpgradeBuildingGui") as MovieClip);
            autoAlign = AUTO_ALIGN_CENTER;
            enableDisableScreen = true;
            enableClickOutToClose = true;
            this.labelMoneyNeed.mouseEnabled = false;
            this.unlockList = new GuiUnlockBuildingsList();
            this.unlockList.setPos(42, 242);
            addGui(this.unlockList);
            this.unlockList.bgImg.visible = false;
            return;
        }// end function

        public function loadInfoUpgrade(param1:MapObject) : void
        {
            var _loc_3:LaboratoryObject = null;
            var _loc_4:LaboratoryObject = null;
            var _loc_5:ResourceObject = null;
            var _loc_6:ResourceObject = null;
            var _loc_7:DataBuildingInfo = null;
            var _loc_8:String = null;
            var _loc_9:DefenseObject = null;
            var _loc_10:DefenseObject = null;
            var _loc_11:StorageObject = null;
            var _loc_12:StorageObject = null;
            var _loc_13:DataBuildingInfo = null;
            var _loc_14:String = null;
            var _loc_15:ArmyCampObject = null;
            var _loc_16:ArmyCampObject = null;
            var _loc_17:ClanObject = null;
            var _loc_18:ClanObject = null;
            var _loc_19:WallObject = null;
            var _loc_20:WallObject = null;
            var _loc_21:BarrackObject = null;
            var _loc_22:BarrackObject = null;
            var _loc_23:TownHallObject = null;
            var _loc_24:TownHallObject = null;
            this.curObject = param1;
            if (!param1)
            {
                return;
            }
            this.removeAllItem();
            this.removeAllUnlockItem();
            var _loc_2:* = param1.type.split("_");
            switch(_loc_2[0])
            {
                case BuildingType.BAR:
                {
                    _loc_21 = param1 as BarrackObject;
                    _loc_22 = new BarrackObject();
                    _loc_22.level = param1.level + 1;
                    _loc_22.loadConfigData();
                    this.setCommonInfoUpgrade(_loc_22.level, _loc_21.type, _loc_22.info.buildTime, _loc_22.info.elixir, MoneyType.ELIXIR, _loc_22.info.townHallLevelRequired);
                    this.setBarrackUpgradeIndexes(_loc_21, _loc_22);
                    this.unlockWarrior(_loc_22.info.unlockedUnit);
                    break;
                }
                case BuildingType.TOW:
                {
                    _loc_23 = param1 as TownHallObject;
                    _loc_24 = new TownHallObject();
                    _loc_24.level = param1.level + 1;
                    _loc_24.loadConfigData();
                    this.setCommonInfoUpgrade(_loc_24.level, _loc_23.type, _loc_24.info.buildTime, _loc_24.info.gold, MoneyType.GOLD, 0);
                    this.setTownHallUpgradeIndexes(_loc_23, _loc_24);
                    this.unlockBuildings(_loc_23, _loc_24);
                    break;
                }
                case BuildingType.LAB:
                {
                    _loc_3 = param1 as LaboratoryObject;
                    _loc_4 = new LaboratoryObject();
                    _loc_4.level = param1.level + 1;
                    _loc_4.loadConfigData();
                    this.setCommonInfoUpgrade(_loc_4.level, _loc_3.type, _loc_4.info.buildTime, _loc_4.info.elixir, MoneyType.ELIXIR, _loc_4.info.townHallLevelRequired);
                    this.setLaboratoryUpgradeIndex(_loc_3, _loc_4);
                    break;
                }
                case BuildingType.RES:
                {
                    _loc_5 = param1 as ResourceObject;
                    _loc_6 = new ResourceObject();
                    _loc_6.level = param1.level + 1;
                    _loc_6.type = param1.type;
                    _loc_6.loadConfigData();
                    _loc_7 = Utility.getInfoToBuild(_loc_5.type, _loc_6.level);
                    this.setCommonInfoUpgrade(_loc_6.level, _loc_5.type, _loc_6.info.buildTime, _loc_7.cost.value, _loc_7.cost.type, _loc_6.info.townHallLevelRequired);
                    _loc_8 = Localization.getInstance().getString(_loc_5.type + "_MONEY");
                    this.setResourcesUpgradeIndex(_loc_8, _loc_5, _loc_6);
                    break;
                }
                case BuildingType.DEF:
                {
                    _loc_9 = param1 as DefenseObject;
                    _loc_10 = new DefenseObject();
                    _loc_10.level = param1.level + 1;
                    _loc_10.type = _loc_9.type;
                    _loc_10.loadConfigData();
                    this.setCommonInfoUpgrade(_loc_10.level, _loc_9.type, _loc_10.info.upgradeTime, _loc_10.info.gold, MoneyType.GOLD, _loc_10.info.townHallLevelRequired);
                    this.setDefenseUpgradeIndex(_loc_9, _loc_10);
                    break;
                }
                case BuildingType.STO:
                {
                    _loc_11 = param1 as StorageObject;
                    _loc_12 = new StorageObject();
                    _loc_12.level = param1.level + 1;
                    _loc_12.type = _loc_11.type;
                    _loc_12.loadConfigData();
                    _loc_13 = Utility.getInfoToBuild(_loc_11.type, _loc_12.level);
                    this.setCommonInfoUpgrade(_loc_12.level, _loc_11.type, _loc_12.info.buildTime, _loc_13.cost.value, _loc_13.cost.type, _loc_12.info.townHallLevelRequired);
                    _loc_14 = Localization.getInstance().getString(_loc_11.type + "_MONEY");
                    this.setStorageUpgradeIndex(_loc_11, _loc_12, _loc_14);
                    break;
                }
                case BuildingType.AMC:
                {
                    _loc_15 = param1 as ArmyCampObject;
                    _loc_16 = new ArmyCampObject();
                    _loc_16.level = param1.level + 1;
                    _loc_16.type = _loc_15.type;
                    _loc_16.loadConfigData();
                    this.setCommonInfoUpgrade(_loc_16.level, _loc_15.type, _loc_16.info.buildTime, _loc_16.info.elixir, MoneyType.ELIXIR, _loc_16.info.townHallLevelRequired);
                    this.setArmyCampUpgradeIndex(_loc_15, _loc_16);
                    break;
                }
                case BuildingType.CAT:
                {
                    _loc_17 = param1 as ClanObject;
                    _loc_18 = new ClanObject();
                    _loc_18.level = param1.level + 1;
                    _loc_18.type = param1.type;
                    _loc_18.loadConfigData();
                    this.setCommonInfoUpgrade(_loc_18.level, _loc_17.type, _loc_18.info.upgradeTime, _loc_18.info.gold, MoneyType.GOLD, _loc_18.info.townHallLevelRequired);
                    this.setClanCastleUpgradeIndex(_loc_17, _loc_18);
                    break;
                }
                case BuildingType.WAL:
                {
                    _loc_19 = param1 as WallObject;
                    _loc_20 = new WallObject();
                    _loc_20.level = param1.level + 1;
                    _loc_20.type = param1.type;
                    _loc_20.loadConfigData();
                    this.setCommonInfoUpgrade(_loc_20.level, _loc_19.type, _loc_20.info.upgradeTime, _loc_20.info.gold, MoneyType.GOLD, _loc_20.info.townHallLevelRequired);
                    this.setWallUpgradeIndex(_loc_19, _loc_20);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function loadImageBuilding(param1:String, param2:int) : void
        {
            if (this.imageBuilding && this.imageBuilding.parent != null)
            {
                this.imageBuilding.parent.removeChild(this.imageBuilding);
                this.imageBuilding = null;
            }
            var _loc_3:* = Utility.getContentImage(param1, param2, false);
            this.imageBuilding = ResMgr.getInstance().getMovieClip(_loc_3);
            this.img.addChild(this.imageBuilding);
            this.imageBuilding.x = 127 - this.imageBuilding.width / 2;
            this.imageBuilding.y = 125 - this.imageBuilding.height / 2;
            return;
        }// end function

        private function setCommonInfoUpgrade(param1:int, param2:String, param3:int, param4:int, param5:String, param6:int) : void
        {
            this.labelUpgradeLevel.text = Localization.getInstance().getString("Upgrade0") + " " + param1;
            this.labelBuildTime.text = Utility.convertTimeToString(param3, true, true, true, true);
            this.labelUnlock.visible = false;
            this.labelNotice.visible = false;
            this.labelRequire.visible = false;
            this.bmpUpgrade.enable = true;
            this.loadImageBuilding(param2, param1);
            if (param2 != BuildingType.TOWN_HALL && param6 > 0)
            {
                if (GameDataMgr.getInstance().townHall.level < param6)
                {
                    this.labelNotice.visible = true;
                    this.labelRequire.visible = true;
                    this.labelRequire.text = Localization.getInstance().getString("TownHallLevelRequired") + " " + param6;
                }
                this.bmpUpgrade.enable = GameDataMgr.getInstance().townHall.level >= param6;
            }
            if (this.imgIconMoney)
            {
                this.bmpUpgrade.img.removeChild(this.imgIconMoney);
                this.imgIconMoney = null;
            }
            this.imgIconMoney = ResMgr.getInstance().getMovieClip(param5 + "_Medium_Icon") as Sprite;
            this.bmpUpgrade.img.addChild(this.imgIconMoney);
            this.imgIconMoney.x = this.bmpUpgrade.width - this.imgIconMoney.width * (2 / 3);
            this.imgIconMoney.y = (this.bmpUpgrade.height - this.imgIconMoney.height) / 2;
            this.curMoneyType = param5;
            this.moneyNeed = param4;
            this.endTime = param3;
            this.isEnoughMoney = GameDataMgr.getInstance().getMoney(param5) >= param4;
            this.labelMoneyNeed.textColor = this.isEnoughMoney ? (16776933) : (16728128);
            this.labelMoneyNeed.text = Utility.standardNumber(this.moneyNeed);
            return;
        }// end function

        private function removeAllItem() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.listItem.length)
            {
                
                this.listItem[_loc_1].destroyBaseGUI();
                this.listItem[_loc_1] = null;
                _loc_1++;
            }
            this.listItem.splice(0, this.listItem.length);
            this.listItem = new Vector.<GuiUpgradeBuildingItem>;
            return;
        }// end function

        private function removeAllUnlockItem() : void
        {
            this.unlockList.bgImg.visible = false;
            return;
        }// end function

        private function addIndexItem(param1:String, param2:int, param3:int, param4:int, param5:int) : void
        {
            var _loc_6:* = new GuiUpgradeBuildingItem();
            new GuiUpgradeBuildingItem().setPos(startIconX, startIconY + param5 * (_loc_6.heightBg + 5));
            _loc_6.loadUpgradeItem(param1, param4, param2, param3);
            this.bgImg.addChild(_loc_6.bgImg);
            this.listItem.push(_loc_6);
            return;
        }// end function

        private function setBarrackUpgradeIndexes(param1:BarrackObject, param2:BarrackObject) : void
        {
            var _loc_3:* = JsonMgr.getInstance().getMaxConfigBarrack();
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_HITPOINTS, param1.info.hitpoints, param2.info.hitpoints, _loc_3.hitpoints, 0);
            return;
        }// end function

        private function setTownHallUpgradeIndexes(param1:TownHallObject, param2:TownHallObject) : void
        {
            var _loc_3:* = JsonMgr.getInstance().getMaxConfigTownHall();
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_GOLD_CAPACITY, param1.info.capacity, param2.info.capacity, _loc_3.capacity, 0);
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_ELIXIR_CAPACITY, param1.info.capacity, param2.info.capacity, _loc_3.capacity, 1);
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_HITPOINTS, param1.info.hitpoints, param2.info.hitpoints, _loc_3.hitpoints, 2);
            return;
        }// end function

        private function setLaboratoryUpgradeIndex(param1:LaboratoryObject, param2:LaboratoryObject) : void
        {
            var _loc_3:* = JsonMgr.getInstance().getMaxConfigLaboratory();
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_HITPOINTS, param1.info.hitpoints, param2.info.hitpoints, _loc_3.hitpoints, 0);
            return;
        }// end function

        private function setResourcesUpgradeIndex(param1:String, param2:ResourceObject, param3:ResourceObject) : void
        {
            var _loc_4:* = JsonMgr.getInstance().getMaxConfigResources(param2.type);
            this.addIndexItem(param1 + "_Capacity_Icon", param2.info.capacity, param3.info.capacity, _loc_4.capacity, 0);
            this.addIndexItem(param1 + "_ProductionRate_Icon", param2.info.productivity, param3.info.productivity, _loc_4.productivity, 1);
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_HITPOINTS, param2.info.hitpoints, param3.info.hitpoints, _loc_4.hitpoints, 2);
            return;
        }// end function

        private function setDefenseUpgradeIndex(param1:DefenseObject, param2:DefenseObject) : void
        {
            var _loc_3:* = JsonMgr.getInstance().getMaxConfigDefense(param1.type);
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_DAMAGE, param1.info.damagePerSecond, param2.info.damagePerSecond, _loc_3.damagePerSecond, 0);
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_HITPOINTS, param1.info.hitpoints, param2.info.hitpoints, _loc_3.hitpoints, 1);
            return;
        }// end function

        private function setStorageUpgradeIndex(param1:StorageObject, param2:StorageObject, param3:String) : void
        {
            var _loc_4:* = JsonMgr.getInstance().getMaxConfigStorage(param1.type);
            this.addIndexItem(param3 + "_Capacity_Icon", param1.info.capacity, param2.info.capacity, _loc_4.capacity, 0);
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_HITPOINTS, param1.info.hitpoints, param2.info.hitpoints, _loc_4.hitpoints, 1);
            return;
        }// end function

        private function setArmyCampUpgradeIndex(param1:ArmyCampObject, param2:ArmyCampObject) : void
        {
            var _loc_3:* = JsonMgr.getInstance().getMaxConfigArmyCamp();
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_TROOP_CAPACITY, param1.info.capacity, param2.info.capacity, _loc_3.capacity, 0);
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_HITPOINTS, param1.info.hitpoints, param2.info.hitpoints, _loc_3.hitpoints, 1);
            return;
        }// end function

        private function setClanCastleUpgradeIndex(param1:ClanObject, param2:ClanObject) : void
        {
            var _loc_3:* = JsonMgr.getInstance().getMaxConfigClanCastle();
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_TROOP_CAPACITY, param1.info.troopCapacity, param2.info.troopCapacity, _loc_3.troopCapacity, 0);
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_HITPOINTS, param1.info.hitpoints, param2.info.hitpoints, _loc_3.hitpoints, 1);
            return;
        }// end function

        private function setWallUpgradeIndex(param1:WallObject, param2:WallObject) : void
        {
            var _loc_3:* = JsonMgr.getInstance().getMaxConfigWall();
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_HITPOINTS, param1.info.hitpoints, param2.info.hitpoints, _loc_3.hitpoints, 0);
            return;
        }// end function

        private function unlockBuildings(param1:TownHallObject, param2:TownHallObject) : void
        {
            this.labelUnlock.text = Localization.getInstance().getString("UnlockTownHall");
            this.labelUnlock.visible = true;
            this.unlockList.loadUnlockBuildingItems(param2.level);
            this.unlockList.bgImg.visible = true;
            return;
        }// end function

        private function unlockWarrior(param1:String) : void
        {
            this.labelUnlock.text = Localization.getInstance().getString("UnlockWarrior");
            this.labelUnlock.visible = true;
            this.unlockList.loadUnlockWarrior(param1);
            this.unlockList.bgImg.visible = true;
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BTN_UPGRADE:
                {
                    CityMgr.getInstance().prepareToUpgradeBuilding(this.curObject, this.moneyNeed, this.curMoneyType, this.endTime);
                    break;
                }
                case BTN_CLOSE:
                {
                    hide(true);
                    CityMgr.getInstance().showBuildingActionGui(this.curObject);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
