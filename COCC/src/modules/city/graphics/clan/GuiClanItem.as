package modules.city.graphics.clan
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.clan.*;
    import modules.city.*;
    import resMgr.*;
    import utility.*;

    public class GuiClanItem extends BaseGui
    {
        public var index:int;
        public var info:ClanInfo;
        public var labelClanName:TextField;
        public var labelClanType:TextField;
        public var labelClanMembers:TextField;
        public var labelTrophy:TextField;
        public var imageBgClanIconSmall:MovieClip;
        private static const BMP_DETAIL:String = "bmpViewClanDetail";

        public function GuiClanItem()
        {
            super(ResMgr.getInstance().getMovieClip("ClanItemGui"));
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_DETAIL:
                {
                    CityMgr.getInstance().showDetailClan(this.info.clanId);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function setInfo(param1:int, param2:ClanInfo) : void
        {
            this.index = param1;
            this.info = param2;
            this.labelClanName.text = this.info.name.toUpperCase();
            this.labelClanType.text = Localization.getInstance().getString("ClanType" + (this.info.type - 1));
            this.labelClanMembers.text = Localization.getInstance().getString("ClanMember") + " " + this.info.memberSize + "/" + GlobalVar.CLAN_MAX_MEMBERS;
            this.labelTrophy.text = this.info.trophy.toString();
            var _loc_3:* = ResMgr.getInstance().getMovieClip("ClanSymbol_Small_" + this.info.icon) as Sprite;
            _loc_3.x = this.imageBgClanIconSmall.x + (this.imageBgClanIconSmall.width - _loc_3.width) / 2;
            _loc_3.y = this.imageBgClanIconSmall.y + (this.imageBgClanIconSmall.height - _loc_3.height) / 2;
            this.img.addChild(_loc_3);
            return;
        }// end function

    }
}
