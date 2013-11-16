package modules.city.graphics.laboratory
{
    import __AS3__.vec.*;
    import component.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import modules.city.*;
    import modules.city.logic.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class GuiLaboratory extends BaseGui
    {
        private var listItem:Vector.<GuiLaboratotyItem>;
        public var labelLaboratory:TextField;
        private static const MAX_TROOP:int = 10;
        private static const BMP_CLOSE:String = "bmpClose";
        private static var startX:Number = 70;
        private static var startY:Number = 170;
        private static var padingX:Number = 9;
        private static var padingY:Number = 11;

        public function GuiLaboratory()
        {
            this.listItem = new Vector.<GuiLaboratotyItem>;
            super(ResMgr.getInstance().getMovieClip("LaboratoryGui"));
            autoAlign = AUTO_ALIGN_CENTER;
            enableDisableScreen = true;
            enableClickOutToClose = true;
            this.init();
            return;
        }// end function

        private function loadTroopResearch() : void
        {
            var _loc_5:String = null;
            var _loc_6:int = 0;
            var _loc_7:TroopInfo = null;
            var _loc_8:int = 0;
            var _loc_9:TroopInfo = null;
            var _loc_1:* = JsonMgr.getInstance().troopBase;
            var _loc_2:* = Utility.getCurrentMaxBarrackLevel();
            var _loc_3:* = GameDataMgr.getInstance().laboratory;
            var _loc_4:int = 0;
            while (_loc_4 < MAX_TROOP)
            {
                
                _loc_5 = "ARM_" + (_loc_4 + 1);
                this.listItem[_loc_4].loadItem(_loc_5);
                if (_loc_4 >= 8)
                {
                    this.listItem[_loc_4].disableItem(GuiLaboratotyItem.REASON_COMING_SOON);
                }
                else
                {
                    _loc_6 = _loc_1[_loc_5]["barracksLevelRequired"];
                    if (_loc_2 < _loc_6)
                    {
                        this.listItem[_loc_4].disableItem(GuiLaboratotyItem.REASON_BARRACK_LEVEL_REQUIRED, _loc_6);
                    }
                    else
                    {
                        _loc_7 = JsonMgr.getInstance().getMaxConfigInfoTroop(_loc_5);
                        _loc_8 = GameDataMgr.getInstance().getTroopLevel(_loc_5);
                        if (_loc_8 == _loc_7.level)
                        {
                            this.listItem[_loc_4].disableItem(GuiLaboratotyItem.REASON_MAX_LEVEL);
                        }
                        else
                        {
                            _loc_9 = JsonMgr.getInstance().getInfoTroop(_loc_5, (_loc_8 + 1));
                            if (_loc_9.laboratoryLevelRequired > GameDataMgr.getInstance().laboratory.level)
                            {
                                this.listItem[_loc_4].disableItem(GuiLaboratotyItem.REASON_LABORATORY_LEVEL_REQUIRED, _loc_9.laboratoryLevelRequired);
                            }
                        }
                    }
                }
                _loc_4++;
            }
            return;
        }// end function

        private function init() : void
        {
            var _loc_2:GuiLaboratotyItem = null;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_1:int = 0;
            while (_loc_1 < MAX_TROOP)
            {
                
                _loc_2 = new GuiLaboratotyItem();
                _loc_3 = startX + (_loc_2.widthBg + padingX) * (_loc_1 % 5);
                _loc_4 = startY + (_loc_2.heightBg + padingY) * this.int(_loc_1 / 5);
                _loc_2.setPos(_loc_3, _loc_4);
                _loc_2.disableItem();
                addGui(_loc_2);
                this.listItem.push(_loc_2);
                _loc_1++;
            }
            return;
        }// end function

        public function loadInfo() : void
        {
            var _loc_1:* = Localization.getInstance().getString(BuildingType.LABORATORY) + " CẤP " + GameDataMgr.getInstance().laboratory.level;
            this.labelLaboratory.text = _loc_1.toUpperCase();
            var _loc_2:* = Utility.getCurrentMaxBarrackLevel();
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                this.listItem[_loc_3].enableItem();
                _loc_3++;
            }
            this.loadTroopResearch();
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_CLOSE:
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

        override public function hide(param1:Boolean = false) : void
        {
            var _loc_2:LaboratoryObject = null;
            super.hide(param1);
            if (param1)
            {
                _loc_2 = GameDataMgr.getInstance().laboratory;
                CityMgr.getInstance().showBuildingActionGui(_loc_2);
            }
            return;
        }// end function

    }
}
