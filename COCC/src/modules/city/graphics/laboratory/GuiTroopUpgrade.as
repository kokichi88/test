package modules.city.graphics.laboratory
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import modules.*;
    import modules.city.*;
    import modules.city.graphics.build.*;
    import modules.city.logic.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class GuiTroopUpgrade extends BaseGui
    {
        public var labelMoneyNeed:TextField;
        public var labelUpgradeLevel:TextField;
        public var labelBuildTime:TextField;
        public var labelFavorite:TextField;
        public var labelDamageType:TextField;
        public var labelTarget:TextField;
        public var labelHousingSpace:TextField;
        public var labelTrainingTime:TextField;
        public var labelMovementSpeed:TextField;
        public var labelTimeUpgrade:TextField;
        public var labelDescription:TextField;
        public var imageElixir:MovieClip;
        public var bmpUpgradeTroop:BitmapButton;
        private var moneyNeed:int;
        private var troopType:String;
        private var troopLevel:int;
        private var imageTroop:Sprite = null;
        private var isShowInfo:Boolean = false;
        private var listItem:Vector.<GuiUpgradeBuildingItem>;
        private static const BMP_CLOSE:String = "bmpClose";
        private static const BMP_RESEARCH:String = "bmpUpgradeTroop";

        public function GuiTroopUpgrade()
        {
            this.listItem = new Vector.<GuiUpgradeBuildingItem>;
            super(ResMgr.getInstance().getMovieClip("TroopUpgradeGui") as MovieClip);
            autoAlign = AUTO_ALIGN_CENTER;
            enableDisableScreen = true;
            enableClickOutToClose = true;
            this.labelMoneyNeed.mouseEnabled = false;
            return;
        }// end function

        private function addIndexItem(param1:String, param2:int, param3:int, param4:int, param5:int) : void
        {
            var _loc_6:* = new GuiUpgradeBuildingItem();
            new GuiUpgradeBuildingItem().loadUpgradeItem(param1, param4, param2, param3);
            addGui(_loc_6);
            _loc_6.setPos(226, 60 + param5 * _loc_6.heightBg);
            this.listItem.push(_loc_6);
            return;
        }// end function

        private function addInfoIndexItem(param1:String, param2:int, param3:int, param4:int, param5:Boolean = false) : void
        {
            var _loc_6:* = new GuiUpgradeBuildingItem();
            new GuiUpgradeBuildingItem().loadInfoItem(param1, param2, param3, param5);
            addGui(_loc_6);
            _loc_6.setPos(226, 60 + param4 * _loc_6.heightBg);
            this.listItem.push(_loc_6);
            return;
        }// end function

        private function removeAllItem() : void
        {
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

        private function loadImageTroop(param1:String, param2:int) : void
        {
            if (this.imageTroop && this.imageTroop.parent != null)
            {
                this.imageTroop.parent.removeChild(this.imageTroop);
                this.imageTroop = null;
            }
            var _loc_3:* = Utility.getContentImage(param1, param2);
            this.imageTroop = ResMgr.getInstance().getMovieClip(_loc_3);
            this.img.addChild(this.imageTroop);
            if (param1 == "ARM_1" || param1 == "ARM_4")
            {
                this.imageTroop.x = 215 - this.imageTroop.width;
                this.imageTroop.y = 260 - this.imageTroop.height;
            }
            else if (param1 == "ARM_6" || param1 == "ARM_8")
            {
                this.imageTroop.x = 128 - this.imageTroop.width / 2;
                this.imageTroop.y = 165 - this.imageTroop.height / 2;
            }
            else
            {
                this.imageTroop.x = 128 - this.imageTroop.width / 2;
                this.imageTroop.y = 260 - this.imageTroop.height;
            }
            return;
        }// end function

        private function hideUpgradeInfo() : void
        {
            this.labelBuildTime.visible = false;
            this.labelTimeUpgrade.visible = false;
            this.imageElixir.visible = false;
            this.bmpUpgradeTroop.visible = false;
            this.labelMoneyNeed.visible = false;
            this.labelDescription.visible = true;
            return;
        }// end function

        private function showUpgradeInfo() : void
        {
            this.labelBuildTime.visible = true;
            this.labelTimeUpgrade.visible = true;
            this.imageElixir.visible = true;
            this.bmpUpgradeTroop.visible = true;
            this.labelMoneyNeed.visible = true;
            this.labelDescription.visible = false;
            return;
        }// end function

        private function loadConfigTroop(param1:String, param2:int) : void
        {
            var _loc_3:* = JsonMgr.getInstance().getInfoTroop(param1, param2);
            this.labelFavorite.text = Localization.getInstance().getString("Favorite_" + _loc_3.favoriteTarget);
            this.labelDamageType.text = Localization.getInstance().getString("AttackRadius_" + (_loc_3.attackRadius == 0 ? (0) : (1)));
            this.labelTarget.text = Localization.getInstance().getString("AttackArea_" + _loc_3.attackArea);
            this.labelHousingSpace.text = _loc_3.housingSpace.toString();
            this.labelTrainingTime.text = Utility.convertTimeToShortString(_loc_3.trainingTime);
            this.labelMovementSpeed.text = _loc_3.moveSpeed.toString();
            return;
        }// end function

        public function loadInfo(param1:String, param2:int) : void
        {
            this.isShowInfo = true;
            this.hideUpgradeInfo();
            this.removeAllItem();
            var _loc_3:* = Localization.getInstance().getString(param1) + " cấp " + param2;
            this.labelUpgradeLevel.text = _loc_3.toUpperCase();
            this.loadImageTroop(param1, param2);
            var _loc_4:* = Localization.getInstance().getString("Information_" + param1);
            _loc_4 = Localization.getInstance().getString("Information_" + param1).replace("@Name", Localization.getInstance().getString(param1));
            this.labelDescription.text = _loc_4;
            var _loc_5:* = JsonMgr.getInstance().getInfoTroop(param1, param2);
            var _loc_6:* = JsonMgr.getInstance().getMaxConfigInfoTroop(param1);
            if (param1 == "ARM_8")
            {
                this.addInfoIndexItem(GuiUpgradeBuildingItem.ICON_HEAL, _loc_5.healsPerSecond, _loc_6.healsPerSecond, 0, true);
            }
            else
            {
                this.addInfoIndexItem(GuiUpgradeBuildingItem.ICON_DAMAGE, _loc_5.damagePerSecond, _loc_6.damagePerSecond, 0, true);
            }
            this.addInfoIndexItem(GuiUpgradeBuildingItem.ICON_HITPOINTS, _loc_5.hitpoints, _loc_6.hitpoints, 1, true);
            this.addInfoIndexItem(GuiUpgradeBuildingItem.ICON_TRANING_COST, _loc_5.trainingCost, _loc_6.trainingCost, 2, true);
            this.loadConfigTroop(param1, 1);
            return;
        }// end function

        public function loadUpgradeInfo(param1:String, param2:int) : void
        {
            this.isShowInfo = false;
            this.removeAllItem();
            this.showUpgradeInfo();
            this.loadImageTroop(param1, param2);
            this.labelUpgradeLevel.text = Localization.getInstance().getString("Upgrade0") + " " + (param2 + 1);
            var _loc_3:* = JsonMgr.getInstance().getInfoTroop(param1, param2);
            var _loc_4:* = JsonMgr.getInstance().getInfoTroop(param1, (param2 + 1));
            var _loc_5:* = JsonMgr.getInstance().getMaxConfigInfoTroop(param1);
            if (param1 == "ARM_8")
            {
                this.addIndexItem(GuiUpgradeBuildingItem.ICON_HEAL, _loc_3.healsPerSecond, _loc_4.healsPerSecond, _loc_5.healsPerSecond, 0);
            }
            else
            {
                this.addIndexItem(GuiUpgradeBuildingItem.ICON_DAMAGE, _loc_3.damagePerSecond, _loc_4.damagePerSecond, _loc_5.damagePerSecond, 0);
            }
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_HITPOINTS, _loc_3.hitpoints, _loc_4.hitpoints, _loc_5.hitpoints, 1);
            this.addIndexItem(GuiUpgradeBuildingItem.ICON_TRANING_COST, _loc_3.trainingCost, _loc_4.trainingCost, _loc_5.trainingCost, 2);
            this.moneyNeed = _loc_4.researchCost;
            this.troopType = param1;
            this.troopLevel = param2;
            this.labelMoneyNeed.text = Utility.standardNumber(_loc_4.researchCost);
            this.labelBuildTime.text = Utility.convertTimeToString(_loc_4.researchTime, true, true, true, true);
            var _loc_6:* = GameDataMgr.getInstance().getMoney(MoneyType.ELIXIR);
            this.labelMoneyNeed.textColor = _loc_6 >= this.moneyNeed ? (16776906) : (16728128);
            this.loadConfigTroop(param1, 1);
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_CLOSE:
                {
                    this.hide(true);
                    if (!this.isShowInfo)
                    {
                        ModuleMgr.getInstance().doFunction(CityMgr.SHOW_LABORATORY_GUI);
                    }
                    break;
                }
                case BMP_RESEARCH:
                {
                    CityMgr.getInstance().prepareToResearch(this.moneyNeed, this.troopType, (this.troopLevel + 1));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            var _loc_2:LaboratoryObject = null;
            super.hide(param1);
            if (param1 && !this.isShowInfo)
            {
                _loc_2 = GameDataMgr.getInstance().laboratory;
                CityMgr.getInstance().guiBuildingAction.curObject = null;
                CityMgr.getInstance().showBuildingActionGui(_loc_2);
            }
            return;
        }// end function

    }
}
