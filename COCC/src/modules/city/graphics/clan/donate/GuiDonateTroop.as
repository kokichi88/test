package modules.city.graphics.clan.donate
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import gameData.donation.*;
    import modules.battle.data.*;
    import modules.city.*;
    import resMgr.*;
    import utility.*;

    public class GuiDonateTroop extends BaseGui
    {
        public var labelTroop:TextField;
        private var listItem:Vector.<GuiDonateTroopItem>;
        public var maxItem:int = 12;
        public var requestInfo:TroopRequestInfo;
        public var friendId:int;
        private var totalDonation:int;
        public static var BMP_CLOSE:String = "bmpClose";
        public static var padingX:Number = 16.95;
        public static var padingY:Number = 17.9;
        public static var startX:Number = 67;
        public static var startY:Number = 94;
        public static var itemPerLine:int = 6;

        public function GuiDonateTroop()
        {
            this.listItem = new Vector.<GuiDonateTroopItem>;
            super(ResMgr.getInstance().getMovieClip("DonateTroopGui"));
            autoAlign = AUTO_ALIGN_CENTER;
            this.initTroopItem();
            enableDisableScreen = true;
            enableClickOutToClose = true;
            return;
        }// end function

        private function initTroopItem() : void
        {
            var _loc_2:GuiDonateTroopItem = null;
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_1:int = 0;
            while (_loc_1 < this.maxItem)
            {
                
                _loc_2 = new GuiDonateTroopItem();
                _loc_3 = startX + _loc_1 % itemPerLine * (_loc_2.widthBg + padingX);
                _loc_4 = startY + int(_loc_1 / itemPerLine) * (_loc_2.heightBg + padingY);
                _loc_2.index = _loc_1;
                _loc_2.setPos(_loc_3, _loc_4);
                _loc_2.setTroop("ARM_" + (_loc_1 + 1));
                addGui(_loc_2);
                this.listItem.push(_loc_2);
                _loc_1++;
            }
            return;
        }// end function

        private function disableAllItem() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.listItem.length)
            {
                
                this.listItem[_loc_1].setEnable(false);
                _loc_1++;
            }
            return;
        }// end function

        public function getTroops() : void
        {
            var _loc_3:Troop = null;
            var _loc_4:int = 0;
            this.disableAllItem();
            var _loc_1:* = GameDataMgr.getInstance().troopList;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                _loc_3 = _loc_1[_loc_2];
                _loc_4 = Utility.getTroopIndex(_loc_3.type) - 1;
                this.listItem[_loc_4].setEnable(true);
                this.listItem[_loc_4].setTroopLeft(_loc_3.num);
                this.listItem[_loc_4].setDonationNumber(0);
                _loc_2++;
            }
            return;
        }// end function

        public function setRequestTroopInfo(param1:int, param2:TroopRequestInfo) : void
        {
            var _loc_4:Troop = null;
            var _loc_5:int = 0;
            this.friendId = param1;
            this.getTroops();
            this.requestInfo = param2;
            this.totalDonation = 0;
            var _loc_3:int = 0;
            while (_loc_3 < param2.myDonation.length)
            {
                
                _loc_4 = param2.myDonation[_loc_3];
                _loc_5 = Utility.getTroopIndex(_loc_4.type) - 1;
                this.totalDonation = this.totalDonation + _loc_4.num;
                this.listItem[_loc_5].setDonationNumber(_loc_4.num);
                _loc_3++;
            }
            this.labelTroop.text = this.totalDonation + "/" + GlobalVar.CLAN_MAX_DONATION;
            this.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_CLOSE:
                {
                    hide(true);
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function onItemClick(param1:int) : void
        {
            var _loc_2:int = 0;
            if (this.totalDonation < GlobalVar.CLAN_MAX_DONATION && this.listItem[param1].troopLeft > 0 && this.requestInfo.curCapacity < this.requestInfo.maxCapacity)
            {
                _loc_2 = Utility.getHousingSpace("ARM_" + (param1 + 1));
                if (this.requestInfo.curCapacity + _loc_2 <= this.requestInfo.maxCapacity)
                {
                    CityMgr.getInstance().sendDonateTroopCmd(this.friendId, "ARM_" + (param1 + 1));
                }
            }
            return;
        }// end function

        public function donateSuccess(param1:Troop) : void
        {
            var _loc_2:* = param1.type.split("_");
            var _loc_3:* = _loc_2[1] - 1;
            this.listItem[_loc_3].troopDonate = this.listItem[_loc_3].troopDonate + param1.num;
            this.listItem[_loc_3].setDonationNumber(this.listItem[_loc_3].troopDonate);
            this.listItem[_loc_3].troopLeft = this.listItem[_loc_3].troopLeft - param1.num;
            this.listItem[_loc_3].setTroopLeft(this.listItem[_loc_3].troopLeft);
            this.totalDonation = this.totalDonation + param1.num;
            this.labelTroop.text = this.totalDonation + "/" + GlobalVar.CLAN_MAX_DONATION;
            var _loc_4:* = new Troop();
            new Troop().type = param1.type;
            _loc_4.num = -param1.num;
            _loc_4.level = param1.level;
            Utility.addTroop(_loc_4, GameDataMgr.getInstance().troopList);
            CityMgr.getInstance().guiMainTop.updateTotalTroop();
            if (this.totalDonation == GlobalVar.CLAN_MAX_DONATION)
            {
                hide();
            }
            CityMgr.getInstance().cityTroopGoAway(param1.type);
            return;
        }// end function

        private function updateState() : void
        {
            var _loc_1:* = Utility.getCurrentMaxBarrackLevel();
            var _loc_2:int = 0;
            while (_loc_2 < this.maxItem)
            {
                
                if ((_loc_2 + 1) > _loc_1)
                {
                    this.listItem[_loc_2].imageBgTroopLevelDonateItem.visible = false;
                    this.listItem[_loc_2].labelNumber.visible = false;
                    this.listItem[_loc_2].labelTroopDonate.visible = false;
                }
                else
                {
                    this.listItem[_loc_2].imageBgTroopLevelDonateItem.visible = true;
                    this.listItem[_loc_2].labelNumber.visible = true;
                    this.listItem[_loc_2].labelTroopDonate.visible = true;
                    this.listItem[_loc_2].updateStarLevel();
                }
                _loc_2++;
            }
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            this.updateState();
            super.show(param1, param2);
            return;
        }// end function

    }
}
