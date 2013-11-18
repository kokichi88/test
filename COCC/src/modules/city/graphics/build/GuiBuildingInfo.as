package modules.city.graphics.build
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import modules.city.*;
    import modules.city.graphics.troop.*;
    import modules.city.logic.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class GuiBuildingInfo extends BaseGui
    {
        private var listItem:Vector.<GuiUpgradeBuildingItem>;
        public var labelBuildingName:TextField;
        public var labelInformation:TextField;
        public var labelTextWait:TextField;
        public var labelTimeWait:TextField;
        public var labelTextSafe:TextField;
        public var labelTimeSafe:TextField;
        public var labelTextTarget:TextField;
        public var labelTarget:TextField;
        private var guiTroopInside:GuiTroopInside;
        public var curBuilding:MapObject = null;
        private var imageBuilding:Sprite = null;
        public var isShopItem:Boolean = false;
        private static const BTN_CLOSE:String = "bmpClose";
        public static var startIconX:int = 230;
        public static var startIconY:int = 60;

        public function GuiBuildingInfo()
        {
            this.listItem = new Vector.<GuiUpgradeBuildingItem>;
            super(ResMgr.getInstance().getMovieClip("BuildingInfoGui") as MovieClip);
            autoAlign = AUTO_ALIGN_CENTER;
            enableDisableScreen = true;
            enableClickOutToClose = true;
            this.guiTroopInside = new GuiTroopInside();
            this.guiTroopInside.setPos(52, 260);
            addGui(this.guiTroopInside);
            this.guiTroopInside.bgImg.visible = false;
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            super.hide(param1);
            if (param1 && !this.isShopItem)
            {
                CityMgr.getInstance().showBuildingActionGui(this.curBuilding);
            }
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BTN_CLOSE:
                {
                    this.hide(true);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function loadImageBuilding(param1:String) : void
        {
            if (this.imageBuilding && this.imageBuilding.parent != null)
            {
                this.imageBuilding.parent.removeChild(this.imageBuilding);
                this.imageBuilding = null;
            }
            this.imageBuilding = ResMgr.getInstance().getMovieClip(param1);
            if (!this.imageBuilding)
            {
                return;
            }
            this.img.addChild(this.imageBuilding);
            this.imageBuilding.x = 127 - this.imageBuilding.width / 2;
            this.imageBuilding.y = 135 - this.imageBuilding.height / 2;
            return;
        }// end function

        public function loadInfo(param1:MapObject) : void
        {
            var _loc_5:LaboratoryObject = null;
            var _loc_6:ResourceObject = null;
            var _loc_7:String = null;
            var _loc_8:DefenseObject = null;
            var _loc_9:StorageObject = null;
            var _loc_10:String = null;
            var _loc_11:ArmyCampObject = null;
            var _loc_12:ClanObject = null;
            var _loc_13:WallObject = null;
            var _loc_14:BuilderObject = null;
            var _loc_15:SpellFactoryObject = null;
            var _loc_16:BarrackObject = null;
            var _loc_17:TownHallObject = null;
            if (!param1)
            {
                return;
            }
            this.removeAllItem();
            var _loc_2:* = Utility.getContentImage(param1.type, param1.level, false);
            this.loadImageBuilding(_loc_2);
            var _loc_3:* = Localization.getInstance().getString(param1.type);
            var _loc_4:* = Utility.getTypeObject(param1.type);
            if (Utility.getTypeObject(param1.type) != BuildingType.BH && _loc_4 != BuildingType.OBS && _loc_4 != BuildingType.TRA)
            {
                _loc_3 = _loc_3 + (" cấp " + param1.level);
            }
            this.labelBuildingName.text = _loc_3.toUpperCase();
            this.labelInformation.text = Localization.getInstance().getString("Information_" + param1.type);
            while (this.labelInformation.text.search("@Name") >= 0)
            {
                
                this.labelInformation.text = this.labelInformation.text.replace("@Name", Localization.getInstance().getString(param1.type));
            }
            this.guiTroopInside.bgImg.visible = false;
            switch(_loc_4)
            {
                case BuildingType.BAR:
                {
                    _loc_16 = param1 as BarrackObject;
                    this.setBarrackCurrentIndexes(_loc_16);
                    break;
                }
                case BuildingType.TOW:
                {
                    _loc_17 = param1 as TownHallObject;
                    this.setTownHallCurrentIndexes(_loc_17);
                    break;
                }
                case BuildingType.LAB:
                {
                    _loc_5 = param1 as LaboratoryObject;
                    this.setLaboratoryCurrentIndex(_loc_5);
                    break;
                }
                case BuildingType.RES:
                {
                    _loc_6 = param1 as ResourceObject;
                    _loc_7 = Localization.getInstance().getString(_loc_6.type + "_MONEY");
                    this.setResourcesCurrentIndex(_loc_7, _loc_6);
                    break;
                }
                case BuildingType.DEF:
                {
                    _loc_8 = param1 as DefenseObject;
                    this.setDefenseCurrentIndex(_loc_8);
                    break;
                }
                case BuildingType.STO:
                {
                    _loc_9 = param1 as StorageObject;
                    _loc_10 = Localization.getInstance().getString(_loc_9.type + "_MONEY");
                    this.setStorageCurrentIndex(_loc_9, _loc_10);
                    break;
                }
                case BuildingType.AMC:
                {
                    _loc_11 = param1 as ArmyCampObject;
                    this.setArmyCampCurrentIndex(_loc_11);
                    break;
                }
                case BuildingType.CAT:
                {
                    _loc_12 = param1 as ClanObject;
                    this.setClanCastleCurrentIndex(_loc_12);
                    break;
                }
                case BuildingType.WAL:
                {
                    _loc_13 = param1 as WallObject;
                    this.setWallCurrentIndex(_loc_13);
                    break;
                }
                case BuildingType.BH:
                {
                    _loc_14 = param1 as BuilderObject;
                    this.setBuilderHutIndex(_loc_14);
                    break;
                }
                case BuildingType.TRA:
                {
                    this.setTrapInfo(param1);
                    break;
                }
                case BuildingType.SPF:
                {
                    _loc_15 = param1 as SpellFactoryObject;
                    this.setSpellFactoryInfo(_loc_15);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.curBuilding = param1;
            return;
        }// end function

        private function setSpellFactoryInfo(param1:SpellFactoryObject) : void
        {
            var _loc_2:int = 0;
            this.guiTroopInside.labelTitleInside.text = "Bình phép thuật: " + _loc_2 + "/" + param1.info.capacity;
            _loc_2 = GameDataMgr.getInstance().spellList.length;
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_SPELL_CAPACITY, _loc_2, param1.info.capacity, 0);
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_HITPOINTS, param1.info.hitpoints, 0, 1);
            this.guiTroopInside.loadSpellInside(GameDataMgr.getInstance().spellList);
            this.guiTroopInside.bgImg.visible = true;
            return;
        }// end function

        private function setTrapInfo(param1:MapObject) : void
        {
            this.removeAllItem();
            this.labelTarget.visible = true;
            this.labelTextTarget.visible = true;
            var _loc_2:* = param1.type == BuildingType.TRA_4 ? ("AttackArea_2") : ("AttackArea_1");
            this.labelTarget.text = "  - " + Localization.getInstance().getString(_loc_2);
            return;
        }// end function

        private function setBuilderHutIndex(param1:BuilderObject) : void
        {
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_HITPOINTS, param1.info.hitpoints, 0, 0);
            return;
        }// end function

        private function removeAllItem() : void
        {
            this.guiTroopInside.bgImg.visible = false;
            this.labelTextWait.visible = false;
            this.labelTimeWait.visible = false;
            this.labelTextSafe.visible = false;
            this.labelTimeSafe.visible = false;
            this.labelTextTarget.visible = false;
            this.labelTarget.visible = false;
            var _loc_1:int = 0;
            while (_loc_1 < this.listItem.length)
            {
                
                removeGui(this.listItem[_loc_1]);
                this.listItem[_loc_1].destroyBaseGUI();
                this.listItem[_loc_1] = null;
                _loc_1++;
            }
            this.listItem.splice(0, this.listItem.length);
            this.listItem = new Vector.<GuiUpgradeBuildingItem>;
            return;
        }// end function

        private function addIndexItem(param1:String, param2:int, param3:int, param4:int, param5:Boolean = false) : void
        {
            var _loc_6:* = new GuiUpgradeBuildingItem();
            _loc_6.loadInfoItem(param1, param2, param3, param5);
            addGui(_loc_6);
            _loc_6.setPos(startIconX, startIconY + param4 * (_loc_6.heightBg + 5));
            this.listItem.push(_loc_6);
            return;
        }// end function

        private function setBarrackCurrentIndexes(param1:BarrackObject) : void
        {
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_HITPOINTS, param1.info.hitpoints, 0, 0);
            return;
        }// end function

        private function setTownHallCurrentIndexes(param1:TownHallObject) : void
        {
            var _loc_2:* = GameDataMgr.getInstance().townHall;
            GameDataMgr.getInstance().splitResources(BuildingType.GOLD_STORAGE);
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_GOLD_CAPACITY, _loc_2.curResource, param1.info.capacity, 0);
            GameDataMgr.getInstance().splitResources(BuildingType.ELIXIR_STORAGE);
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_ELIXIR_CAPACITY, _loc_2.curResource, param1.info.capacity, 1);
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_HITPOINTS, param1.info.hitpoints, 0, 2);
            return;
        }// end function

        private function setLaboratoryCurrentIndex(param1:LaboratoryObject) : void
        {
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_HITPOINTS, param1.info.hitpoints, 0, 0);
            return;
        }// end function

        private function setResourcesCurrentIndex(param1:String, param2:ResourceObject) : void
        {
            this.addIndexItem(param1 + "_Capacity_Icon", param2.info.capacity, 0, 0);
            this.addIndexItem(param1 + "_ProductionRate_Icon", param2.info.productivity, 0, 1);
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_HITPOINTS, param2.info.hitpoints, 0, 2);
            return;
        }// end function

        private function setDefenseCurrentIndex(param1:DefenseObject) : void
        {
            var _loc_2:* = JsonMgr.getInstance().getMaxConfigDefense(param1.type);
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_DAMAGE, param1.info.damagePerSecond, _loc_2.damagePerSecond, 0, true);
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_HITPOINTS, param1.info.hitpoints, 0, 1);
            return;
        }// end function

        private function setStorageCurrentIndex(param1:StorageObject, param2:String) : void
        {
            GameDataMgr.getInstance().splitResources(param1.type);
            this.addIndexItem(param2 + "_Capacity_Icon", param1.curResource, param1.info.capacity, 0);
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_HITPOINTS, param1.info.hitpoints, 0, 1);
            return;
        }// end function

        private function setArmyCampCurrentIndex(param1:ArmyCampObject) : void
        {
            var _loc_2:* = GameDataMgr.getInstance().getCurrentHousingSpace();
            var _loc_3:* = GameDataMgr.getInstance().getTotalTroopCapacity();
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_TROOP_CAPACITY, _loc_2, _loc_3, 0);
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_HITPOINTS, param1.info.hitpoints, 0, 1);
            this.guiTroopInside.loadTroopInside(GameDataMgr.getInstance().troopList);
            this.guiTroopInside.bgImg.visible = true;
            return;
        }// end function

        private function setClanCastleCurrentIndex(param1:ClanObject) : void
        {
            this.guiTroopInside.loadTroopInside(GameDataMgr.getInstance().clanCastle.troopList);
            this.guiTroopInside.bgImg.visible = true;
            var _loc_2:* = JsonMgr.getInstance().getMaxConfigClanCastle();
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_TROOP_CAPACITY, GameDataMgr.getInstance().getTroopHousingSpaceOfClan(), param1.info.troopCapacity, 0);
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_HITPOINTS, param1.info.hitpoints, 0, 1);
            return;
        }// end function

        private function setWallCurrentIndex(param1:WallObject) : void
        {
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_HITPOINTS, param1.info.hitpoints, 0, 0);
            return;
        }// end function

        public function updateResourceItem(param1:int, param2:int) : void
        {
            this.listItem[0].updateIndex(param1, param2);
            return;
        }// end function

        public function showInfoTroops() : void
        {
            this.curBuilding = null;
            this.removeAllItem();
            var _loc_1:* = Utility.getContentImage(BuildingType.ARMY_CAMP, 1, false);
            this.loadImageBuilding(_loc_1);
            var _loc_2:* = Localization.getInstance().getString(BuildingType.ARMY_CAMP);
            this.labelBuildingName.text = _loc_2.toUpperCase();
            this.labelInformation.text = Localization.getInstance().getString("Information_" + BuildingType.ARMY_CAMP);
            while (this.labelInformation.text.search("@Name") >= 0)
            {
                
                this.labelInformation.text = this.labelInformation.text.replace("@Name", Localization.getInstance().getString(BuildingType.ARMY_CAMP));
            }
            var _loc_3:* = GameDataMgr.getInstance().getCurrentHousingSpace();
            var _loc_4:* = GameDataMgr.getInstance().getTotalTroopCapacity();
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_TROOP_CAPACITY, _loc_3, _loc_4, 0);
            this.guiTroopInside.loadTroopInside(GameDataMgr.getInstance().troopList);
            this.guiTroopInside.bgImg.visible = true;
            show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
            return;
        }// end function

        public function showInfoShield(param1:int) : void
        {
            this.curBuilding = null;
            this.removeAllItem();
            this.labelTextWait.visible = true;
            this.labelTimeWait.visible = true;
            this.labelTextSafe.visible = true;
            this.labelTimeSafe.visible = true;
            this.loadImageBuilding("Shield" + "_" + param1 + "_Icon");
            this.imageBuilding.x = this.imageBuilding.x + 15;
            var _loc_2:* = JsonMgr.getInstance().getShieldData(param1);
            this.labelTimeSafe.text = _loc_2.days + " NGÀY";
            var _loc_3:* = Localization.getInstance().getString("ShieldName");
            _loc_3 = _loc_3.replace("@number", _loc_2.days.toString());
            this.labelBuildingName.text = _loc_3.toUpperCase();
            this.labelTimeWait.text = _loc_2.cdown + " NGÀY";
            this.labelInformation.text = Localization.getInstance().getString("Information_Shield");
            show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
            return;
        }// end function

    }
}
