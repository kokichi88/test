package modules.city.graphics.clan
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import modules.city.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class GuiRebuildClan extends BaseGui
    {
        public var bmpRebuild:BitmapButton;
        public var labelTitle:TextField;
        public var labelMessage:TextField;
        public var labelMoney:TextField;
        private static var BMP_CLOSE:String = "bmpClose";
        private static var BMP_REBUILD:String = "bmpRebuild";

        public function GuiRebuildClan()
        {
            super(ResMgr.getInstance().getMovieClip("RebuildClanGui"));
            autoAlign = AUTO_ALIGN_CENTER;
            return;
        }// end function

        public function loadInfo() : void
        {
            var _loc_1:* = Utility.getInfoToBuild(BuildingType.CLAN_CASTLE, 1);
            this.labelTitle.text = "THÔNG BÁO";
            this.labelMessage.text = Localization.getInstance().getString("ClanMsg3");
            this.labelMoney.text = Utility.standardNumber(_loc_1.cost.value);
            var _loc_2:* = GameDataMgr.getInstance().getMoney(MoneyType.GOLD) >= _loc_1.cost.value;
            this.labelMoney.textColor = _loc_2 ? (16777215) : (16728128);
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            this.loadInfo();
            super.show(param1, param2);
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_CLOSE:
                {
                    hide(true);
                    break;
                }
                case BMP_REBUILD:
                {
                    CityMgr.getInstance().confirmRebuild();
                    hide(true);
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
