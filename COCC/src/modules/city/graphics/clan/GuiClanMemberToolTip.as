package modules.city.graphics.clan
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.text.*;
    import gameData.*;
    import gameData.clan.*;
    import modules.city.*;
    import resMgr.*;

    public class GuiClanMemberToolTip extends BaseGui
    {
        public var uId:int;
        public var title:int;
        public var listItem:Vector.<ClanMemberToolTipAction>;
        public var currentItem:int;
        public var imageToolTip1:MovieClip;
        public var imageToolTip2:MovieClip;
        public var imageToolTip3:MovieClip;
        public var imageToolTip4:MovieClip;
        public var labelName:TextField;
        private var tooltipType:int = 0;
        private static const TOOLTIP_FOR_CLAN_MEMBER:int = 0;
        private static const TOOLTIP_FOR_PLAYER:int = 1;

        public function GuiClanMemberToolTip()
        {
            this.listItem = new Vector.<ClanMemberToolTipAction>;
            super(ResMgr.getInstance().getMovieClip("ClanMemberToolTipGui"));
            autoAlign = "";
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            super.hide(param1);
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
            this.listItem = new Vector.<ClanMemberToolTipAction>;
            return;
        }// end function

        public function loadItemToolTip(param1:ClanMemberInfo) : void
        {
            var _loc_2:int = 0;
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_5:ClanMemberToolTipAction = null;
            var _loc_6:ClanMemberToolTipAction = null;
            this.tooltipType = TOOLTIP_FOR_CLAN_MEMBER;
            this.bgImg.visible = true;
            this.removeAllItem();
            this.labelName.text = param1.name;
            if (CityMgr.getInstance().guiClan.isShowing && CityMgr.getInstance().guiClan.guiJoinClan.guiDetailClan.isMyClan)
            {
                _loc_2 = GameDataMgr.getInstance().clanCastle.title;
                _loc_3 = GlobalVar.CLAN_ACTION[_loc_2.toString()];
                _loc_4 = 0;
                while (_loc_4 < _loc_3.length)
                {
                    
                    if (_loc_2 == GlobalVar.CLAN_LEADER)
                    {
                        if (param1.clanTitle == GlobalVar.CLAN_ELDER && _loc_3[_loc_4] == GlobalVar.CLAN_ACTION_PROMOTE_TO_ELDER)
                        {
                        }
                        if (param1.clanTitle == GlobalVar.CLAN_MEMBER && _loc_3[_loc_4] == GlobalVar.CLAN_ACTION_DEMOTE_TO_MEMBER)
                        {
                        }
                    }
                    else if (_loc_2 == GlobalVar.CLAN_ELDER)
                    {
                        if (_loc_3[_loc_4] == GlobalVar.CLAN_ACTION_PROMOTE_TO_LEADER || _loc_3[_loc_4] == GlobalVar.CLAN_ACTION_DEMOTE_TO_MEMBER)
                        {
                        }
                        if (param1.clanTitle == GlobalVar.CLAN_LEADER && _loc_3[_loc_4] != GlobalVar.CLAN_ACTION_VISIT)
                        {
                        }
                        if (param1.clanTitle == GlobalVar.CLAN_ELDER && _loc_3[_loc_4] != GlobalVar.CLAN_ACTION_VISIT)
                        {
                            ;
                        }
                    }
                    _loc_5 = new ClanMemberToolTipAction();
                    _loc_5.setAction(_loc_3[_loc_4]);
                    _loc_5.setPos(21, 9 + _loc_5.heightBg * this.listItem.length);
                    addGui(_loc_5);
                    this.listItem.push(_loc_5);
                    _loc_4++;
                }
            }
            else
            {
                _loc_6 = new ClanMemberToolTipAction();
                _loc_6.setAction(GlobalVar.CLAN_ACTION_VISIT);
                addGui(_loc_6);
                this.listItem.push(_loc_6);
            }
            this.reArrangeItems();
            return;
        }// end function

        public function loadPlayerToolTip(param1:PlayerInfo) : void
        {
            this.tooltipType = TOOLTIP_FOR_PLAYER;
            this.bgImg.visible = true;
            this.removeAllItem();
            this.labelName.text = param1.cityName;
            var _loc_2:* = new ClanMemberToolTipAction();
            _loc_2.setAction(GlobalVar.CLAN_ACTION_VISIT);
            addGui(_loc_2);
            this.listItem.push(_loc_2);
            if (param1.clanId > 0)
            {
                _loc_2 = new ClanMemberToolTipAction();
                _loc_2.setAction(GlobalVar.CLAN_ACTION_VIEW);
                addGui(_loc_2);
                this.listItem.push(_loc_2);
            }
            this.reArrangeItems();
            return;
        }// end function

        public function onItemClick(param1:int) : void
        {
            switch(this.tooltipType)
            {
                case TOOLTIP_FOR_CLAN_MEMBER:
                {
                    if (CityMgr.getInstance().guiClan.isShowing)
                    {
                        CityMgr.getInstance().guiClan.guiJoinClan.onClanActionClick(param1);
                    }
                    else if (CityMgr.getInstance().guiRanking.isShowing)
                    {
                        CityMgr.getInstance().guiRanking.guiJoinClan.onClanActionClick(param1);
                    }
                    break;
                }
                case TOOLTIP_FOR_PLAYER:
                {
                    CityMgr.getInstance().guiRanking.guiTopPlayers.onActionClick(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function showBgToolTip() : void
        {
            this.imageToolTip1.visible = false;
            this.imageToolTip2.visible = false;
            this.imageToolTip3.visible = false;
            this.imageToolTip4.visible = false;
            switch(this.listItem.length)
            {
                case 1:
                {
                    this.imageToolTip1.visible = true;
                    break;
                }
                case 2:
                {
                    this.imageToolTip2.visible = true;
                    break;
                }
                case 3:
                {
                    this.imageToolTip3.visible = true;
                    break;
                }
                case 4:
                {
                    this.imageToolTip4.visible = true;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function reArrangeItems() : void
        {
            var _loc_5:ClanMemberToolTipAction = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            this.showBgToolTip();
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            var _loc_3:* = (this.listItem.length - 1) * _loc_2;
            _loc_1 = 0;
            while (_loc_1 < this.listItem.length)
            {
                
                _loc_3 = _loc_3 + this.listItem[_loc_1].heightBg;
                _loc_1++;
            }
            var _loc_4:* = (this.heightBg - _loc_3) / 2;
            _loc_1 = 0;
            while (_loc_1 < this.listItem.length)
            {
                
                _loc_5 = this.listItem[_loc_1];
                _loc_6 = 10 + (this.widthBg - _loc_5.widthBg) / 2;
                _loc_7 = _loc_4 + (this.listItem[_loc_1].heightBg + _loc_2) * _loc_1;
                _loc_5.setPos(_loc_6, _loc_7);
                _loc_1++;
            }
            this.labelName.y = this.listItem[0].getPos().y - this.labelName.textHeight - 15;
            return;
        }// end function

    }
}
