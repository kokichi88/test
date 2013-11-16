package modules.city.graphics.clan
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import gameData.clan.*;
    import modules.city.*;
    import resMgr.*;
    import utility.*;

    public class GuiDetailClan extends BaseGui
    {
        public var labelJoin:TextField;
        public var labelClanName:TextField;
        public var labelToatlPoints:TextField;
        public var labelMember:TextField;
        public var labelType:TextField;
        public var labelRequiredTropies:TextField;
        public var labelDescription:TextField;
        public var isMyClan:Boolean;
        private var clanId:int;
        public var bmpJoin:BitmapButton;
        public var bmpEdit:BitmapButton;
        public var labelEdit:TextField;
        public var imageBgIcon:MovieClip;
        public var guiToolTip:GuiClanMemberToolTip;
        private var clanSymbol:Sprite = null;
        public static var BMP_JOIN:String = "bmpJoin";
        public static var BMP_EDIT:String = "bmpEdit";

        public function GuiDetailClan()
        {
            super(ResMgr.getInstance().getMovieClip("ClanInfoGui"));
            return;
        }// end function

        public function setClanDetail(param1:ClanInfo) : void
        {
            var _loc_2:* = GameDataMgr.getInstance().getClanId();
            this.clanId = param1.clanId;
            this.isMyClan = _loc_2 == param1.clanId;
            this.bmpEdit.visible = false;
            this.labelEdit.visible = false;
            if (!this.isMyClan)
            {
                this.labelJoin.text = "VÀO BANG";
                this.bmpJoin.enable = _loc_2 == 0;
                if (GameDataMgr.getInstance().myInfo.trophy < param1.requiredTrophy || param1.memberSize == GlobalVar.CLAN_MAX_MEMBERS)
                {
                    this.bmpJoin.enable = false;
                }
            }
            else
            {
                if (GameDataMgr.getInstance().clanCastle.title == GlobalVar.CLAN_LEADER)
                {
                    this.bmpEdit.visible = true;
                    this.labelEdit.visible = true;
                }
                this.labelJoin.text = "RỜI BANG";
            }
            this.labelClanName.text = param1.name.toUpperCase();
            this.labelToatlPoints.text = param1.trophy.toString();
            this.labelMember.text = param1.memberSize + "/" + GlobalVar.CLAN_MAX_MEMBERS;
            this.labelType.text = Localization.getInstance().getString("ClanType" + (param1.type - 1));
            this.labelRequiredTropies.text = param1.requiredTrophy.toString();
            this.labelDescription.text = param1.description;
            if (this.clanSymbol && this.clanSymbol.parent != null)
            {
                this.clanSymbol.parent.removeChild(this.clanSymbol);
                this.clanSymbol = null;
            }
            this.clanSymbol = ResMgr.getInstance().getMovieClip("ClanSymbol_" + param1.icon);
            this.clanSymbol.x = this.imageBgIcon.x + (this.imageBgIcon.width - this.clanSymbol.width) / 2;
            this.clanSymbol.y = this.imageBgIcon.y + (this.imageBgIcon.height - this.clanSymbol.height) / 2;
            this.img.addChild(this.clanSymbol);
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            var _loc_3:String = null;
            var _loc_4:String = null;
            switch(param1)
            {
                case BMP_JOIN:
                {
                    if (this.isMyClan)
                    {
                        _loc_3 = Localization.getInstance().getString("Title_TB");
                        _loc_4 = Localization.getInstance().getString("ClanMsg5");
                        _loc_4 = _loc_4.replace("@name", "");
                        CityMgr.getInstance().guiPopup.showMessageBox(_loc_3, _loc_4, "ĐỒNG Ý", CityMgr.getInstance().sendLeaveClan);
                    }
                    else
                    {
                        CityMgr.getInstance().sendJoinClan(this.clanId);
                    }
                    break;
                }
                case BMP_EDIT:
                {
                    CityMgr.getInstance().guiClan.showEditClan();
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
