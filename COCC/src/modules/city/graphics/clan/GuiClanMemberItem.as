package modules.city.graphics.clan
{
    import component.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import gameData.clan.*;
    import modules.city.*;
    import resMgr.*;
    import utility.*;

    public class GuiClanMemberItem extends BaseGui
    {
        public var labelRank:TextField;
        public var labelMemberName:TextField;
        public var labelClanPosition:TextField;
        public var labelTrophy:TextField;
        public var labelLevel:TextField;
        public var labelTroopsDonate:TextField;
        public var labelTroopsReceive:TextField;
        public var bmpClanMember:BitmapButton;
        public var info:ClanMemberInfo;
        public var index:int;

        public function GuiClanMemberItem()
        {
            super(ResMgr.getInstance().getMovieClip("ClanMemberItemGui"));
            return;
        }// end function

        public function setInfo(param1:int, param2:ClanMemberInfo) : void
        {
            this.index = param1 - 1;
            this.info = param2;
            this.labelRank.text = param1.toString();
            this.labelMemberName.text = this.info.name;
            this.labelLevel.text = this.info.level.toString();
            this.labelTrophy.text = this.info.trophy.toString();
            var _loc_3:* = this.info.clanTitle == GlobalVar.CLAN_LEADER ? ("#CC3300") : ("#663300");
            this.labelClanPosition.htmlText = "<font color=\'" + _loc_3 + "\'>" + Localization.getInstance().getString("ClanTitle" + this.info.clanTitle) + "</font>";
            this.labelTroopsDonate.text = this.info.troopsDonate.toString();
            this.labelTroopsReceive.text = this.info.troopsReceive.toString();
            if (GameDataMgr.getInstance().myInfo.uId == param2.uId)
            {
                this.bmpClanMember.visible = false;
            }
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            if (CityMgr.getInstance().guiClan.isShowing)
            {
                CityMgr.getInstance().guiClan.guiJoinClan.onItemClick(this.index);
            }
            else if (CityMgr.getInstance().guiRanking.isShowing)
            {
                CityMgr.getInstance().guiRanking.guiJoinClan.onItemClick(this.index);
            }
            return;
        }// end function

    }
}
