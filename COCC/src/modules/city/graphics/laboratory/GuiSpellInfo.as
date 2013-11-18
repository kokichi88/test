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

    public class GuiSpellInfo extends BaseGui
    {
        public var labelMoneyNeed:TextField;
        public var labelUpgradeLevel:TextField;
        public var labelEffectType:TextField;
        public var labelEffect:TextField;
        public var labelTarget:TextField;
        public var labelTimeToCreate:TextField;
        public var labelTimeUpgrade:TextField;
        public var labelBuildTime:TextField;
        public var labelDescription:TextField;
        public var imageElixir:MovieClip;
        public var bmpUpgradeTroop:BitmapButton;
        private var moneyNeed:int;
        private var troopType:String;
        private var troopLevel:int;
        private var imageSpell:Sprite = null;
        private var isShowInfo:Boolean = false;
        private var listItem:Vector.<GuiUpgradeBuildingItem>;
        private static const BMP_CLOSE:String = "bmpClose";
        private static const BMP_RESEARCH:String = "bmpUpgradeTroop";

        public function GuiSpellInfo()
        {
            this.listItem = new Vector.<GuiUpgradeBuildingItem>;
            super(ResMgr.getInstance().getMovieClip("GuiSpellInfo") as MovieClip);
            autoAlign = AUTO_ALIGN_CENTER;
            enableDisableScreen = true;
            enableClickOutToClose = true;
            this.labelMoneyNeed.mouseEnabled = false;
            return;
        }// end function

        private function addIndexItem(param1:String, param2:int, param3:int, param4:int, param5:int) : void
        {
            var _loc_6:* = new GuiUpgradeBuildingItem();
            _loc_6.loadUpgradeItem(param1, param4, param2, param3);
            addGui(_loc_6);
            _loc_6.setPos(226, 60 + param5 * _loc_6.heightBg);
            this.listItem.push(_loc_6);
            return;
        }// end function

        private function addInfoIndexItem(param1:String, param2:int, param3:int, param4:int, param5:Boolean = false) : void
        {
            var _loc_6:* = new GuiUpgradeBuildingItem();
            _loc_6.loadInfoItem(param1, param2, param3, param5);
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

        private function loadImageSpell(param1:String, param2:int) : void
        {
            if (this.imageSpell && this.imageSpell.parent != null)
            {
                this.imageSpell.parent.removeChild(this.imageSpell);
                this.imageSpell = null;
            }
            var _loc_3:* = Utility.getContentImage(param1, param2);
            this.imageSpell = ResMgr.getInstance().getMovieClip(_loc_3);
            this.img.addChild(this.imageSpell);
            this.imageSpell.x = 128 - this.imageSpell.width / 2;
            this.imageSpell.y = 210 - this.imageSpell.height;
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

        private function loadConfigSpell(param1:String, param2:int) : void
        {
            var _loc_3:* = JsonMgr.getInstance().getDataSpell(param1, param2);
            this.labelEffectType.text = Localization.getInstance().getString("EffectType_" + param1);
            this.labelEffect.text = Localization.getInstance().getString("AttackRadius_" + (_loc_3.radius == 0 ? (0) : (1)));
            this.labelTarget.text = Localization.getInstance().getString("AttackArea_3");
            this.labelTimeToCreate.text = Utility.convertTimeToShortString(_loc_3.timeToCreate);
            return;
        }// end function

        public function showInfo(param1:String, param2:int) : void
        {
            this.isShowInfo = true;
            this.hideUpgradeInfo();
            this.removeAllItem();
            var _loc_3:* = Localization.getInstance().getString(param1) + " cấp " + param2;
            this.labelUpgradeLevel.text = _loc_3.toUpperCase();
            this.loadImageSpell(param1, param2);
            var _loc_4:* = Localization.getInstance().getString("Information_" + param1);
            _loc_4 = Localization.getInstance().getString("Information_" + param1).replace("@Name", Localization.getInstance().getString(param1));
            this.labelDescription.text = _loc_4;
            var _loc_5:* = JsonMgr.getInstance().getDataSpell(param1, param2);
            var _loc_6:* = JsonMgr.getInstance().getMaxConfigInfoSpell(param1);
            switch(param1)
            {
                case "SPE_1":
                {
                    this.addInfoIndexItem(GuiUpgradeBuildingItem.ICON_DAMAGE, _loc_5.totalDamage, _loc_6.totalDamage, 0, true);
                    this.addInfoIndexItem(GuiUpgradeBuildingItem.ICON_TRANING_COST, _loc_5.goldCost, _loc_6.goldCost, 1, true);
                    break;
                }
                case "SPE_2":
                {
                    this.addInfoIndexItem(GuiUpgradeBuildingItem.ICON_HEAL, _loc_5.totalDamage, _loc_6.totalDamage, 0, true);
                    this.addInfoIndexItem(GuiUpgradeBuildingItem.ICON_TRANING_COST, _loc_5.goldCost, _loc_6.goldCost, 1, true);
                    break;
                }
                case "SPE_3":
                {
                    this.addInfoIndexItem(GuiUpgradeBuildingItem.ICON_DAMAGE, _loc_5.damgeBoost, _loc_6.damgeBoost, 0, true);
                    this.addInfoIndexItem(GuiUpgradeBuildingItem.ICON_SPELL_CAPACITY, _loc_5.speedBoost, _loc_6.speedBoost, 1, true);
                    this.addInfoIndexItem(GuiUpgradeBuildingItem.ICON_TRANING_COST, _loc_5.goldCost, _loc_6.goldCost, 2, true);
                    break;
                }
                case "SPE_4":
                {
                    break;
                }
                case "SPE_5":
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.loadConfigSpell(param1, 1);
            show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
            return;
        }// end function

        public function loadUpgradeInfo(param1:String, param2:int) : void
        {
            this.isShowInfo = false;
            this.removeAllItem();
            this.showUpgradeInfo();
            this.loadImageSpell(param1, param2);
            this.labelUpgradeLevel.text = Localization.getInstance().getString("Upgrade0") + " " + (param2 + 1);
            var _loc_3:* = JsonMgr.getInstance().getDataSpell(param1, param2);
            var _loc_4:* = JsonMgr.getInstance().getDataSpell(param1, (param2 + 1));
            var _loc_5:* = JsonMgr.getInstance().getMaxConfigInfoSpell(param1);
            switch(param1)
            {
                case "SPE_1":
                {
                    this.addIndexItem(GuiUpgradeBuildingItem.ICON_DAMAGE, _loc_3.totalDamage, _loc_4.totalDamage, _loc_5.totalDamage, 0);
                    this.addIndexItem(GuiUpgradeBuildingItem.ICON_TRANING_COST, _loc_3.goldCost, _loc_4.goldCost, _loc_5.goldCost, 1);
                    break;
                }
                case "SPE_2":
                {
                    this.addIndexItem(GuiUpgradeBuildingItem.ICON_HEAL, _loc_3.totalDamage, _loc_4.totalDamage, _loc_5.totalDamage, 0);
                    this.addIndexItem(GuiUpgradeBuildingItem.ICON_TRANING_COST, _loc_3.goldCost, _loc_4.goldCost, _loc_5.goldCost, 1);
                    break;
                }
                case "SPE_3":
                {
                    this.addIndexItem(GuiUpgradeBuildingItem.ICON_DAMAGE, _loc_3.damgeBoost, _loc_4.damgeBoost, _loc_5.damgeBoost, 0);
                    this.addIndexItem(GuiUpgradeBuildingItem.ICON_SPELL_CAPACITY, _loc_3.speedBoost, _loc_4.speedBoost, _loc_5.speedBoost, 1);
                    this.addIndexItem(GuiUpgradeBuildingItem.ICON_TRANING_COST, _loc_3.goldCost, _loc_4.goldCost, _loc_5.goldCost, 2);
                    break;
                }
                case "SPE_4":
                {
                    break;
                }
                case "SPE_5":
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.moneyNeed = _loc_4.elixirUpgradeCost;
            this.troopType = param1;
            this.troopLevel = param2;
            this.labelMoneyNeed.text = Utility.standardNumber(_loc_4.elixirUpgradeCost);
            this.labelBuildTime.text = Utility.convertTimeToString(_loc_4.upgradeTime, true, true, true, true);
            var _loc_6:* = GameDataMgr.getInstance().getMoney(MoneyType.ELIXIR);
            this.labelMoneyNeed.textColor = _loc_6 >= this.moneyNeed ? (16776906) : (16728128);
            this.loadConfigSpell(param1, 1);
            show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
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
