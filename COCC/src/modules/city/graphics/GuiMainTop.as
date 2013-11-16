package modules.city.graphics
{
    import __AS3__.vec.*;
    import component.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import modules.city.*;
    import modules.city.graphics.build.*;
    import modules.city.graphics.shop.*;
	import modules.city.logic.BarrackObject;
    import resMgr.*;
    import utility.*;

    public class GuiMainTop extends BaseGui
    {
        public var labelBuilderNumber:TextField;
        public var labelShieldStatus:TextField;
        public var labelTroopNumber:TextField;
        public var isFull:Boolean = false;
        public var bmpTroop:BitmapButton;
        public var bmpAddShield:BitmapButton;
        public var bmpAddBuilder:BitmapButton;
        private var shieldTime:Number;
        private static const BMP_ACTTACK:String = "bmpActtack";
        private static const BMP_TROOPS:String = "bmpTroop";
        private static const BMP_ADD_BUILDER:String = "bmpAddBuilder";
        private static const BMP_ADD_SHIELD:String = "bmpAddShield";

        public function GuiMainTop()
        {
            super(ResMgr.getInstance().getMovieClip("MainGui_Top"));
            autoAlign = AUTO_ALIGN_TOP_CENTER;
            this.bgImg.y = 0;
            this.bmpTroop.setTooltipDisplayObj(Utility.getTooltipString(Localization.getInstance().getString("Tooltip_BmpTroop")));
            this.bmpAddBuilder.setTooltipDisplayObj(Utility.getTooltipString(Localization.getInstance().getString("Tooltip_BmpAddBuilder")));
            this.bmpAddShield.setTooltipDisplayObj(Utility.getTooltipString(Localization.getInstance().getString("Tooltip_BmpAddShield")));
            return;
        }// end function

        public function updateBuilder() : void
        {
            this.labelBuilderNumber.text = GameDataMgr.getInstance().getFreeBuilderNumer().toString() + " / " + GameDataMgr.getInstance().myInfo.builderList.length;
            return;
        }// end function

        public function updateTotalTroop() : void
        {
            var _loc_6:Vector.<BarrackObject> = null;
            var _loc_7:int = 0;
            var _loc_1:* = GameDataMgr.getInstance().getCurrentHousingSpace();
            var _loc_2:* = GameDataMgr.getInstance().getTotalTroopCapacity();
            this.labelTroopNumber.text = _loc_1 + "/" + _loc_2;
            this.isFull = _loc_1 == _loc_2;
            var _loc_3:* = this.isFull ? (GuiStatusBuilding.FULL) : (GuiStatusBuilding.NONE);
            var _loc_4:* = GameDataMgr.getInstance().armyCampList;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4.length)
            {
                
                _loc_4[_loc_5].showStatusIcon(_loc_3);
                _loc_5++;
            }
            if (!this.isFull)
            {
                _loc_6 = GameDataMgr.getInstance().barrackList;
                _loc_7 = 0;
                while (_loc_7 < _loc_6.length)
                {
                    
                    _loc_6[_loc_7].isStopped = false;
                    _loc_7++;
                }
            }
            return;
        }// end function

        public function updateShield() : void
        {
            this.shieldTime = GameDataMgr.getInstance().myInfo.shieldTime;
            return;
        }// end function

        override public function loop() : void
        {
            if (Utility.getCurTime() > this.shieldTime)
            {
                this.labelShieldStatus.text = "KHÔNG";
                return;
            }
            var _loc_1:* = this.shieldTime - Utility.getCurTime();
            this.labelShieldStatus.text = Utility.convertTimeToShortString(_loc_1);
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            CityMgr.getInstance().hideBuildingActionGui();
            switch(param1)
            {
                case BMP_TROOPS:
                {
                    CityMgr.getInstance().guiBuildingInfo.showInfoTroops();
                    break;
                }
                case BMP_ADD_BUILDER:
                {
                    CityMgr.getInstance().guiShop.curShopType = GuiShop.SHOP_RESOURCES;
                    CityMgr.getInstance().guiShop.show();
                    break;
                }
                case BMP_ADD_SHIELD:
                {
                    CityMgr.getInstance().guiShop.curShopType = GuiShop.SHOP_SHIELD;
                    CityMgr.getInstance().guiShop.show();
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
